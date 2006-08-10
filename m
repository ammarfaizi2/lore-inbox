Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWHJJAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWHJJAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWHJJAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:00:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57796 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751477AbWHJJAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:00:17 -0400
Date: Thu, 10 Aug 2006 02:00:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: zam@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix error case in fuse_readpages
Message-Id: <20060810020009.da64e461.akpm@osdl.org>
In-Reply-To: <E1GB6Ax-0002Wn-00@dorka.pomaz.szeredi.hu>
References: <E1GB5Pu-0002TI-00@dorka.pomaz.szeredi.hu>
	<20060810011006.45ba6eb7.akpm@osdl.org>
	<E1GB6Ax-0002Wn-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 10:45:59 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:

> > > Thanks Alex.
> > > 
> > > -mm also needs s/page_cache_release/read_cache_pages_release_page/ on patch
> > > 
> > > --
> > > From: Alexander Zarochentsev <zam@namesys.com>
> > > 
> > > Don't let fuse_readpages leave the @pages list not empty when exiting
> > > on error.
> > > 
> > 
> > hm, OK.
> > 
> > > +extern void readpages_cleanup_helper(struct list_head *);
> > 
> > Can we think of a better name?  I mean, all it does is throw away a list of
> > pages.  The caller doesn't _have_ to be using it within the context of
> > read_cache_pages().  put_pages()?  put_pages_list()?
> 
> So what's up with read_cache_pages_release_page() in -mm, which seems
> to be rather specific to read_cache_pages()?
> 

That's part of the readahead patches.  Don't look at that ;)
