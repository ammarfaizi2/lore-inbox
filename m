Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRCBTn3>; Fri, 2 Mar 2001 14:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRCBTnU>; Fri, 2 Mar 2001 14:43:20 -0500
Received: from www0a.netaddress.usa.net ([204.68.24.30]:17622 "HELO
	www0a.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S129468AbRCBTnG> convert rfc822-to-8bit; Fri, 2 Mar 2001 14:43:06 -0500
Message-ID: <20010302194303.14346.qmail@www0a.netaddress.usa.net>
Date: 2 Mar 2001 13:43:03 CST
From: Neelam Saboo <neelam_saboo@usa.net>
To: Manfred Spraul <manfred@colorfullife.com>, neelam_saboo@usa.net
Subject: [Re: paging behavior in Linux]
CC: linux-kernel@vger.kernel.org
X-Mailer: USANET web-mailer (34FM.0700.16.05)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

After I installed a newer version of Kernel (2.4.2) and enable DMA option in
hardware configuration, the behavior changes.
I can see performance improvements when another thread is used. Also, i can
see timing overlaps between two threads. i.e. when one thread is blocked on a
page fault, other thread keeps working.
Now, how can this behavior be explained , given the earlier argument.
Is it that, a newer version of kernel has fixed the problem of the semaphore
?

thanks
neelam

> That's a known problem:
> 
> The paging io for a process is controlled with a per-process semaphore.
> The semaphore is held while waiting for the actual io. Thus the paging
> in multi threaded applications is single threaded.
> Probably your prefetch thread is waiting for disk io, and the worker
> thread causes a minor pagefault --> worker thread sleeps until the disk
> io is completed.
> 
> --
> 	Manfred


____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
