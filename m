Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVAUS1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVAUS1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVAUS1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:27:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:53643 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262445AbVAUS0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:26:44 -0500
Date: Fri, 21 Jan 2005 10:26:28 -0800
From: Dave Olien <dmo@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org, kevcorry@us.ibm.com,
       agk@sourceware.org
Subject: Re: [RFC] [PATCH] move bio code from dm into bio
Message-ID: <20050121182628.GA4998@osdl.org>
References: <20050120235826.GA3041@osdl.org> <20050121090202.GA2790@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121090202.GA2790@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks!  I'll continue to do more testing as well.

On Fri, Jan 21, 2005 at 10:02:02AM +0100, Jens Axboe wrote:
> On Thu, Jan 20 2005, Dave Olien wrote:
> > 
> > Jens, last December you observed there was bio code
> > duplicated in the dm drivers.
> 
> Yep
> 
> > Here are a collection of patches that implements
> > support for local bio and bvec pools into bio.c and then
> > removes the duplicate bio code from the dm drivers.
> > 
> > It also replaces a call to alloc_bio() in dm.c with
> > a call to use a local bio pool.  This removes a 
> > deadlock case in that code.
> > 
> > These patches are against 2.6.11-rc1.  If that's not
> > a good source version to patch against, let me now
> > what versions I should generate patches for.
> 
> Just check if they apply to current BK tree, in general it's just best
> to do patches against latest -rc1-bkX (or just the bk tree, if you use
> that).
> 
> But the patch looks good, the bio_set approach is the cleanest way to
> fix it I think. It will be easy to fix the bounce deadlock as well, by
> adding a bio_set_bounce to mm/highmem.c as well.
> 
> Thanks for doing this! I'll review the patch in detail, the concept and
> solution is definitely good though.
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
