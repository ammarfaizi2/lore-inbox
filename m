Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758507AbWK0SX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758507AbWK0SX3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757841AbWK0SX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:23:29 -0500
Received: from smtp-out.google.com ([216.239.45.12]:42465 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1758508AbWK0SX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:23:28 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=PpcZERQQ36pm9Uc8iY2jT5xMHoe7oofG8hh/6ywnSkLxh1E0/nsjkvv9s78QkMiId
	DhQKawBu/pCFfAsdRpbOQ==
Subject: Re: [Patch1/4]: fake numa for x86_64 patch
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Mel Gorman <mel@csn.ul.ie>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611271310200.11949@skynet.skynet.ie>
References: <1164245649.29844.148.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0611271310200.11949@skynet.skynet.ie>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 27 Nov 2006 10:22:41 -0800
Message-Id: <1164651761.6619.33.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel, 

On Mon, 2006-11-27 at 13:18 +0000, Mel Gorman wrote:
> On Wed, 22 Nov 2006, Rohit Seth wrote:
> 
> > This patch provides a IO hole size in a given address range.
> >
> 
> Hi,
> 
> This patch reintroduces a function that doubles up what 
> absent_pages_in_range(start_pfn, end_pfn). I recognise you do this because 
> you are interested in hole sizes before add_active_range() is called.

Right.

>  
> However, what is not clear is why these patches are so specific to x86_64.
> 

Specifically in the fake numa case, we want to make sure that we don't
carve fake nodes that only have IO holes in it.  Unlike the real NUMA
case, here we don't have SRAT etc. to know the memory layout beforehand.

 
> It looks possible to do the work of functions like split_nodes_equal() in 
> an architecture-independent manner using early_node_map rather than 
> dealing with the arch-specific nodes array. That would open the 
> possibility of providing fake nodes on more than one architecture in the 
> future.

The functions like splti_nodes_equal etc. can be abstracted out to arch
independent part.  I think the only API it needs from arch dependent
part is to find out how much real RAM is present in range without have
to first do add_active_range.

Though as a first step, let us fix the x86_64 (as it doesn't boot when
you have sizeable chunk of IO hole and nodes > 4).

I'm also not sure if other archs actually want to have this
functionality.

> What I think can be done is that you register memory as normal and then 
> split up the nodes into fake nodes. This would remove the need for having 
> e820_hole_size() reintroduced.

Are you saying first let the system find out real numa topology and then
build fake numa on top of it?

-rohit

