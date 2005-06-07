Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVFGFQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVFGFQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVFGFQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:16:39 -0400
Received: from fsmlabs.com ([168.103.115.128]:33180 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261719AbVFGFQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:16:30 -0400
Date: Mon, 6 Jun 2005 23:19:50 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Matt Porter <mporter@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org, gregkh@kroah.com,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][3/5] RapidIO support: core enum
In-Reply-To: <11180976151713@foobar.com>
Message-ID: <Pine.LNX.4.61.0506062302440.10441@montezuma.fsmlabs.com>
References: <11180976151713@foobar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2005, Matt Porter wrote:

> +spinlock_t rio_global_list_lock = SPIN_LOCK_UNLOCKED;

spin_lock_init?

> +extern struct rio_route_ops __start_rio_route_ops[];
> +extern struct rio_route_ops __end_rio_route_ops[];

rio.h?

> +static void
> +rio_set_device_id(struct rio_mport *port, u16 destid, u8 hopcount, u16 did)

Shouldn't those be on the same line?

> +static int rio_device_has_destid(struct rio_mport *port, int src_ops,
> +				 int dst_ops)
> +{
> +	if (((src_ops & RIO_SRC_OPS_READ) ||
> +	     (src_ops & RIO_SRC_OPS_WRITE) ||
> +	     (src_ops & RIO_SRC_OPS_ATOMIC_TST_SWP) ||
> +	     (src_ops & RIO_SRC_OPS_ATOMIC_INC) ||
> +	     (src_ops & RIO_SRC_OPS_ATOMIC_DEC) ||
> +	     (src_ops & RIO_SRC_OPS_ATOMIC_SET) ||
> +	     (src_ops & RIO_SRC_OPS_ATOMIC_CLR)) &&
> +	    ((dst_ops & RIO_DST_OPS_READ) ||
> +	     (dst_ops & RIO_DST_OPS_WRITE) ||
> +	     (dst_ops & RIO_DST_OPS_ATOMIC_TST_SWP) ||
> +	     (dst_ops & RIO_DST_OPS_ATOMIC_INC) ||
> +	     (dst_ops & RIO_DST_OPS_ATOMIC_DEC) ||
> +	     (dst_ops & RIO_DST_OPS_ATOMIC_SET) ||
> +	     (dst_ops & RIO_DST_OPS_ATOMIC_CLR))) {
> +		return 1;

Why not just;

mask = (RIO_DST_OPS_READ | RIO_DST_OPS_WRITE....)
return !!((dst_ops & mask) && (src_ops & mask))


> +	rdev->dev.dma_mask = (u64 *) 0xffffffff;
> +	rdev->dev.coherent_dma_mask = 0xffffffffULL;

Shouldn't that be dma_set_mask?

	Zwane

