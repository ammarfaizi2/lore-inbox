Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965274AbWCTPgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965274AbWCTPgD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWCTPgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:36:00 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:43146 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964832AbWCTPfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:35:34 -0500
Date: Mon, 20 Mar 2006 07:34:25 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, ak@suse.de,
       haveblue@us.ibm.com, mingo@elte.hu
Subject: Re: [PATCH] Cpuset: alloc_pages_node overrides cpuset constraints
In-Reply-To: <20060320003052.7ca3f261.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0603200731350.21449@schroedinger.engr.sgi.com>
References: <20060318204027.13217.34767.sendpatchset@sam.engr.sgi.com>
 <20060319230712.5b15ee3e.akpm@osdl.org> <20060320003052.7ca3f261.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006, Paul Jackson wrote:

> The patch below just adds the __GFP_NOCPUSET flag on the memory
> migration code path, where we need it.  That code path is not
> performance critical.
> 
> We can deal with the long standing bug in cpusets, where it overrides
> all alloc_pages_node() calls, some other day.
> 
> What think you of this, Christoph?  Should we send it to Andrew?

It does not fix the general problem that alloc_pages_node must not respect 
cpusets. Slab, device drivers etc etc are still screwed up with this 
patch. 

We noticed this first in page migration but I think the other areas are 
much more problematic.

The earlier patch is correct. What Andrew wanted is an optimization 
not a general change in the patch. And

#ifdef CPUSETS

#endif

around the ORing of __GFP_NOCPUSET may suffice.
Maybe you got a better idea?
