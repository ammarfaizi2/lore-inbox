Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130802AbRABOgt>; Tue, 2 Jan 2001 09:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130882AbRABOgj>; Tue, 2 Jan 2001 09:36:39 -0500
Received: from linuxcare.com.au ([203.29.91.49]:45067 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130802AbRABOgU>; Tue, 2 Jan 2001 09:36:20 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Wed, 3 Jan 2001 01:01:03 +1100
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
Message-ID: <20010103010103.D18056@linuxcare.com>
In-Reply-To: <Pine.Linu.4.10.10101020857530.1024-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.Linu.4.10.10101020857530.1024-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Tue, Jan 02, 2001 at 09:27:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi Mike,

> I am seeing (what I believe is;) severe process CPU starvation in
> 2.4.0-prerelease.  At first, I attributed it to semaphore troubles
> as when I enable semaphore deadlock detection in IKD and set it to
> 5 seconds, it triggers 100% of the time on nscd when I do sequential
> I/O (iozone eg).  In the meantime, I've done a slew of tracing, and
> I think the holder of the semaphore I'm timing out on just flat isn't
> being scheduled so it can release it.  In the usual case of nscd, I
> _think_ it's another nscd holding the semaphore.  In no trace can I
> go back far enough to catch the taker of the semaphore or any user
> task other than iozone running between __down() time and timeout 5
> seconds later.  (trace buffer covers ~8 seconds of kernel time)

Did this just appear in recent kernels? Maybe bdflush was hiding the
situation in earlier kernels as it would cause io hogs to block when
things got only mildly interesting.

You might be able to get some useful information with ps axl and checking
the WCHAN value. Of course it wont be possible if like nscd you cant get
ps to schedule :)

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
