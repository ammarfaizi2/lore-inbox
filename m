Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUFBT2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUFBT2H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbUFBT2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:28:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15304 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263851AbUFBT2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:28:04 -0400
Date: Wed, 2 Jun 2004 21:27:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Christophe Saout <christophe@saout.de>
Cc: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 5/5: Device-mapper: dm-zero
Message-ID: <20040602192753.GA2401@suse.de>
References: <20040602154605.GR6302@agk.surrey.redhat.com> <1086192141.4659.1.camel@leto.cs.pocnet.net> <20040602160905.GX28915@suse.de> <1086193026.4659.3.camel@leto.cs.pocnet.net> <1086193571.4659.7.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086193571.4659.7.camel@leto.cs.pocnet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02 2004, Christophe Saout wrote:
> Am Mi, den 02.06.2004 um 18:17 Uhr +0200 schrieb Christophe Saout:
> 
> > What does this & PAGE_MASK do? This looks wrong too.

:)

> Sorry, please forget this.
> 
> 
> --- linux.orig/drivers/md/dm-zero.c  2004-06-02 18:24:38.231186664 +0200
> +++ linux/drivers/ms/dm-zero.c	     2004-06-02 18:24:55.645539280 +0200
> @@ -35,7 +35,8 @@
> 	bio_for_each_segment(bv, bio, i) {
> 		char *data = bvec_kmap_irq(bv, &flags);
> 		memset(data, 0, bv->bv_len);
> - 		bvec_kunmap_irq(bv, &flags);
> + 		flush_dcache_page(bv->bv_page);
> + 		bvec_kunmap_irq(data, &flags);
>   	}
>   }

That looks good.


-- 
Jens Axboe

