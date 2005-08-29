Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVH2Vsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVH2Vsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 17:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVH2Vsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 17:48:52 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:51206 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751310AbVH2Vsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 17:48:51 -0400
Date: Mon, 29 Aug 2005 17:48:30 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [patch 2.6.13] x86_64: implement dma_sync_single_range_for_{cpu,device}
Message-ID: <20050829214828.GA6314@tuxdriver.com>
Mail-Followup-To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	discuss@x86-64.org
References: <20050829200916.GI3716@tuxdriver.com> <200508292254.53476.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508292254.53476.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 10:54:53PM +0200, Andi Kleen wrote:
> On Monday 29 August 2005 22:09, John W. Linville wrote:
> > Implement dma_sync_single_range_for_{cpu,device}, based on curent
> > implementations of dma_sync_single_for_{cpu,device}.
> 
> Hmm, who or what needs that? It doesn't seem to be documented
> in Documentation/DMA* and I also don't remember seeing any 
> discussion of it.

In Documentation/DMA-API.txt it is still referred to as
dma_sync_single_range.  I imagine the *_for_{cpu,device} stuff got added
at about the same time as it did for dma_sync_single, dma_sync_sg,
and the like.

These calls are implemented for basically all the other arches.
And, except for the noted *_for_{cpu,device} discrepancies, these are
documented in Documentation/DMA-API.txt.  It definitely seems to be
an unfortunate omission from include/asm-x86_64/dma-mapping.h.

As for who needs it, well, I suppose I do.  I want to use that API
in a patch I'm working-on.  No one will want to merge my patch if it
will not compile on x86_64... :-(

> If it's commonly used it might better to add new swiotlb_* 
> functions that only copy the requested range.

Perhaps...but I think that sounds more like a discussion of _how_ to
implement the API, rather than _whether_ it should be implemented.
Using some new variant of the swiotlb_* API might be appropriate
for the x86_64 implementation.  But, since this is a portable API,
I don't think calling the (apparently Intel-specific) swiotlb_*
functions would be an appropriate replacement.

I'd be happy to have do the implementation differently (or to have
someone else do so).  Do you have specific suggestions for how to
do so?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
