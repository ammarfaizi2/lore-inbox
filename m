Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWBABKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWBABKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 20:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWBABKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 20:10:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751332AbWBABKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 20:10:19 -0500
Date: Tue, 31 Jan 2006 17:12:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: suresh.b.siddha@intel.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       ak@suse.de, linux-kernel@vger.kernel.org, rohit.seth@intel.com,
       asit.k.mallick@intel.com
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Message-Id: <20060131171216.449b9e06.akpm@osdl.org>
In-Reply-To: <20060130172809.A4851@unix-os.sc.intel.com>
References: <20060126015132.A8521@unix-os.sc.intel.com>
	<20060127000854.GA16332@elte.hu>
	<20060126195156.E19789@unix-os.sc.intel.com>
	<20060127160019.64caa6be.akpm@osdl.org>
	<20060130172809.A4851@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>
> > Perhaps we should just make SMT and MC disjoint in Kconfig.  Your call.
> 
> No. SMT and MC are not disjoint.

It's still not clear what's supposed to be happening here.

In build_sched_domains() we still have code which does:


	for_each_cpu_mask(...) {
		...
#ifdef CONFIG_SCHED_MC
		...
#endif
#ifdef CONFIG_SCHED_SMT
		...
#endif
		...
	}
	...
#ifdef CONFIG_SCHED_SMT
	...
#endif
	...
#ifdef CONFIG_SCHED_MC
	...
#endif

So in the first case the SCHED_SMT code will win and in the second case the
SCHED_MC code will win.  I think.  The code is so repetitive in there that
`patch' may have put the hunks in the wrong place.

What is the design intention here?  What do we _want_ to happen if both MC
and SMT are enabled?



Also the path tests CONFIG_SCHED_MT in a few places where it meant to use
CONFIG_SCHED_SMT, which rather casts doubt upon the testing quality.

