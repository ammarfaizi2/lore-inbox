Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUJLPRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUJLPRm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUJLPR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:17:28 -0400
Received: from jade.aracnet.com ([216.99.193.136]:13444 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S265800AbUJLPRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:17:07 -0400
Date: Tue, 12 Oct 2004 08:16:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
cc: nickpiggin@yahoo.com.au, linux-mm@kvack.org
Subject: Re: NUMA: Patch for node based swapping
Message-ID: <1513170000.1097594210@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0410120751010.11558@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0410120751010.11558@schroedinger.engr.sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

I agree it's a problem, but you really don't want to go kicking pages out
to disk when we have free memory - the solution is, I think, to migrate
the least-recently used pages out to the other node, not all the way to
disk. The page relocate stuff from the defrag code being proposed may help
(if they fix it not to go via swap ;-)). I'll try to find some time to
look at it again.

M.

PS, might be possible to add a mechanism to ask kswapd to reclaim some 
cache pages without doing swapout, but I fear of messing with the delicate
balance of the universe - cache vs user.
