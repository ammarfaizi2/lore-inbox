Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266374AbUBFFal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 00:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUBFFai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 00:30:38 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:46556 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266374AbUBFFag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 00:30:36 -0500
Date: Fri, 6 Feb 2004 11:04:43 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Steve Lord <lord@xfs.org>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
Message-ID: <20040206053443.GB1263@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel> <20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel> <p73isilkm4x.fsf@verdi.suse.de> <4021AC9F.4090408@xfs.org> <20040205191240.13638135.akpm@osdl.org> <4021C152.3080501@xfs.org> <20040206053927.37709591.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206053927.37709591.ak@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 04:49:01AM +0000, Andi Kleen wrote:
> On Wed, 04 Feb 2004 22:06:42 -0600
> Steve Lord <lord@xfs.org> wrote:
> 
> 
> > It does look like 2.6 does better, but I don't have quite the
> > amount of memory on my laptop....
> 
> I see the problem on a 8GB x86-64 box with 2.6.2-rc1. 
> 
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
				                ^^^^^^^^^
> 135840  95304  70%    0.09K   3396       40     13584K buffer_head
> 
> 1GB of dentry cache seems to be quite excessive.
> 

Here dentry cache looks to be approximately 104 MB (104,412K) and not 1GB and 
it has reduced from 188 MB to 104 MB.

Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
