Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWHQAZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWHQAZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWHQAZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:25:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3041 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932155AbWHQAZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:25:16 -0400
Date: Wed, 16 Aug 2006 17:24:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@muc.de>
cc: mpm@selenic.com, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
In-Reply-To: <20060816094358.e7006276.ak@muc.de>
Message-ID: <Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
 <20060816094358.e7006276.ak@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Andi Kleen wrote:

> > 2. use fls to calculate array position.
> 
> I'm not sure that's a good idea. I always had my doubts that power of twos
> are a good size distribution. I remember the original slab paper from Bonwick
> also discouraged them. With fls you would hard code it.

The original paper from Bonwick is pretty dated now. There are some 
interesting ideas in there and we have mostly followed them. But it is an 
academic paper after all. So not all ideas may be relevant in practice. 
Support for non power of two sizes could lead to general slabs that do not 
exactly fit into one page. Right now its nicely fitting in. What exactly 
was his argument?
  
> I think it would be better to keep the more flexible arbitary array so that
> people can try to develop new better distributions.

Well they have not so far. The irregular arrays in the list are 96 and 192 
bytes long. 96 is only used if cacheline size is smaller than 64. Which is 
probably relevent for a very small number of machines. 192 is only used if 
cacheline size is less than 128. Most current machine have 128 byte 
cacheline right? So we already have the power of two there.

Also why do we limit the sizes of slabs? Would it not be best to have 
larger than page size slabs be handled by the page_slab_allocator 
(similar to SLOB)? The page allocator is build to optimize page sized 
allocation. Reclaim is trivial then.

