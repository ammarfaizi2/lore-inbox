Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbTA2Ou4>; Wed, 29 Jan 2003 09:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTA2Ou4>; Wed, 29 Jan 2003 09:50:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7839 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266114AbTA2Ouy>;
	Wed, 29 Jan 2003 09:50:54 -0500
Date: Wed, 29 Jan 2003 16:00:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE: Do not call bh_phys() on buffers with invalid b_page.
Message-ID: <20030129150000.GD31566@suse.de>
References: <1043852266.1690.63.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043852266.1690.63.camel@zion.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29 2003, Benjamin Herrenschmidt wrote:
> Hi, I just spotted this in the patch (but the code itself have been
> there since 2.4.20-pre2).
> 
> > -			if (((unsigned long) bh->b_data) < PAGE_SIZE)
> > +			if ((unsigned long) bh->b_data < PAGE_SIZE)
> 
> Didn't you meant PAGE_OFFSET and not PAGE_SIZE here ? I fail to see why
> it would make any sense to compare a virtual address to PAGE_SIZE ;)

For highmem buffer heads, b_data is the offset into the page. Does look
confusing, I'll give you that :-)

The test should most likely just be removed, if anything.

-- 
Jens Axboe

