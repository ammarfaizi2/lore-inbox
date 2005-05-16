Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVEPRy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVEPRy7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVEPRy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:54:59 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:20950 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261712AbVEPRyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:54:49 -0400
Date: Mon, 16 May 2005 10:54:33 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
In-Reply-To: <1116264135.1005.73.camel@localhost>
Message-ID: <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> 
 <20050512000444.641f44a9.akpm@osdl.org>  <Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
  <20050513000648.7d341710.akpm@osdl.org>  <Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com>
  <20050513043311.7961e694.akpm@osdl.org>  <Pine.LNX.4.62.0505131823210.12315@schroedinger.engr.sgi.com>
  <1116251568.1005.29.camel@localhost>  <Pine.LNX.4.62.0505160943140.1330@schroedinger.engr.sgi.com>
 <1116264135.1005.73.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Dave Hansen wrote:

> > How do the concepts of numa node id relate to discontig node ids?
> 
> I believe there are quite a few assumptions on some architectures that,
> when NUMA is on, they are equivalent.  It appears to be pretty much
> assumed everywhere that CONFIG_NUMA=y means one pg_data_t per NUMA node.

Ah. That sounds much better.

> Remember, as you saw, you can't assume that MAX_NUMNODES=1 when NUMA=n
> because of the DISCONTIG=y case.

I have never seen such a machine. A SMP machine with multiple 
"nodes"? So essentially one NUMA node has multiple discontig "nodes"?

This means that the concept of a node suddenly changes if there is just 
one numa node(CONFIG_NUMA off implies one numa node)? 

> So, in summary, if you want to do it right: use the
> CONFIG_NEED_MULTIPLE_NODES that you see in -mm.  As plain DISCONTIG=y
> gets replaced by sparsemem any code using this is likely to stay
> working.

s/CONFIG_NUMA/CONFIG_NEED_MULTIPLE_NODES?

That will not work because the idea is the localize the slabs to each 
node. 

If there are multiple nodes per numa node then invariable one node in the 
numa node (sorry for this duplication of what node means but I did not 
do it) must be preferred since numa_node_id() does not return a set of 
discontig nodes.
 
Sorry but this all sounds like an flaw in the design. There is no 
consistent notion of node. Are you sure that this is not a ppc64 screwup?

