Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262745AbSJCFpc>; Thu, 3 Oct 2002 01:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262746AbSJCFpb>; Thu, 3 Oct 2002 01:45:31 -0400
Received: from mail.ccur.com ([208.248.32.212]:38412 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S262745AbSJCFp3>;
	Thu, 3 Oct 2002 01:45:29 -0400
Message-ID: <3D9BDAAA.B31E0D48@ccur.com>
Date: Thu, 03 Oct 2002 01:50:34 -0400
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Jim Houston <jim.houston@attbi.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: O(1) Scheduler (tuning problem/live-lock)
References: <200209061844.g86IiF701825@linux.local> <20020930161019.GH1235@dualathlon.random> <3D994CD9.3FDFA09F@ccur.com> <20021002064559.GB1158@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea, Ingo,

Andrea, I tried your second patch.  Again, it keeps on running even with
"waitpid06 -c 16 -i 10000".  This is good.  It still has some jerky
mouse behavior (under this load).  This is on an old slow Pentium Pro
dual processor.  If I grab a window and move it around for several
seconds, the screen will freeze for a couple seconds.  I suspect that
my X server fails the TASK_INTERACTIVE test.

I have been hacking at sched.c myself trying to avoid the array switch
entirely.  I'm trying to set up a self-tuning feedback mechanism to
adjust priorities so everything gets some cpu time without 
having to do the array switch.  I'm juggling these ideas:

	1. Gradually raise the priority of all the processes in
	   the run queue.  Do this without having to visit all
	   of the processes.

	2. When a process uses up its time slice, move it to a 
	   less favorable priority.

	3. Tune the sleep_avg.  I like the old decaying average
	   approach of old unix systems.  The current sleep_avg
	   goes to saturation too often.  I would like to
	   be able to tell if a process has been using more than
	   its share of the cpu time.

	4. Make the maximum time slice decrease with more favorable
	   priorities.  The time slice would depend on the dynamic
	   priority.

I have code hacked together for first idea but its not useful without
the rest.

Jim Houston - Concurrent Computer Corp.
