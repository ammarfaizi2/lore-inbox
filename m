Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272387AbTHOXmJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272407AbTHOXmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:42:09 -0400
Received: from AMarseille-201-1-4-67.w217-128.abo.wanadoo.fr ([217.128.74.67]:9770
	"EHLO gaston") by vger.kernel.org with ESMTP id S272387AbTHOXmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:42:06 -0400
Subject: Re: [BUG] slab debug vs. L1 alignement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3D558D.5050803@colorfullife.com>
References: <3F3D558D.5050803@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060990883.581.87.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Aug 2003 01:41:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 23:50, Manfred Spraul wrote:
> Ben wrote:
> 
> >Currently, when enabling slab debugging, we lose the property of
> >having the objects aligned on a cache line size.
> >  
> >
> Correct. Cache line alignment is advisory. Slab debugging is not the 
> only case that violates the alignment, for example 32-byte allocations 
> are not padded to the 128 byte cache line size of the Pentium 4 cpus. I 
> really doubt we want that.

Yes, I understand that, but that is wrong for GFP_DMA imho. Also, 
SLAB_MUST_HWCACHE_ALIGN just disables redzoning, which is not smart,
I'd rather allocate more and keep both redzoning and cache alignement,
that would help catch some of those subtle problems when a chip DMA
engine plays funny tricks

> Have you looked at pci_pool_{create,alloc,free,destroy}? The functions 
> were specifically written to provide aligned buffers for DMA operations. 
> Perhaps SCSI should use them?

Of course it should, but it doesn't yet. And other drivers haven't been
ported yet neither though that is slowly happening. Still, I think the
point that a GFP_DMA should be cache aligned still stands, don't you
think ?

Ben.

