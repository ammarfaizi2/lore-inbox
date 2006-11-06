Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753810AbWKFVUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbWKFVUd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753816AbWKFVUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:20:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44725 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753810AbWKFVUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:20:32 -0500
Date: Mon, 6 Nov 2006 13:20:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061106132029.28cd88b5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611061252140.29760@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
	<Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	<20061103143145.85a9c63f.akpm@osdl.org>
	<Pine.LNX.4.64.0611031622540.16997@schroedinger.engr.sgi.com>
	<20061103165854.0f3e77ad.akpm@osdl.org>
	<Pine.LNX.4.64.0611060846070.25351@schroedinger.engr.sgi.com>
	<20061106115925.1dd41a77.akpm@osdl.org>
	<Pine.LNX.4.64.0611061207310.26685@schroedinger.engr.sgi.com>
	<20061106122446.8269f7bc.akpm@osdl.org>
	<Pine.LNX.4.64.0611061229080.29760@schroedinger.engr.sgi.com>
	<20061106124257.deffa31c.akpm@osdl.org>
	<Pine.LNX.4.64.0611061252140.29760@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006 12:58:52 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> > OK, but if two nodes have a lot of free pages and the rest don't then
> > interleave will consume those free pages without performing any reclaim
> > from all the other nodes.  Hence hostpots or imbalances.
> > 
> > Whatever they are.  Why does it matter?
> 
> Hotspots create lots of requests going to the same numa node. The nodes 
> have a limited capability to service cacheline requests and the bandwidth 
> on the interlink is also limited. If too many processors request 
> information from the same remote node then performance will drop.

OK.

> There are different kind of data in a NUMA system:
> 
> Data that is node local is only accessed by the local processor. For node 
> local data we have no such concerns since the interlink is not used. Quite 
> a lot of kernel data per node or per cpu and thus is not a problem.
> 
> For shared data that is known to be performance critical--and where we 
> know that the data is accessed from multiple nodes--there we need to 
> balance the data between multiple nodes to avoid overloads and 
> to keep the system running at optimal speed. That is where interleave 
> becomes important.

But doesn't this patch introduce considerable risks of the above problems
occurring?  In the two-nodes-have-lots-of-free-memory scenario?
