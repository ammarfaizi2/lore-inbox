Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUBCKxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 05:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUBCKxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 05:53:04 -0500
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:47788 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265966AbUBCKxA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 05:53:00 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.1 Hyperthread smart "nice" 2
Date: Tue, 3 Feb 2004 21:52:46 +1100
User-Agent: KMail/1.6
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jos Hulzink <josh@stack.nl>
References: <200401291917.42087.kernel@kolivas.org> <200402022027.10151.kernel@kolivas.org> <20040202103122.GA29402@elte.hu>
In-Reply-To: <20040202103122.GA29402@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402032152.46481.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Feb 2004 21:31, Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> > What this one does is the following; If there is a "nice" difference
> > between tasks running on logical cores of the same cpu, the more
> > "nice" one will run a proportion of time equal to the timeslice it
> > would have been given relative to the less "nice" task.  ie a nice 19
> > task running on one core and the nice 0 task running on the other core
> > will let the nice 0 task run continuously (102ms is normal timeslice)
> > and the nice 19 task will only run for the last 10ms of time the nice
> > 0 task is running. This makes for a much more balanced resource
> > distribution, gives significant preference to the higher priority
> > task, but allows them to benefit from running on both logical cores.
>
> this is a really good rule conceptually - the higher prio task will get
> at least as much raw (unshared) physical CPU slice as it would get
> without HT.

Glad you agree.

>From the anandtech website a description of the P4 Prescott (next generation 
IA32) with hyperthreading shows this with the new SSE3 instruction set:

"Finally we have the two thread synchronization instructions – monitor and 
mwait. These two instructions work hand in hand to improve Hyper Threading 
performance. The instructions work by determining whether a thread being sent 
to the core is the OS’ idle thread or other non-productive threads generated 
by device drivers and then instructing the core to worry about those threads 
after working on whatever more useful thread it is working on at the time."

At least it appears Intel are well aware of the priority problem, but full 
priority support across logical cores is not likely. However I guess these 
new instructions are probably enough to work with if someone can do the 
coding.

Con
