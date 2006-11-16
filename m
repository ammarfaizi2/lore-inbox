Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162236AbWKPSqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162236AbWKPSqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 13:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162240AbWKPSqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 13:46:52 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41659 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1162236AbWKPSqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 13:46:51 -0500
Date: Thu, 16 Nov 2006 10:46:16 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Christian Krafft <krafft@de.ibm.com>
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, mbligh@mbligh.org,
       steiner@sgi.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
In-Reply-To: <20061116164037.58b3aaeb@localhost>
Message-ID: <Pine.LNX.4.64.0611161043510.28498@schroedinger.engr.sgi.com>
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost>
 <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
 <20061115215845.GB20526@sgi.com> <Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com>
 <455B9825.3030403@mbligh.org> <Pine.LNX.4.64.0611151451450.23477@schroedinger.engr.sgi.com>
 <20061116095429.0e6109a7.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0611151653560.24565@schroedinger.engr.sgi.com>
 <20061116164037.58b3aaeb@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006, Christian Krafft wrote:

> Okay, I slowly understand what you are talking about.
> I just tried a "numactl --cpunodebind 1 --membind 1 true" which hit an uninitialized zone in slab_node:
> 
> return zone_to_nid(policy->v.zonelist->zones[0]);

I think the above should work fine and give the expected OOM since the
node has no memory.

The zone struct should redirect via the zonelist to nodes that have 
memory for allocations that are not bound to a single node.

> I also still don't know if it makes sense to have memoryless nodes, but supporting it does.
> So wath would be reasonable, to have empty zonelists for those node, or to check if zonelists are uninitialized ?

zonelists of those nodes should contain a list of fallback zones with 
available memory.
