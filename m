Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268497AbUI2O2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268497AbUI2O2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268524AbUI2O14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:27:56 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:59737 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268497AbUI2O0A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:26:00 -0400
Subject: Re: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <200409291607.07493.roland.cassebohm@visionsystems.de>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <200409291509.39187.roland.cassebohm@visionsystems.de>
	 <415AB5E1.8060406@microgate.com>
	 <200409291607.07493.roland.cassebohm@visionsystems.de>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1096467951.1964.22.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 09:25:51 -0500
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 09:07, Roland Caßebohm wrote:
> I have added a routine to "struct tty_driver" for restarting 
> the RX interrupt after TTY_DONT_FLIP bit is cleared in 
> read_chan().

If you are using RTS/CTS flow control,
your scheme might prevent data loss if you also
drop RTS (like driver throttle method) when disabling
the rx IRQ and reasserting RTS (unthrottle) when
reenabling the IRQ. Unfortunately, this may interfere
with the line discipline's use of throttle/unthrottle.

> It seems to take to long time in read_chan(). Do you now what 
> is the exact reason of locking the filp buffer with the 
> TTY_DONT_FLIP flag? For a short look I would say the buffers 
> are safe locked by the spinlock tty->read_lock.

I can't identify the reason.
If you feel brave, remove the setting/clearing
of TTY_DONT_FLIP and see what happens.

-- 
Paul Fulghum
paulkf@microgate.com

