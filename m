Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVFHMmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVFHMmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 08:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVFHMmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 08:42:06 -0400
Received: from pcsmail.patni.com ([203.124.139.197]:30664 "EHLO
	pcsmail.patni.com") by vger.kernel.org with ESMTP id S261160AbVFHMmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 08:42:01 -0400
Message-ID: <000e01c56c27$765c4510$5e91a8c0@patni.com>
Reply-To: "lk" <linux_kernel@patni.com>
From: "lk" <linux_kernel@patni.com>
To: "helen monte" <hzmonte@hotmail.com>, <linux-kernel@vger.kernel.org>
References: <BAY102-F24530D3EE13EBCA2B13336A0FA0@phx.gbl>
Subject: Re: How does 2.6 SMP scheduler initially assign a thread to a run queue?
Date: Wed, 8 Jun 2005 18:11:55 +0530
Organization: Patni
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> In the 2.6 kernel, there is one run queue per CPU, in case of an SMP.
> After a thread is created, how does the scheduler determine which run
> queue it goes to?  

First it forked process (child) gets the same CPU as that of parent.
forking a child gets the same CPU and later part of fork will call 
wake_up_new_task () to fetch the run-queue of the CPU and 
__activate_task () is called to move task into run-queue. 
Later rescheduling of the process may move process to another
run-queues.

>I know that once it goes to a particular run queue,
> the scheduler would try to run that thread on that CPU to take
> advantage of processor affinity; and then there would be the load
> balancing stuff.  But at the very beginning, what algorithm does the
> scheduler use to assign a newly created thread to a particulat CPU?

Child will always goes to the parent's run-queue (CPU) for the first time.

> Would the load balancing algorithm be used? Or gang scheduling?

Yes, load balancing algorithm is used. tasks will be pulled from
very busy processors to lesser busy processors.

> By the way, in an SMT/hyperthreading processor, does the latest kernel
> version assign one run queue per physical CPU, or per virtual 
> processor?
> 

one run-queue per physical CPU

regards
lk

