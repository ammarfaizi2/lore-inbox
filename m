Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269173AbUI3UdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269173AbUI3UdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269240AbUI3UcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:32:10 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:40816 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269173AbUI3Ua2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:30:28 -0400
Subject: Re: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096574739.1938.142.camel@deimos.microgate.com>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <200409291607.07493.roland.cassebohm@visionsystems.de>
	 <1096467951.1964.22.camel@deimos.microgate.com>
	 <200409301816.44649.roland.cassebohm@visionsystems.de>
	 <1096571398.1938.112.camel@deimos.microgate.com>
	 <1096569273.19487.46.camel@localhost.localdomain>
	 <1096573912.1938.136.camel@deimos.microgate.com>
	 <20040930205922.F5892@flint.arm.linux.org.uk>
	 <1096574739.1938.142.camel@deimos.microgate.com>
Content-Type: text/plain
Message-Id: <1096576200.1938.154.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Sep 2004 15:30:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 15:05, Paul Fulghum wrote:
> My statement of 'most drivers' is wrong.
> I should have said 'some drivers'
> including 2.4 serial.c and the 8250/serial of 2.6

Specifically it is the use of this code fragment
in the ISR of serial.c (2.4) and the various
drivers in driver/serial of 2.6:

if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
	tty->flip.work.func((void *)tty);
	if (tty->flip.count >= TTY_FLIPBUF_SIZE)
		return; // if TTY_DONT_FLIP is set
}

in 2.4 it is

if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
	tty->flip.tqueue.routine((void *) tty);
	if (tty->flip.count >= TTY_FLIPBUF_SIZE)
		return;		// if TTY_DONT_FLIP is set
}

tty->flip.work.func and tty->flip.tqueue.routine
are set to flush_to_ldisc()

-- 
Paul Fulghum
paulkf@microgate.com

