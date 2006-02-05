Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbWBEDfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWBEDfs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 22:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWBEDfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 22:35:48 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:30345 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932576AbWBEDfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 22:35:47 -0500
Date: Sat, 4 Feb 2006 19:35:37 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <20060204154944.36387a86.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0602041929330.8874@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <20060204154944.36387a86.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2006, Andrew Morton wrote:

> > +int cpuset_mem_spread_node(void)
> > +{
> > +	int node;
> > +
> > +	node = next_node(current->cpuset_mem_spread_rotor, current->mems_allowed);
> > +	if (node == MAX_NUMNODES)
> > +		node = first_node(current->mems_allowed);
> > +	current->cpuset_mem_spread_rotor = node;
> > +	return node;
> > +}
> 
> hm.  What guarantees that a node which is in current->mems_allowed is still
> online?

If a node is not online then the slab allocator will fall back to the 
local node. See kmem_cache_alloc_node.

The page allocator will refer to the zonelist of the node that is offline. 
Hmm... Isnt current->mems_allowed restricted by the available nodes?



