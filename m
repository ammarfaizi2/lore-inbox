Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUGJIam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUGJIam (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 04:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUGJIal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 04:30:41 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:61967 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266193AbUGJIa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 04:30:29 -0400
Date: Sat, 10 Jul 2004 10:30:27 +0200
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: suspend/resume success and failure report and questions
Message-ID: <20040710083027.GB27827@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi friends!

I want to report on success and failure of suspend2disk and suspend2ram.

First, here the specs of my laptop/software:
- kernel 2.6.7-mm5
- debian/sid
- acer travelmate 654LCi
- graphic: radeon mobility m7 (7500)

What is working:

- Suspend2Disk via pmdisk (echo -n disk > /sys/power/state)
	Nice thing is that it even works with uhci and ehci compiled
	into the kernel AND X running with agp and dri AND radeon
	framebuffer. So this is really nice and suprising for me.

	Interestingly, I have to stop mysql server, otherwise it wouldn't
	suspend (cannot stop tasks)

	But generally, big thanks to the pmdisk developer(s), it is
	working great! Even multiple suspend/resume cycles etc.
	Only thing I am missing is some way of post-resume script.

- partial Suspend2Ram via mem > /sys/power/state
	Here all the usb stuff has to be compile modular and has to be
	unloaded, no radeon framebuffer and no X is allowed.
	Then suspend to ram works, resume too, but the video card is 
	not initialized again. Black screen. But I can shut down.

What is not working:
- S2R
	framebuffer
	X
	usb
	restoring of video output
- general
	clock is completely wrong - where is a post-resume script (see below)

What I don't know/haven't tested till now:
- wlan drivers (orinoco)
- network drivers (b44)
- acerhk working

So now here are my questions:
- Is it possible to get S2R to the level of S2D without problems?
- is there a way to get things done BEFORE the suspend (this I managed via 
  the acpi script), but also AFTER the resume.
  I need this for fixing the clock and starting mysql and some more stuff
  probably

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
TUMBY (n.)
The involuntary abdominal gurgling which fills the silence following
someone else's intimate personal revelation.
			--- Douglas Adams, The Meaning of Liff
