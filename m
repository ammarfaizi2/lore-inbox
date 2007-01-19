Return-Path: <linux-kernel-owner+w=401wt.eu-S932566AbXASRUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbXASRUb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbXASRUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:20:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48887 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932566AbXASRUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:20:30 -0500
Date: Fri, 19 Jan 2007 09:20:03 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, pj@sgi.com
Subject: Re: [PATCH] nfs: fix congestion control
In-Reply-To: <1169212022.6197.148.camel@twins>
Message-ID: <Pine.LNX.4.64.0701190912540.14617@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
  <20070116135325.3441f62b.akpm@osdl.org> <1168985323.5975.53.camel@lappy> 
 <Pine.LNX.4.64.0701171158290.7397@schroedinger.engr.sgi.com> 
 <1169070763.5975.70.camel@lappy>  <1169070886.6523.8.camel@lade.trondhjem.org>
  <1169126868.6197.55.camel@twins>  <1169135375.6105.15.camel@lade.trondhjem.org>
  <1169199234.6197.129.camel@twins> <1169212022.6197.148.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Peter Zijlstra wrote:

> +	/*
> +	 * NFS congestion size, scale with available memory.
> +	 *

Well this all depends on the memory available to the running process.
If the process is just allowed to allocate from a subset of memory 
(cpusets) then this may need to be lower.

> +	 *  64MB:    8192k
> +	 * 128MB:   11585k
> +	 * 256MB:   16384k
> +	 * 512MB:   23170k
> +	 *   1GB:   32768k
> +	 *   2GB:   46340k
> +	 *   4GB:   65536k
> +	 *   8GB:   92681k
> +	 *  16GB:  131072k

Hmmm... lets say we have the worst case of an 8TB IA64 system with 1k 
nodes of 8G each. On Ia64 the number of pages is 8TB/16KB pagesize = 512 
million pages. Thus nfs_congestion_size is 724064 pages which is 
11.1Gbytes?

If we now restrict a cpuset to a single node then have a 
nfs_congestion_size of 11.1G vs an available memory on a node of 8G.
