Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281638AbRKPWqn>; Fri, 16 Nov 2001 17:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281633AbRKPWqY>; Fri, 16 Nov 2001 17:46:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29969 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281617AbRKPWqM>;
	Fri, 16 Nov 2001 17:46:12 -0500
Date: Fri, 16 Nov 2001 23:45:55 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: groudier@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [patch] block-highmem-all-18
Message-ID: <20011116234555.C11826@suse.de>
In-Reply-To: <20011116093927.E27010@suse.de> <20011116193057.O1825-100000@gerard> <20011116.135409.118971851.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011116.135409.118971851.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16 2001, David S. Miller wrote:
>    From: Gérard Roudier <groudier@free.fr>
>    Date: Fri, 16 Nov 2001 19:59:02 +0100 (CET)
>    
>    On Fri, 16 Nov 2001, Jens Axboe wrote:
>    
>    > - Add sym2 can_dma_32 flag (me)
>                 ^^^^^^^^^^ Pooaaahhh!:) What's this utter oddity ?
>    Only dma 32 ? :-)
> 
> It is workaround for buggy drivers, when set it means that single SG
> list entry request will be handled correctly.  When clear it means
> that single entry SG lists are to be avoided by the block layer.
> 
> Many devices would explode when given single entry scatterlist. :(
> 
> It's naming is questionable... that I agree with.  The name should be
> more suggestive to what it really means.

Heh, actually Dave the single_sg_ok flag used to specify just that, but
Arjan noted that we never needed to trust that functionality when
!can_dma_32. So now can_dma_32 being set implies that the HBA driver
also gets the single sg entry correct.

To answer Gerard's question -- with can_dma_32 set, scsi_merge will set
the correct bounce value based on the PCI device DMA mask set. So dma_32
is indeed a misnomer, it was introduced before we supported full 64-bit
dma, and should now just be called can_highmem_io or something similar.

-- 
Jens Axboe

