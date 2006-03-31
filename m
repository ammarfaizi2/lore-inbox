Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWCaTxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWCaTxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWCaTxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:53:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48743 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932249AbWCaTxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:53:19 -0500
Date: Fri, 31 Mar 2006 21:53:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] splice SPLICE_F_MOVE support
Message-ID: <20060331195330.GG14022@suse.de>
References: <20060330131530.GI13476@suse.de> <20060330131915.GJ13476@suse.de> <442CED15.7000303@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442CED15.7000303@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31 2006, Nick Piggin wrote:
> Jens Axboe wrote:
> >Hi,
> >
> >This applies on top of the splice #3 just posted, adding support for
> >moving of pages. The caller can use the SPLICE_F_MOVE flag to the splice
> >syscall to ask the kernel to try and move pages, if needed.
> >
> >Disclaimer: this works for me, but may have vm issues that I missed.
> >CC'ing Nick :-)
> >
> 
> Like Andrew said, you can't check PageLRU without holding zone->lru_lock.
> The page release code can get away with it only because the page refcount
> is 0 at that point. Also, you can't reliably remove pages from the LRU
> unless the refcount is 0. Ever.
> 
> The following (untested) is something like what I had in mind, and should
> get stealing closer to working. I've only given it a quick review so far
> (btw. why do you only unlock the page if it hasn't been stolen?)

The current branch does not :)

> With this patch, the ->steal will indicate if the page had been on the
> LRU or not. If not, then add it; if yes, then do nothing.
> 
> There is no caller of ->steal yet that wants the page off the LRU (is
> there?). That's a bit harder.

Thanks Nick, but would you care to rebase it off the 'splice' branch?
There's already some changes in this area (notably, getting rid of
->stolen).

git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git splice

-- 
Jens Axboe

