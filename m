Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbTA2PiC>; Wed, 29 Jan 2003 10:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbTA2PiB>; Wed, 29 Jan 2003 10:38:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14757 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266233AbTA2PiA>;
	Wed, 29 Jan 2003 10:38:00 -0500
Date: Wed, 29 Jan 2003 16:47:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE: Do not call bh_phys() on buffers with invalid b_page.
Message-ID: <20030129154706.GG31566@suse.de>
References: <1043852266.1690.63.camel@zion.wanadoo.fr> <20030129150000.GD31566@suse.de> <1043853614.1668.70.camel@zion.wanadoo.fr> <20030129152214.GE31566@suse.de> <1043853975.1668.74.camel@zion.wanadoo.fr> <20030129153820.GF31566@suse.de> <1043855055.536.81.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043855055.536.81.camel@zion.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29 2003, Benjamin Herrenschmidt wrote:
> On Wed, 2003-01-29 at 16:38, Jens Axboe wrote:
> > No, any b_data < PAGE_OFFSET is not wrong, that's the point. For highmem
> > b_page, b_data will be the offset into the page. So it could be 2048,
> > for instance.
> 
> In the other if() case, yes ;)

b_data < PAGE_SIZE would not be a bug in the other case, if
PageHighmem(bh->b_page). If !PageHighmem(bh->b_page), then b_data <
PAGE_OFFSET would be a bug, yes.

But lets drop this now, it's getting way silly! :)

> All I wanted to spot is that < PAGE_OFFSET would catch the PAGE_SIZE bug
> as well ;) But that's not a problem in real life anyway it seems.

That is correct, but as I said it's nice to separate them because it's
two bugs really. And the one I wanted to catch was number 1, and that's
the one I put in. EOD?

-- 
Jens Axboe

