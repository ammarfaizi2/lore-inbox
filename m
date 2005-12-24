Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVLXUTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVLXUTx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 15:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVLXUTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 15:19:53 -0500
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:5765 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750715AbVLXUTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 15:19:52 -0500
Date: Sat, 24 Dec 2005 15:19:47 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: HZ_200/1000 (configurable) Timer Question
To: linux-kernel@vger.kernel.org
Message-id: <1135455587.3564.16.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at the 2.6.14 kernel (then checked back to 2.6.9 and
realized this is fairly new) and found a configurable Timer setting.
The option is under "Processor Type and Features" then "Timer
Frequency".

A quick grep of the source hasn't revealed anything obvious in terms of
where this is implemented, so I suspect i'm missing something (it would
probably be arch-specific).  

On another UNIX-based operating system, back in my employable days (late
90s), I wrote up a specification on how to implement the tunable clock
frequencies for a particular power-pc based platform (further - i
implemented it).  The timer chip that was used at the time was an i82378
(intel) chip and the internal clock ran at a frequency of 1.19318 MHz,
you just had to (at the OS/hardware-level) set the number of internal
ticks had passed before it would fire an interrupt.  This may be
completely useless, incorrect, or maybe if correct obvious information,
but this is what I have from /memory/:

(1) to determine how many ticks to tell the chip to pass before firing,
you performed elementary-school division:

	1,193,180 (i.e. #hz)
    -------------------------------------- =  Timeout value
      Configured-by-user-frequency (hz)

(2) How not to break everything in the kernel:  In the particular kernel
we used, there was just a constant value (#define HZ <value>) and that
just had to be changed.  If set correctly, everything else would work
fine.  We further gave the user the option of making (for testing
purposes) the HZ value configurable at run-time, but that would slow
down (potentially) the system since every call to get the value of HZ
would be a system call.

This /could/ be considered proprietary information, but on the other
hand, they are now using and contributing to linux, and further I was
told there was no problem talking about anything I did or learned in the
past since it's all outdated (we're talking nearly 10 years ago now).

I hope someone finds this useful.  If not, ignore me, I'm probably wrong
anyway.  i was just reviewing some of my notes and I don't know if what
I did was ever tested, used, or put into practice.  

-Rob

