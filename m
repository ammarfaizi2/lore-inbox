Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUHaQIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUHaQIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268737AbUHaQIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:08:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:14729 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268730AbUHaQHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:07:35 -0400
Message-ID: <4134A22F.7000103@us.ibm.com>
Date: Tue, 31 Aug 2004 09:07:11 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] DRM initial function table support.
References: <Pine.LNX.4.58.0408311409530.18657@skynet> <20040831152015.GC22978@redhat.com>
In-Reply-To: <20040831152015.GC22978@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Aug 31, 2004 at 02:11:11PM +0100, Dave Airlie wrote:
> 
> One thing that would make things even nicer would be..
> 
> instead of this..
> 
>  > +void gamma_driver_register_fns(drm_device_t *dev)
>  > +{
>  > +	dev->fn_tbl.preinit = gamma_driver_preinit;
>  > +	dev->fn_tbl.pretakedown = gamma_driver_pretakedown;
>  > +	dev->fn_tbl.dma_ready = gamma_driver_dma_ready;
>  > +	dev->fn_tbl.dma_quiescent = gamma_driver_dma_quiescent;
>  > +	dev->fn_tbl.dma_flush_block_and_flush = gamma_flush_block_and_flush;
>  > +	dev->fn_tbl.dma_flush_unblock = gamma_flush_unblock;
>  > +}
> 
> having a per-driver struct with regular C99 initialisers..
> 
> struct gamma_driver_fntbl {
> 	.preinit = gamma_driver_preinit,
> 	.pretakedown = gamma_driver_pretakedown,
> 	.dma_ready = gamma_driver_dma_ready,
> 	.dma_quiescent = gamma_driver_dma_quiescent,
> 	.dma_flush_block_and_flush = gamma_flush_block_and_flush,
> 	.dma_flush_unblock = gamma_flush_unblock,
> };

I think the intention is to have default functions set in the 
device-independent code and have the device-dependent code over-ride 
them.  Since the defaults may not always be NULL, doing a struct like 
that wouldn't really work.  I suppose we could have a struct and a 
device-independent function that copies the non-NULL pointers from the 
per-device struct.  Would that be better?

> Thanks for doing this work, it really is starting to look a little more
> like a Linux driver 8-)

I second that!

