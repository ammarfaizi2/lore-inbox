Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbTCZFMo>; Wed, 26 Mar 2003 00:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264328AbTCZFMo>; Wed, 26 Mar 2003 00:12:44 -0500
Received: from fmr02.intel.com ([192.55.52.25]:28376 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S263279AbTCZFMn> convert rfc822-to-8bit; Wed, 26 Mar 2003 00:12:43 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C780B71703C@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: How to force another (FIFO) task to yield from inside the kernel?
Date: Tue, 25 Mar 2003 21:23:53 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All

I am dealing with this problem and it is time to ask (read the source
already). I have this in the rtfutex priority inheritance code: when task A
boosts task B's priority (both FIFO), task B runs with A's priority until B
decides to stop waiting for A to finish (ie: timeout/signal). 

Then, task A goes through timer.c:process_timeout() [did not verify the
signal path yet] and gets woken up; however, I need to force B to yield to
give A a chance to run so it can boost down B to the proper place (doing the
boost down from process_timeout() is kind of a no-no).

I tried kick_if_running(), resched_task() and friends and they would work
sometimes, some not [what means it is not the right answer] - so I realized
I need to ask it to yield more convincently. The question is: how?

yield() does not work, as it assumes that the current task is the one to
yield. Is the only solution to craft another version of sys_sched_yield() to
do other tasks?

I am using 2.5.64 (the code is in http://sost.net/pub/linux/rtfutex*). Be
advised cut 4 has now some changes versus my current WIP; but the structure
is very similar (timer.c:process_timeout() calls
rtfutex.c:__rtfutex_yield_boosted() with tries to force task B to yield).

Thanks :)

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)

