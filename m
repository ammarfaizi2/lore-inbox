Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751923AbWAEWdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWAEWdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWAEWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:33:24 -0500
Received: from fmr21.intel.com ([143.183.121.13]:51646 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751923AbWAEWdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:33:19 -0500
Message-Id: <200601052233.k05MX4g15045@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <hawkes@sgi.com>, "Tony Luck" <tony.luck@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Cc: "Jack Steiner" <steiner@sgi.com>, "Dan Higgins" <djh@sgi.com>,
       "John Hesterberg" <jh@sgi.com>, "Greg Edwards" <edwardsg@sgi.com>
Subject: RE: [PATCH] ia64: change defconfig to NR_CPUS==1024
Date: Thu, 5 Jan 2006 14:33:04 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYSQVqpXyPLmHDqTweQolTh39gWqgABOelg
In-Reply-To: <20060105213948.11412.45463.sendpatchset@tomahawk.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hawkes@sgi.com wrote on Thursday, January 05, 2006 1:40 PM
> The downside is that the ia64 cpumask increases from 8 words to 16.
> I have tried various heavy workloads and have seen no significant
> measurable performance regression from this increase.

What type of heavy workloads have you measured? Including db transaction
processing and decision making workloads?

> The potential
> extra cachemiss seems to be lost in the noise.  The for_each_*cpu()
> macros are relatively efficient in skipping past zeroed cpumask bits.
> Workloads that impose higher loads on the CPU Scheduler tend to
> bottleneck on non-Scheduler parts of the kernel, and it's the Scheduler
> which makes the principal use of the cpumask_t, so these extra
> cachemiss inefficiencies and extra CPU cycles to scan zero mask words
> just get lost in the general system overhead.

I found above claims are generally false for workload that puts tons
of pressure on CPU cache, especially with db workload.  Typically
for db workload, the working set in user space is so large that making
a trip into the kernel has far large secondary effect then the primary
cache miss occurred in the kernel.  In other word, cache lines evicted
by the kernel code have far larger impact to the overall application
performance and leads to lower overall lower system performance.  So
when you say "get lost in the general system overhead", did you consider
the secondary effect it does to the application performance?

What we found is going from NR_CPU = 64 to 128, it has small performance
impact to db transaction processing workload.  Though I have not measured
difference between 128 to 1024.

- Ken

