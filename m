Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130225AbRACKqF>; Wed, 3 Jan 2001 05:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130306AbRACKpz>; Wed, 3 Jan 2001 05:45:55 -0500
Received: from pD9040320.dip.t-dialin.net ([217.4.3.32]:52752 "HELO
	grumbeer.hjb.de") by vger.kernel.org with SMTP id <S130225AbRACKpt>;
	Wed, 3 Jan 2001 05:45:49 -0500
Subject: Re: 2.2.18: Thread problem with smbfs
To: urban@teststation.com (Urban Widmark)
Date: Wed, 3 Jan 2001 11:16:15 +0100 (CET)
Cc: hjb@pro-linux.de (Hans-Joachim Baader), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101022126540.31967-100000@cola.svenskatest.se> from "Urban Widmark" at Jan 02, 2001 10:13:25 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010103101616.1E5D348262F@grumbeer.hjb.de>
From: hjb@pro-linux.de (Hans-Joachim Baader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Urban,

> Anyway,
> gdb is doing strange things to your testprogram on ext2 as well. Does it
> work for you? I have not been able to reproduce a gdb hang (you do know
> that there is a while(1); in main ... ;-), but it generates a lot of smbfs
> messages and in one case made smbfs stop working.

I put the while(1) there to give all threads time to do their work.
You know, it was just a quick & dirty test case.

> 	Hmm, strange. Why does it only copy one file? Looking at the last
> 	process gives a sleeping process in rt_sigsuspend, like you
> 	reported in your strace. Am I using gdb incorrectly?

I don't think so, but I'm not a gdb expert. In any case, I did test
the program on ext2 and it behaved correctly all the time. You don't
need gdb to reproduce the smbfs problems, you can also use strace.
So there's nothing wrong with gdb.

> The patch below vs 2.2.18 should remove the -512 (-ERESTARTSYS) errors.
> 
> But I don't like it at all. It blocks all signals, including SIGKILL, for
> a while. The problem is that tcp_recvmsg checks if there is a signal (any
> signal) and aborts with -ERESTARTSYS (a comment says it only cares about
> SIGURG, maybe that could be changed instead).
> 
> Could you test if this fixes the gdb problem? And try gdb with all files
> on ext2 too. For me there is no difference between that and smbfs vs a
> NT4.

It seems to work perfectly. I tested with up to 10 threads in 2
simulteneous processes with both ext2 and smbfs. I'll do further
testing in the next days.

Many thanks for fixing that.

Regards,
hjb
-- 
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
