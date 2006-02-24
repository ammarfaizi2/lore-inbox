Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWBXC1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWBXC1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWBXC1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:27:03 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:16785 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932568AbWBXC1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:27:01 -0500
Date: Thu, 23 Feb 2006 18:25:37 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andrew Morton <akpm@osdl.org>, alokk@calsoftinc.com,
       manfred@colorfullife.com, penberg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Slab: Node rotor for freeing alien caches and remote per cpu
 pages.
In-Reply-To: <20060224012815.GB5589@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602231823340.18354@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0602231036480.13184@schroedinger.engr.sgi.com>
 <20060223113331.6b345e1b.akpm@osdl.org> <Pine.LNX.4.64.0602231140140.13899@schroedinger.engr.sgi.com>
 <20060224012815.GB5589@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Ravikiran G Thirumalai wrote:

> Actually, all cpus on the node share the alien_cache, and the alien_cache is
> one per remote node (for the cachep).  So currently each cpu on the node 
> drains the same alien_cache onto all the remote nodes in the per-cpu eventd.  

Right. So we could optimize that.

> What is probably very expensive here at drain_alien_cache is free_block 
> getting called from the foreign node, and freeing remote pages.
> We have a patch-set here to drop-in the alien objects from the current node to 
> the respective alien node's drop box, and that drop box will be cleared
> locally (so that freeing happens locally).  This would happen off cache_reap. 
> (I was holding from posting it because akpm complained about slab.c 

Could you show us the patch?

> Round robin might still be useful for drain_alien_cache with that approach, 
> but maybe init_reap_node should initialize the per-cpu reap_node with a skew
> for cpus on the same node (so all cpus of a node do not drain to the same 
> foreign node when the eventd runs?)

Good idea.
