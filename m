Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUCAWHD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUCAWGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:06:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39578 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261450AbUCAWGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:06:48 -0500
Date: Mon, 1 Mar 2004 23:06:46 +0100
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Redundant unplug_timer deletion
Message-ID: <20040301220646.GB5033@suse.de>
References: <B05667366EE6204181EABE9C1B1C0EB501F2AB4D@scsmsx401.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB501F2AB4D@scsmsx401.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01 2004, Chen, Kenneth W wrote:
> The only path to get to del_timer call in __generic_unplug_device()
> is when blk_remove_plug() returns 1, and in that case it already
> removed the unplug_timer.
> 
> Patch to remove this redundant call.
> 
> - Ken
> 
> --- linux-2.6.3/drivers/block/ll_rw_blk.c	2004-02-17 19:57:16
> +++ linux-2.6.3.blk/drivers/block/ll_rw_blk.c	2004-03-01 13:29:37
> @@ -1136,8 +1136,6 @@ static inline void __generic_unplug_devi
>  	if (!blk_remove_plug(q))
>  		return;
>  
> -	del_timer(&q->unplug_timer);
> -
>  	/*
>  	 * was plugged, fire request_fn if queue has stuff to do
>  	 */

Patch looks good.

-- 
Jens Axboe

