Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129275AbRBEH2E>; Mon, 5 Feb 2001 02:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129338AbRBEH1z>; Mon, 5 Feb 2001 02:27:55 -0500
Received: from [63.89.188.10] ([63.89.188.10]:61458 "EHLO xchange.zambeel.com")
	by vger.kernel.org with ESMTP id <S129275AbRBEH1p>;
	Mon, 5 Feb 2001 02:27:45 -0500
Message-ID: <2B8089144916D411896D00D0B73C8353DB2C21@exchange.zambeel.com>
From: Mohit Aron <aron@Zambeel.com>
To: "'Matt'" <matt@progsoc.uts.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: RE: system call sched_yield() doesn't work on Linux 2.2
Date: Sun, 4 Feb 2001 23:27:35 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for a reasonable/thoughtful reply.

>	to expect perfect alternation is not reasonable. the scheduler
> (or one of its subsidiary and/or supporting functions) decides what
> should run and what shouldn't. the linux scheduler did have problems
> in 2.2 (and still does in some places). however last i checked
> sched_yield() is at best a hint to the scheduler not a command. the
> man page even suggests this. it says that if the process (or thread)
> yields and if it is the highest priority task at the time it will be
> re-run. so you can not guarantee that it will not re-run. this i think
> was the point david was trying to make (albiet with some possibly
> misplaced "fervour").

It looks like what you're saying above is that the scheduling 
priority of a thread might be changed dynamically by the scheduler. 
Hence, even though it called sched_yield(), its resulting priority might 
still be higher than the other thread and hence there may not be 
perfect alternation. This makes sense.

However, I just had a chance to run my program on a Linux 2.4 kernel. 
I got almost perfect alternation every time I ran it. The output was:

	Thread1
	Thread1
	Thread2
	Thread1
	Thread2
	Thread1
	Thread2
	Thread1
	Thread2
	Thread2

Basically, the first thread prints twice in the beginning but after
that there's perfect alternation. This might however be because of
startup delays in Thread2.

I might add that I've tested my program on two other operating systems - 
Solaris 2.7 and DUNIX V4.0D. In both I got perfect alternation every
time I ran the program. And with Linux 2.4 there was "almost" perfect
alternation.


- Mohit
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
