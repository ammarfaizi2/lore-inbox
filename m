Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUBFE56 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 23:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUBFE56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 23:57:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:44945 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266477AbUBFE54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 23:57:56 -0500
Date: Thu, 5 Feb 2004 20:59:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: lord@xfs.org, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
Message-Id: <20040205205936.5f0e3be9.akpm@osdl.org>
In-Reply-To: <20040206053927.37709591.ak@suse.de>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel>
	<20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel>
	<p73isilkm4x.fsf@verdi.suse.de>
	<4021AC9F.4090408@xfs.org>
	<20040205191240.13638135.akpm@osdl.org>
	<4021C152.3080501@xfs.org>
	<20040206053927.37709591.ak@suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Wed, 04 Feb 2004 22:06:42 -0600
> Steve Lord <lord@xfs.org> wrote:
> 
> 
> > It does look like 2.6 does better, but I don't have quite the
> > amount of memory on my laptop....
> 
> I see the problem on a 8GB x86-64 box with 2.6.2-rc1. 

I see no problem here.  I see a kernel which is designed to address a mix
of workloads only being tested for one particular workload.

> After a find / I have:
> 
>  Active / Total Objects (% used)    : 1794827 / 1804510 (99.5%)
>  Active / Total Slabs (% used)      : 125647 / 125647 (100.0%)
>  Active / Total Caches (% used)     : 71 / 112 (63.4%)
>  Active / Total Size (% used)       : 685008.27K / 686856.36K (99.7%)
>  Minimum / Average / Maximum Object : 0.02K / 0.38K / 128.00K
> 
>   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME                   
> 708600 708559  99%    0.25K  47240       15    188960K dentry_cache
> 624734 624128  99%    0.69K  56794       11    454352K reiser_inode_cache
> 254200 253514  99%    0.09K   6355       40     25420K buffer_head
> 109327 109253  99%    0.06K   1853       59      7412K size-64
> 
> Now I allocate 6GB of RAM. After that:
> 
>  Active / Total Objects (% used)    : 741266 / 1092573 (67.8%)
>  Active / Total Slabs (% used)      : 78291 / 78291 (100.0%)
>  Active / Total Caches (% used)     : 71 / 112 (63.4%)
>  Active / Total Size (% used)       : 339837.24K / 455189.93K (74.7%)
>  Minimum / Average / Maximum Object : 0.02K / 0.42K / 128.00K
> 
>   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME                   
> 464497 381126  82%    0.69K  42227       11    337816K reiser_inode_cache
> 391545 192481  49%    0.25K  26103       15    104412K dentry_cache
> 135840  95304  70%    0.09K   3396       40     13584K buffer_head

The caches were shrunk by around 40%.  Looks good.

> 1GB of dentry cache seems to be quite excessive.

Not if your workload wants to use those dentries again.  You've only
conducted one particular test.

