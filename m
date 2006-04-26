Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWDZNzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWDZNzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWDZNzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:55:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8250 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932446AbWDZNzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:55:10 -0400
Date: Wed, 26 Apr 2006 15:55:48 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: revert unlikely in ll_back_merge_fn
Message-ID: <20060426135548.GD5083@suse.de>
References: <20060425183026.GR4102@suse.de> <004d01c668b0$a9c79540$853d010a@nuitysystems.com> <20060426052049.GV4102@suse.de> <1146059435.3908.3.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146059435.3908.3.camel@mulgrave.il.steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26 2006, James Bottomley wrote:
> On Wed, 2006-04-26 at 07:20 +0200, Jens Axboe wrote:
> > But blk_recount_segments() sets the BIO_SEG_VALID flag. Ugh ok
> > __bio_add_page() basically kills the flag. James, I think you are the
> > author of that addition, does it really need to be so restrictive?
> > 
> >         /* If we may be able to merge these biovecs, force a recount */
> >         if (bio->bi_vcnt && (BIOVEC_PHYS_MERGEABLE(bvec-1, bvec) ||
> >             BIOVEC_VIRT_MERGEABLE(bvec-1, bvec)))
> >                 bio->bi_flags &= ~(1 << BIO_SEG_VALID);
> 
> Help me out here ... I can't find this chunk of code in the current
> tree.  Where is it?

Sorry, should have mentioned that. Current git tree (or 2.6.16 should be
the same), fs/bio.c:__bio_add_page():401.

-- 
Jens Axboe

