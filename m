Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268135AbUI2BNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268135AbUI2BNQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 21:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbUI2BNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 21:13:16 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:15167 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268135AbUI2BNK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 21:13:10 -0400
Subject: Re: Serial driver hangs
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Roland =?ISO-8859-1?Q?Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1096409562.14082.53.camel@localhost.localdomain>
References: <200409281734.38781.roland.cassebohm@visionsystems.de>
	 <1096405831.2513.37.camel@deimos.microgate.com>
	 <20040928221600.D14747@flint.arm.linux.org.uk>
	 <1096412582.6003.8.camel@at2.pipehead.org>
	 <1096409562.14082.53.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1096420364.6003.29.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 28 Sep 2004 20:12:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 17:12, Alan Cox wrote:
> We have throttle()/unthrottle(). Drivers also know if they can't
> push data.

Yes, though these are manipulated by the ldisc
in relation to the ldisc receive buffer.
Coordinating the use of these functions between
a buffering layer (like the flip buffer) and
the ldisc would require each to have
knowledge of the other's state to know who
calls what and when (yuck).

But much of that may go away when...

> TTY_DONT_FLIP has to die.

*bang*

Until then, flushing the UART receive
FIFO and dropping the bytes (and updating
overrun stat) seems a reasonable short term
solution to stop the machine from locking up
while leaving the device in a recoverable state.

We can even mark it with *FIXME* in a comment.
That always seems to work :-)

-- 
Paul Fulghum
paulkf@microgate.com


