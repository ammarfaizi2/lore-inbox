Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbWBEDhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWBEDhu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 22:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWBEDhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 22:37:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15498 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932585AbWBEDht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 22:37:49 -0500
Date: Sat, 4 Feb 2006 19:37:39 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] cpuset memory spread slab cache implementation
In-Reply-To: <20060204154959.0322e5da.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0602041935590.8874@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <20060204071921.10021.83884.sendpatchset@jackhammer.engr.sgi.com>
 <20060204154959.0322e5da.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2006, Andrew Morton wrote:

> Paul Jackson <pj@sgi.com> wrote:
> >
> > +	if (unlikely(cpuset_mem_spread_check() &&
> >  +					(cachep->flags & SLAB_MEM_SPREAD) &&
> >  +					!in_interrupt())) {
> >  +		int nid = cpuset_mem_spread_node();
> >  +
> >  +		if (nid != numa_node_id())
> >  +			return __cache_alloc_node(cachep, flags, nid);
> >  +	}
> 
> Need a comment here explaining the mysterious !in_interrupt() check.

If we are in interrupt context then the current pointer may not be 
meaningful. cpuset settings should not be applied for any memory 
allocation.
