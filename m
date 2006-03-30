Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWC3Nxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWC3Nxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWC3Nxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:53:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19764 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932214AbWC3Nxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:53:38 -0500
Date: Thu, 30 Mar 2006 15:53:46 +0200
From: Jens Axboe <axboe@suse.de>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330135346.GL13476@suse.de>
References: <20060329122841.GC8186@suse.de> <20060330175406.fbd6d82c.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330175406.fbd6d82c.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, KAMEZAWA Hiroyuki wrote:
> On Wed, 29 Mar 2006 14:28:41 +0200
> Jens Axboe <axboe@suse.de> wrote:
> >
> > +	/*
> > +	 * Get as many pages from the page cache as possible..
> > +	 * Start IO on the page cache entries we create (we
> > +	 * can assume that any pre-existing ones we find have
> > +	 * already had IO started on them).
> > +	 */
> > +	i = find_get_pages(mapping, index, pages, array);
> > +
> 
> It looks page caches in this array is hold by pipe until data is consumed.
> So..this page cannot be reclaimd or migrated and hot-removed :).

Right

> I don't know about sendfile() but this looks client can hold server's
> memory, when server uses sendfile() 64k/conn.

You mean when the server uses splice, 64kb (well 16 pages actually) /
connection? That's a correct observation, I wouldn't think that pinning
that small a number of pages is likely to cause any issues. At least I
can think of much worse pinning by just doing IO :-)

> Is there a way to force these pages to be freed ? or page reclaimer
> can know this page is held by splice ? (we need additional PG_flags to
> do this ?)
> 
> I think these pages are necessary to be held only when data in them is
> used.

Not without tearing down the pipe.

-- 
Jens Axboe

