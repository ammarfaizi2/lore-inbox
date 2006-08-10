Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161156AbWHJIqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbWHJIqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 04:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161158AbWHJIqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 04:46:19 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:18395 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1161156AbWHJIqT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 04:46:19 -0400
To: akpm@osdl.org
CC: zam@namesys.com, linux-kernel@vger.kernel.org
In-reply-to: <20060810011006.45ba6eb7.akpm@osdl.org> (message from Andrew
	Morton on Thu, 10 Aug 2006 01:10:06 -0700)
Subject: Re: [PATCH] fuse: fix error case in fuse_readpages
References: <E1GB5Pu-0002TI-00@dorka.pomaz.szeredi.hu> <20060810011006.45ba6eb7.akpm@osdl.org>
Message-Id: <E1GB6Ax-0002Wn-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 10 Aug 2006 10:45:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thanks Alex.
> > 
> > -mm also needs s/page_cache_release/read_cache_pages_release_page/ on patch
> > 
> > --
> > From: Alexander Zarochentsev <zam@namesys.com>
> > 
> > Don't let fuse_readpages leave the @pages list not empty when exiting
> > on error.
> > 
> 
> hm, OK.
> 
> > +extern void readpages_cleanup_helper(struct list_head *);
> 
> Can we think of a better name?  I mean, all it does is throw away a list of
> pages.  The caller doesn't _have_ to be using it within the context of
> read_cache_pages().  put_pages()?  put_pages_list()?

So what's up with read_cache_pages_release_page() in -mm, which seems
to be rather specific to read_cache_pages()?

Miklos
