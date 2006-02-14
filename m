Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWBNDj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWBNDj5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWBNDj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:39:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030302AbWBNDj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:39:56 -0500
Date: Mon, 13 Feb 2006 19:38:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/2] fix perf. bug in wake-up load balancing for aim7
 and db workload
Message-Id: <20060213193856.696bf1f0.akpm@osdl.org>
In-Reply-To: <200602140309.k1E394g17590@unix-os.sc.intel.com>
References: <200602140309.k1E394g17590@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> Commit d7102e95b7b9c00277562c29aad421d2d521c5f6 in linus's git tree
> 
> [PATCH] sched: filter affine wakeups
> From: Nick Piggin <nickpiggin@yahoo.com.au>
> Track the last waker CPU, and only consider wakeup-balancing if there's a
> match between current waker CPU and the previous waker CPU.  This ensures
> that there is some correlation between two subsequent wakeup events before
> we move the task.  Should help random-wakeup workloads on large SMP
> systems, by reducing the migration attempts by a factor of nr_cpus.
> 
> 
> Apparently caused more than 10% performance regression for aim7 benchmark.

Post-mortem time.   Why was it merged?

This patch was added to -mm on 8 November 2006.  Was merged into mainline
12 January 2006.  That's two months in -mm and one month in mainline.

I don't think it's reasonable to stretch the latency of scheduler patches
to even longer than three months and I doubt if that'll solve the problem.

Oh well, at least we found it.

> 
> We should back out the above commit and add a sysctl variable to control the
> behavior of load balancing in wake up path, so user can dynamically select
> a mode that best fit for the workload environment.  And kernel can achieve
> best performance in two extreme ends of incompatible workload environments.

Well I don't see any benchmark numbers in the original patch.  Just an
assertion that it "should" help something.

I'm more inclined to revert it and not add the sysctl (ugh) until we have a
good reason to do so.
