Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVBSW4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVBSW4M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 17:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVBSW4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 17:56:12 -0500
Received: from [205.233.219.253] ([205.233.219.253]:26581 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S262159AbVBSW4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 17:56:08 -0500
Date: Sat, 19 Feb 2005 17:55:13 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() && irqs_disabled()
Message-ID: <20050219225513.GI9231@conscoop.ottawa.on.ca>
References: <200502191136.05584.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502191136.05584.david-b@pacbell.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 11:36:05AM -0800, David Brownell wrote:
> 
> Those allocations could be from _using_ a dma pool ... but they're
> not from just creating one!
> 
> The cost of creating the dma_pool is the cost of one small kmalloc()
> plus (the expensive part) the /sys/devices/.../pools sysfs attribute
> is created along with the first pool.  (Use that instead of slabinfo
> for those pool allocations.)  That's why the normal spot to create and
> destroy dma pools is in driver probe() and remove() methods.

OK, then I misread drivers/base/pool.c and my objection to the patch is
unfounded.

> If you want to allocate gobs of other stuff at the same time, that's
> your choice ... but it'd be a separate issue.  Cost to create a
> dma_pool is significantly less than PAGE_SIZE, and there's no good
> reason to allocate or destroy those pools anywhere near an IRQ context.

I agree.  raw1394 does far too much with irqs disabled, and moving this
stuff to probe() will fix part of that problem.

Jody

> 
> - Dave
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
