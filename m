Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132278AbRARWFN>; Thu, 18 Jan 2001 17:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132754AbRARWFD>; Thu, 18 Jan 2001 17:05:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4111 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132278AbRARWE5>;
	Thu, 18 Jan 2001 17:04:57 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101182150.f0ILoFp30979@flint.arm.linux.org.uk>
Subject: Re: console spin_lock
To: andrewm@uow.edu.au (Andrew Morton)
Date: Thu, 18 Jan 2001 21:50:15 +0000 (GMT)
Cc: jsimmons@suse.com (James Simmons),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        linux-fbdev@vuser.vu.union.edu (FrameBuffer List),
        linuxconsole-dev@lists.sourceforge.net (Linux console project)
In-Reply-To: <3A66E4D3.B2BEFCBB@uow.edu.au> from "Andrew Morton" at Jan 18, 2001 11:42:59 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> The subtler problem will be interrupt-capable drivers which
> do a bare spin_lock() to serialise wrt their interrupt routines,
> relying upon interrupts being disabled.  They'll be deadlocky
> and will need changing.  That's trivial to find and fix though.

Uhh, what if you have this situation:

interrupt (level triggered)
 enter interrupt handler
   printk (can re-enable interrupts?)
     enter interrupt handler
       printk (can re-enable interrupts?)
         enter interrupt handler
           printk (can re-enable interrupts?)
             ....

So surely this isn't a new problem?
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
