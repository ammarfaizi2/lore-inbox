Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031044AbWKPBfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031044AbWKPBfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 20:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031047AbWKPBfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 20:35:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:61067 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1031044AbWKPBfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 20:35:50 -0500
Date: Wed, 15 Nov 2006 19:35:34 -0600
From: Jack Steiner <steiner@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Christian Krafft <krafft@de.ibm.com>, linux-mm@kvack.org,
       Martin Bligh <mbligh@mbligh.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have no memory
Message-ID: <20061116013534.GB1066@sgi.com>
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost> <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com> <20061115215845.GB20526@sgi.com> <Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 02:40:36PM -0800, Christoph Lameter wrote:
> On Wed, 15 Nov 2006, Jack Steiner wrote:
> 
> > A lot of the core infrastructure is currently missing that is required
> > to describe IO nodes as regular nodes, but in principle, I don't
> > see anything wrong with nodes w/o memory.
> 
> Every processor has a local node on which it runs. The kernel places 
> memory used by the processor on the local node. Even if we allow
> nodes without memory: We still need to associate a "local" node to the 
> processor. If that is across some NUMA interlink then it is going to be 
> slower but it will work.

True.

> 
> AFAIK It seems to be better to explicitly associate a memory node with a 
> processor during bootup in arch code. 
> 
> Various kernel optimizations rely on local memory. Would we create 
> a  special case here of a pglist_data structure without a zones structure? 
> 
> It seems that the contents of pglist_data are targeted to a memory node. 
> If we do not have a pglist_data structure then the node would not exist 
> for the kernel.
> 
> What would the benefit or difference be of having nodes without memory?

I doubt that there is a demand for systems with memoryless nodes. However, if the
DIMM(s) on a node fails, I think the system may perform better
with the cpus on the node enabled than it will if they have to be
disabled.



-- jack
