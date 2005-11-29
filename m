Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVK2XMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVK2XMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVK2XMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:12:19 -0500
Received: from fmr21.intel.com ([143.183.121.13]:26305 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S964805AbVK2XMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:12:17 -0500
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
	conditions
From: Rohit Seth <rohit.seth@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, clameter@engr.sgi.com, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, steiner@sgi.com,
       nickpiggin@yahoo.com.au
In-Reply-To: <20051123190237.3ba62bf0.pj@sgi.com>
References: <20051122161000.A22430@unix-os.sc.intel.com>
	 <Pine.LNX.4.62.0511231128090.22710@schroedinger.engr.sgi.com>
	 <1132775194.25086.54.camel@akash.sc.intel.com>
	 <20051123115545.69087adf.akpm@osdl.org>
	 <1132779605.25086.69.camel@akash.sc.intel.com>
	 <20051123190237.3ba62bf0.pj@sgi.com>
Content-Type: text/plain
Organization: Intel 
Date: Tue, 29 Nov 2005 15:18:56 -0800
Message-Id: <1133306336.24962.47.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Nov 2005 23:11:59.0958 (UTC) FILETIME=[4D0DB760:01C5F53A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 19:02 -0800, Paul Jackson wrote:
> Rohit wrote:
> > I thought Nick et.al came up with some of the constant values like batch
> > size to tackle the page coloring issue specifically. 
> 
> I think this came about on a linux-ia64 thread started by Jack Steiner:
> 
>   http://www.gelato.unsw.edu.au/archives/linux-ia64/0504/13668.html
>   Subject: per_cpu_pagesets degrades MPI performance
>   From: Jack Steiner <steiner_at_sgi.com>
>   Date: 2005-04-05 05:28:27
> 
> Jack reported that per_cpu_pagesets were degrading some MPI benchmarks due
> to adverse page coloring.  Nick responded, recommending a non-power of two
> batch size.  Jack found that this helped nicely.  This thread trails off,
> but seems to be the origins of the 2**n-1 batch size in:
> 
> 	mm/page_alloc.c:zone_batchsize()
> 	 * Clamp the batch to a 2^n - 1 value. Having a power ...
>         batch = (1 << fls(batch + batch/2)) - 1;
> 
> I don't see here evidence that "per_cpu_pagelist is ... one single main
> reason the coloring effect is drastically reduced in 2.6 (over 2.4)
> based kernels."  Rather in this case anyway a batch size not a power of
> two was apparently needed to keep per_cpu_pagesets from hurting
> performance due to page coloring affects on some workloads.
> 

Well, the batch size of a list ( + the high mark) are integral part of
per_cpu_pagelist infrastructure.  Tuning is always required.  I don't
think though one fixed set of values is fixing all the cases.  

Can you please comment on the performance delta on the MPI workload
because of this change in batch values.  And what were the numbers
before per_cpu_pagelists were introduced.

thanks,
-rohit


