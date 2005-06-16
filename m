Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVFPP0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVFPP0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 11:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVFPP0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 11:26:08 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:57035 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261683AbVFPP0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 11:26:02 -0400
Message-ID: <42B199FF.5010705@bredband.net>
Date: Thu, 16 Jun 2005 17:25:51 +0200
From: =?ISO-8859-1?Q?Patrik_H=E4gglund?= <patrik.hagglund@bredband.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SCHED_RR/SCHED_FIFO and kernel threads?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When I use 2.6 kernels (2.6.11) and run processes whith SCHED_RR or 
SCHED_FIFO scheduling, kernel activity - in the form of kernel threads - 
gets starved. Googling gave me this thread: 
http://www.ussg.iu.edu/hypermail/linux/kernel/0411.1/0182.html, which 
discuss the topic brifely.

As I remember it, using a 2.4 (or 2.2?) kernel it was possible to run 
processes using SCHED_RR/SCHED_FIFO scheduling classes (as defined by 
the Process Scheduling option in POSIX), at different priorities, 
whitout starving console input/output. For example, in one virtual 
terminal I stared a "supervisor" shell with SCHED_FIFO at priority 20, 
and then the job tasks I wanted to "run" in other virtual terminals, now 
still with SCHED_FIFO, but with lower priorities. If the job tasks 
dead-locked or ran into infinite loops, I just switched to the 
"supervisor" shell and killed the job tasks. I think I also - as an 
alternative - started the whole X server in "supervisor mode". I this 
way, I was able to get deterministic scheduling between tasks, and was 
still able to avoid locking the machine when things went wrong.

However, using 2.6 kernels the "supervisor mode" doesn't work anymore. 
Using virtual terminals at the console, I'm unable to switch to another 
VT (using alt-F2), or switch window focus in X.

Kernel threads seems to generally be scheduled in the SCHED_OTHER class 
(with the 'migration' thread as an exception).

As I see it, "kernel activity" shall not be starved by user-space 
processes. Therefore, I was very suprised by this behaviour when I saw 
it in 2.6.11.

Can someone explain how this is supposed to work? Is this the common 
design solution used by other operating systems that use kernel threads 
and have SCHED_RR/SCHED_FIFO scheduling (i.e. other POSIX operating 
systems with kernel threads)? Was there any discussion about the design 
when this migration of kernel acitivity into threads started?

Regards,
Patrik Hägglund
