Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUFDS3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUFDS3m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265916AbUFDS3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:29:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:63366 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265910AbUFDS3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:29:40 -0400
Date: Fri, 4 Jun 2004 11:27:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: pj@sgi.com, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604112730.534cca55.akpm@osdl.org>
In-Reply-To: <20040604181233.GF21007@holomorphy.com>
References: <16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604093712.GU21007@holomorphy.com>
	<16576.17673.548349.36588@alkaid.it.uu.se>
	<20040604095929.GX21007@holomorphy.com>
	<16576.23059.490262.610771@alkaid.it.uu.se>
	<20040604112744.GZ21007@holomorphy.com>
	<20040604113252.GA21007@holomorphy.com>
	<20040604092316.3ab91e36.pj@sgi.com>
	<20040604162853.GB21007@holomorphy.com>
	<20040604104756.472fd542.pj@sgi.com>
	<20040604181233.GF21007@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> _SC_NPROCESSOR_CONF is
>  unimplementable. NR_CPUS serves as an upper bound on the number of cpus
>  that may at some time be simultaneously present in the future.

NR_CPUS is arguably the correct thing when it comes to copying per-cpu info
to and from userspace.

Sometimes userspace wants to know NR_CPUS.  Sometimes it wants to know the
index of the max possible CPU.  Sometimes, perhaps the index of the max
online CPU.  Sometimes the max index of the CPUs upon which this task is
eligible to run.  Sometimes (lame) userspace may want to know, at compile
time, the maximum number of CPUs which a Linux kernel will ever support.

It's not completely trivial.

Which of the above is _SC_NPROCESSOR_CONF supposed to return?
