Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVAUJCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVAUJCd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 04:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVAUJCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 04:02:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18064 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261601AbVAUJCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 04:02:13 -0500
Date: Fri, 21 Jan 2005 10:02:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Olien <dmo@osdl.org>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org, kevcorry@us.ibm.com,
       agk@sourceware.org
Subject: Re: [RFC] [PATCH] move bio code from dm into bio
Message-ID: <20050121090202.GA2790@suse.de>
References: <20050120235826.GA3041@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120235826.GA3041@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20 2005, Dave Olien wrote:
> 
> Jens, last December you observed there was bio code
> duplicated in the dm drivers.

Yep

> Here are a collection of patches that implements
> support for local bio and bvec pools into bio.c and then
> removes the duplicate bio code from the dm drivers.
> 
> It also replaces a call to alloc_bio() in dm.c with
> a call to use a local bio pool.  This removes a 
> deadlock case in that code.
> 
> These patches are against 2.6.11-rc1.  If that's not
> a good source version to patch against, let me now
> what versions I should generate patches for.

Just check if they apply to current BK tree, in general it's just best
to do patches against latest -rc1-bkX (or just the bk tree, if you use
that).

But the patch looks good, the bio_set approach is the cleanest way to
fix it I think. It will be easy to fix the bounce deadlock as well, by
adding a bio_set_bounce to mm/highmem.c as well.

Thanks for doing this! I'll review the patch in detail, the concept and
solution is definitely good though.

-- 
Jens Axboe

