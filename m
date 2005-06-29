Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVF2JnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVF2JnD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 05:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVF2JnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 05:43:03 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:49328 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262243AbVF2Jlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 05:41:49 -0400
Date: Wed, 29 Jun 2005 15:21:02 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Zach Brown <zab@zabbo.net>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org,
       wli@holomorphy.com, mason@suse.com
Subject: Re: [PATCH 2/6] Rename __lock_page to lock_page_slow
Message-ID: <20050629095102.GA4820@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050620120154.GA4810@in.ibm.com> <20050620160126.GA5271@in.ibm.com> <20050620162404.GB5380@in.ibm.com> <42C18055.9040202@zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C18055.9040202@zabbo.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 09:52:37AM -0700, Zach Brown wrote:
> 
> I have to whine at least once about obscure names :)
> 
> > -void fastcall __lock_page(struct page *page)
> > +void fastcall lock_page_slow(struct page *page)
> >  {
> >  	DEFINE_WAIT_BIT(wait, &page->flags, PG_locked);
> >  
> >  	__wait_on_bit_lock(page_waitqueue(page), &wait, sync_page,
> >  							TASK_UNINTERRUPTIBLE);
> >  }
> > -EXPORT_SYMBOL(__lock_page);
> > +EXPORT_SYMBOL(lock_page_slow);
> 
> Can we chose a name that describes what it does?  Something like
> lock_page_wait_on_locked()?

The usage of the _slow suffix was inspired from fs/buffer.c,
__bread_slow, __find_get_block_slow, __getblk_slow etc.

I actually have an earlier version with the name changes you had
suggested earlier ... but then wasn't sure if these are really
much better, wanted to hear what others had to say. I do not have
any particular affinities, will go with whatever is the general
consensus.

Regards
Suparna

> 
> - z

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

