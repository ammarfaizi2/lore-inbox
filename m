Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbUKBWgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbUKBWgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbUKBWgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:36:33 -0500
Received: from fmr04.intel.com ([143.183.121.6]:7088 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262424AbUKBWep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:34:45 -0500
Message-Id: <200411022230.iA2MUxq18736@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Theurer'" <habanero@us.ibm.com>, <kernel@kolivas.org>,
       <ricklind@us.ibm.com>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH] sched: aggressive idle balance
Date: Tue, 2 Nov 2004 14:34:31 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcTBGQamiIpc72EvSHmRPO0laO+SkAAEL6sA
In-Reply-To: <200411021416.38119.habanero@us.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Theurer wrote on Tuesday, November 02, 2004 12:17 PM
>
> This patch allows more aggressive idle balances, reducing idle time in
> scenarios where should not be any, where nr_running > nr_cpus.  We have seen
> this in a couple of online transaction workloads.  Three areas are targeted:
>
> 1) In try_to_wake_up(), wake_idle() is called to move the task to a sibling if
> the task->cpu is busy and the sibling is idle.  This has been expanded to any
> idle cpu, but the closest idle cpu is picked first by starting with cpu->sd,
> then going up the domains as necessary.

It occurs to me that half of the patch only applicable to HT, like the change
in wake_idle().  And also, do you really want to put that functionality in
wake_idle()?  Seems defeating the original intention of that function, which
only tries to wake up sibling cpu as far as how I understand the code.

My setup is 4-way SMP, no HT (4-way itanium2 processor), sorry, I won't be able
to tell you how this portion of the change affect online transaction workload.

- Ken


