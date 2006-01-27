Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWA0AWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWA0AWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWA0AWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:22:01 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34539 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964798AbWA0AWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:22:00 -0500
Date: Thu, 26 Jan 2006 16:21:43 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
In-Reply-To: <43D96633.4080900@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0601261619030.19029@schroedinger.engr.sgi.com>
References: <20060125161321.647368000@localhost.localdomain>
 <1138233093.27293.1.camel@localhost.localdomain>
 <Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com>
 <43D953C4.5020205@us.ibm.com> <Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com>
 <43D95A2E.4020002@us.ibm.com> <Pine.LNX.4.62.0601261525570.18810@schroedinger.engr.sgi.com>
 <43D96633.4080900@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Matthew Dobson wrote:

> Allocations backed by a mempool must always be allocated via
> mempool_alloc() (or mempool_alloc_node() in this case).  What that means
> is, without a mempool_alloc_node() function, NO mempool backed allocations
> will be able to request a specific node, even when the system has PLENTY of
> memory!  This, IMO, is unacceptable.  Adding more NUMA-awareness to the
> mempool system allows us to keep the same slab behavior as before, as well
> as leaving us free to ignore the node requests when memory is low.

Ok. That makes sense. I thought the mempool_xxx functions were only for 
emergencies. But nevertheless you still duplicate all memory allocation 
functions. I already was a bit concerned when I added the _node stuff.

What may be better is to add some kind of "allocation policy" to an 
allocation. That allocation policy could require the allocation on a node, 
distribution over a series of nodes, require allocation on a particular 
node, or allow the use of emergency pools etc.

Maybe unify all the different page allocations to one call and do the 
same with the slab allocator.
