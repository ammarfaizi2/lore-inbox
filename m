Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWGCXr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWGCXr0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWGCXr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:47:26 -0400
Received: from ns.suse.de ([195.135.220.2]:48527 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932122AbWGCXrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:47:25 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
Date: Tue, 4 Jul 2006 01:47:10 +0200
User-Agent: KMail/1.9.3
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com> <20060703221712.GB14273@infradead.org> <Pine.LNX.4.64.0607031624210.8547@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607031624210.8547@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607040147.10995.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So we want to change the definition of ZONE_DMA to refer to the first 16MB 
> only? ZONE_DMA32 is always a 4GB border? (Andy disagrees about DMA32 see 
> his message!).

Hmm?  I didn't write anything about DMA32. Just noted a minor comment thinko about
highmem.

> It seems to me that DMA can be run on ZONE_NORMAL. ZONE_DMAxx is used for 
> situations in which DMA cannot be done to all of memory. ZONE_DMA allows 
> an architecture to define a single exception zone that ends at 
> MAX_DMA_ADDRESS (which is arch specific).

It's really architecture dependent. The portable interfaces are 
dma_alloc_* and suitable device masks and the architecture should sort
out then what zone to use.

I would say nearly everybody who uses GFP_DMA directly outside 
{arch,asm}/* is wrong.

-Andi
