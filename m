Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWIWAYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWIWAYL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWIWAYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:24:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41667 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964969AbWIWAYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:24:09 -0400
Date: Fri, 22 Sep 2006 17:23:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Martin Bligh <mbligh@mbligh.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
Subject: Re: More thoughts on getting rid of ZONE_DMA
In-Reply-To: <200609230134.45355.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609221715520.10484@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com>
 <4514441E.70207@mbligh.org> <Pine.LNX.4.64.0609221321280.9181@schroedinger.engr.sgi.com>
 <200609230134.45355.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006, Andi Kleen wrote:

> The problem is that if someone has a workload with lots of pinned pages
> (e.g. lots of mlock) then the first 16MB might fill up completely and there 
> is no chance at all to free it because it's pinned

Ok. That may be a problem for i386. After the removal of the GFP_DMA 
and ZONE_DMA stuff it is then be possible to redefine ZONE_DMA (or 
whatever we may call it ZONE_RESERVE?) to an arbitrary size a the 
beginning of memory. Then alloc_pages_range() can dynamically decide to 
tap that pool if necessary. I already have checks for ZONE_DMA and 
ZONE_DMA32 in there. If we just rename those then what you wanted would 
be there. If additional memory pools are available then they
are used if the allocation restrictions fit to avoid a lengthy search.

This may mean that i386 and x86_64 will still have two zones. Its somewhat 
better.

However, on IA64 we would not need this since our DMA limit has been 
4GB in the past.

