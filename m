Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264262AbRFSPJt>; Tue, 19 Jun 2001 11:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264278AbRFSPJj>; Tue, 19 Jun 2001 11:09:39 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:42641 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S264262AbRFSPJa>; Tue, 19 Jun 2001 11:09:30 -0400
Date: Tue, 19 Jun 2001 11:23:26 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: Simone Piunno <simonep@wseurope.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: compiling with gcc 3.0
In-Reply-To: <20010619170235.C2593@pioppo.wired>
Message-ID: <Pine.LNX.4.31.0106191120450.1531-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001, Simone Piunno wrote:

> I was trying to compile 2.4.5 with gcc 3.0 but there is a problem
> (conflicting type) between kernel/timer.c and include/linux/sched.h
> Apparently the problem solves with this oneline workarond:
>
> --- linux/include/linux/sched.h Tue Jun 19 17:00:03 2001
> +++ linux/include/linux/sched.h.orig    Tue Jun 19 17:00:13 2001

[short patch snipped]

> don't know if this is the right approach but works for me.

The approach was right, but your argument order to diff was backwards.
Andrea posted this patch a little while ago:


--- 2.4.6pre2aa1/include/linux/sched.h.~1~	Wed Jun 13 00:44:45 2001
+++ 2.4.6pre2aa1/include/linux/sched.h	Wed Jun 13 00:47:23 2001
@@ -541,7 +541,7 @@
 extern unsigned long volatile jiffies;
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
-extern struct timeval xtime;
+extern volatile struct timeval xtime;
 extern void do_timer(struct pt_regs *);

 extern unsigned int * prof_buffer;

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

