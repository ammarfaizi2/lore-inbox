Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132445AbRBEAWi>; Sun, 4 Feb 2001 19:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132523AbRBEAW2>; Sun, 4 Feb 2001 19:22:28 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:58306 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S132445AbRBEAWL>; Sun, 4 Feb 2001 19:22:11 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Mohit Aron" <aron@Zambeel.com>, <linux-kernel@vger.kernel.org>
Subject: RE: system call sched_yield() doesn't work on Linux 2.2
Date: Sun, 4 Feb 2001 16:21:16 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKAEKINHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <2B8089144916D411896D00D0B73C8353DB2C1D@exchange.zambeel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What version of Linux are you using ? What I see is the following:

	I'm using 2.4.1-pre10, glibc 2.1.3.

> 	Thread1
> 	Thread1
> 	Thread1
> 	Thread1
> 	Thread1
> 	Thread2
> 	Thread2
> 	Thread2
> 	Thread2
> 	Thread2

	That's totally reasonable, although you probably just forgot to fflush.

	It's also possible Thread1 did all its work, yields and all, before Thread2
even got started. Thus Thread1 had no 'ready to run' thread to yield to.
(The main thread may not have been ready to run, it may still have been
waiting to synchronize to the new thread it created.)

> Also, it is NOT unrealistic to expect perfect alternation.

	Find one pthreads expert who agrees with this claim. Post it to
comp.programming.threads and let the guys who created the standard laugh at
you. Scheduling is not a substitute for synchronization, ever.

> The definition
> of sched_yield in the manpage says that sched_yield() puts the
> thread under
> question last in the run queue. So perfect alternation should
> have occurred.

	Your reasoning is totally invalid and ignores so many possible other
factors. For example, who says that the writes that your threads are doing
don't block?

> I've also tested the code on Solaris - there is perfect alternation there.

	I'm not sure I understand what this has to do with anything. If you think
so, then I don't think you appreciate with a standard actually is. Perfect
alternation is reasonable, expecting perfect alternation is not. Probably
the reason you got perfect alternation in Solaris is because you only had
one kernel execution vehicle. Try it with system contention scope threads.

	DS


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
