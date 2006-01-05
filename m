Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWAELXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWAELXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbWAELXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:23:31 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:32188 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1752150AbWAELXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:23:30 -0500
Date: Thu, 5 Jan 2006 11:23:06 +0000
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: jschopp@austin.ibm.com, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Patch] New zone ZONE_EASY_RECLAIM take 4. (disable gfp_easy_reclaim bit)[5/8]
Message-ID: <20060105112305.GB14735@skynet.ie>
References: <20060105144247.491D.Y-GOTO@jp.fujitsu.com> <20060105094726.GA14735@skynet.ie> <20060105194849.4929.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060105194849.4929.Y-GOTO@jp.fujitsu.com>
User-Agent: Mutt/1.5.9i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/01/06 19:59), Yasunori Goto didst pronounce:
> > On (05/01/06 14:43), Yasunori Goto didst pronounce:
> > > > 
> > > > > ===================================================================
> > > > > --- zone_reclaim.orig/fs/pipe.c	2005-12-16 18:36:20.000000000 +0900
> > > > > +++ zone_reclaim/fs/pipe.c	2005-12-16 19:15:35.000000000 +0900
> > > > > @@ -284,7 +284,7 @@ pipe_writev(struct file *filp, const str
> > > > >  			int error;
> > > > >  
> > > > >  			if (!page) {
> > > > > -				page = alloc_page(GFP_HIGHUSER);
> > > > > +				page = alloc_page(GFP_HIGHUSER & ~__GFP_EASY_RECLAIM);
> > > > >  				if (unlikely(!page)) {
> > > > >  					ret = ret ? : -ENOMEM;
> > > > >  					break;
> > > > 
> > > > That is a bit hard to understand.  How about a new GFP_HIGHUSER_HARD or 
> > > > somesuch define back in patch 1, then use it here?
> > > 
> > > It looks better. Thanks for your idea.
> > > 
> > 
> > There are other places where GFP_HIGHUSER is used for pages that are not easily
> > reclaimed. It is easier clearer to add __GFP_EASY_RECLAIM at the places you
> > know pages are easily reclaimed rather than removing __GFP_EASY_RECLAIM from
> > awkward places.
> 
> I thought that other pages can be migrated by Chlistoph-san's (and
> Kame-san's) patch.

Then the pages are not "easily reclaimed", they can just be moved by
some other mechanism.

> May I ask which page should be no EASY_RECLAIM?

Based on http://lxr.linux.no/ident?i=GFP_HIGHUSER, examples include HugeTLB
pages, pages allocated by the infiniband driver, pages allocated by the NFS
driver and inode pages.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
