Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbUJ1PrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbUJ1PrC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbUJ1Pod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:44:33 -0400
Received: from jade.aracnet.com ([216.99.193.136]:58784 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261740AbUJ1PkS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:40:18 -0400
Date: Thu, 28 Oct 2004 08:40:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: NUMA node swapping V3
Message-ID: <1275120000.1098978003@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0410280820500.25586@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0410280820500.25586@schroedinger.engr.sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes from V2: better documentation, fix missing #ifdef
> 
> In a NUMA systems single nodes may run out of memory. This may occur even
> by only reading from files which will clutter node memory with cached
> pages from the file.
> 
> However, as long as the system as a whole does have enough memory
> available, kswapd is not run at all. This means that a process allocating
> memory and running on a node that has no memory left, will get memory
> allocated from other nodes which is inefficient to handle. It would be
> better if kswapd would throw out some pages (maybe some of the cached
> pages from files that have only once been read) to reclaim memory in the
> node.
> 
> The following patch checks the memory usage after each allocation in a
> zone. If the allocation in a zone falls below a certain minimum, kswapd is
> started for that zone alone.
> 
> The minimum may be controlled through /proc/sys/vm/node_swap which is set
> to zero by default and thus is off.
> 
> If it is set for example to 100 then kswapd will be run on
> a zone/node if less than 10% of pages are available after an allocation.

I thought even the SGI people were saying this wouldn't actually help you,
due to some workload issues?

M.

