Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267025AbTATVuj>; Mon, 20 Jan 2003 16:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbTATVuj>; Mon, 20 Jan 2003 16:50:39 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:39577 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267025AbTATVui>;
	Mon, 20 Jan 2003 16:50:38 -0500
Message-ID: <3E2C713E.2050301@colorfullife.com>
Date: Mon, 20 Jan 2003 22:59:26 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.59-D7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:

>--- linux/fs/pipe.c.orig	2003-01-20 19:28:43.000000000 +0100
>+++ linux/fs/pipe.c	2003-01-20 22:58:35.000000000 +0100
>@@ -117,7 +117,7 @@
> 	up(PIPE_SEM(*inode));
> 	/* Signal writers asynchronously that there is more room.  */
> 	if (do_wakeup) {
>-		wake_up_interruptible(PIPE_WAIT(*inode));
>+		wake_up_interruptible_sync(PIPE_WAIT(*inode));
> 		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
> 	}
> 	if (ret > 0)
>
What's the purpose of this change?
I thought that the _sync functions should be called if it's guaranteed 
that schedule() will be called immediately, i.e. if the scheduler should 
not rebalance.
You've added _sync() to the codepaths that lead to the end of the syscall.

--
    Manfred

