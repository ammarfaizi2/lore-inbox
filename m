Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130893AbQL1FYU>; Thu, 28 Dec 2000 00:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131040AbQL1FYK>; Thu, 28 Dec 2000 00:24:10 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:63453 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S130893AbQL1FYA>;
	Thu, 28 Dec 2000 00:24:00 -0500
Date: Thu, 28 Dec 2000 13:53:29 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: VM: do_try_to_free_pages failed
Message-ID: <Pine.LNX.4.30.0012281339330.30967-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.2.18, pcmcia-cs-3.1.21, Pentium 75 (100 MHz)
Toshiba 420CDS Satellite Pro laptop, 40 MB RAM

I can get this to happen reliably:

kernel: VM: do_try_to_free_pages failed for xntpd...
kernel: VM: do_try_to_free_pages failed for klogd...
last message repeated 15 times
kernel: VM: do_try_to_free_pages failed for tail...
last message repeated 15 times
kernel: VM: do_try_to_free_pages failed for init...
last message repeated 15 times
kernel: VM: do_try_to_free_pages failed for vmstat...
...
etc.

It happens when swap gets full (I have 32 MB swap); I have a particular
program that thrashes the system (balanced binary tree searching) so
there's heavy swapping going on.  Once, running 2.2.18pre23, this happened
when I wasn't looking, and when I came back the system was dead -- I'm not
sure what the message means or how long it could survive after that, but I
run apmd/noflushd, and the disk & screen were powered down.  I got the
disk to spin back up, but nothing else happened.  I just made
do_try_to_free_pages fail again under 2.2.18, but I quit & rebooted before
anything else happened.

Can enough do_try_to_free_pages failures do that?  Are they supposed to
happen at all?  Do I need to configure some out-of-memory thing?

Dr. Tom Holroyd
"I am, as I said, inspired by the biological phenomena in which
chemical forces are used in repetitious fashion to produce all
kinds of weird effects (one of which is the author)."
	-- Richard Feynman, _There's Plenty of Room at the Bottom_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
