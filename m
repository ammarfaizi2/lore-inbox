Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWCaHdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWCaHdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWCaHdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:33:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52550 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751249AbWCaHdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:33:21 -0500
Date: Fri, 31 Mar 2006 09:33:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce sys_splice() system call
Message-ID: <20060331073331.GD14022@suse.de>
References: <200603302109.k2UL9Auj011419@hera.kernel.org> <20060330161240.11ee3d5f.akpm@osdl.org> <20060331071635.GA14022@suse.de> <20060330233059.42ee1ae2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330233059.42ee1ae2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > > > +	ret = write_one_page(page, 0);
> >  > 
> >  > Still want to know why this is here??
> >  > 
> >  > > +out:
> >  > > +	if (ret < 0)
> >  > > +		unlock_page(page);
> >  > 
> >  > If write_one_page()'s call to ->writepage() failed, this will cause a
> >  > double unlock.
> > 
> >  Can probably be improved - can I drop write_one_page() and just unlock
> >  the page and regular cleaning will flush it out?
> > 
> 
> Of course - commit_write() will mark the page dirty and it'll get flushed
> back in the normal manner.  We don't need that set_page_dirty() in there
> either.

Ok, wasn't sure about the fact if it always dirtied the page for me.
I'll test it and get rid of it.

> But we do need some O_SYNC/S_ISSYNC handling...

Hrmpf so that isn't handled automagically. Noted.

-- 
Jens Axboe

