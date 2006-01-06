Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751881AbWAFBh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWAFBh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbWAFBh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:37:29 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:13000 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751881AbWAFBh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:37:28 -0500
Date: Fri, 06 Jan 2006 10:36:36 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: mel@csn.ul.ie (Mel Gorman)
Subject: Re: [Lhms-devel] Re: [Patch] New zone ZONE_EASY_RECLAIM take 4. (disable gfp_easy_reclaim bit)[5/8]
Cc: jschopp@austin.ibm.com, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
In-Reply-To: <20060105112305.GB14735@skynet.ie>
References: <20060105194849.4929.Y-GOTO@jp.fujitsu.com> <20060105112305.GB14735@skynet.ie>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060106103140.5643.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On (05/01/06 19:59), Yasunori Goto didst pronounce:
> > > On (05/01/06 14:43), Yasunori Goto didst pronounce:
> > > > > 
> > > > > > ===================================================================
> > > > > > --- zone_reclaim.orig/fs/pipe.c	2005-12-16 18:36:20.000000000 +0900
> > > > > > +++ zone_reclaim/fs/pipe.c	2005-12-16 19:15:35.000000000 +0900
> > > > > > @@ -284,7 +284,7 @@ pipe_writev(struct file *filp, const str
> > > > > >  			int error;
> > > > > >  
> > > > > >  			if (!page) {
> > > > > > -				page = alloc_page(GFP_HIGHUSER);
> > > > > > +				page = alloc_page(GFP_HIGHUSER & ~__GFP_EASY_RECLAIM);
> > > > > >  				if (unlikely(!page)) {
> > > > > >  					ret = ret ? : -ENOMEM;
> > > > > >  					break;
> > > > > 
> > > > > That is a bit hard to understand.  How about a new GFP_HIGHUSER_HARD or 
> > > > > somesuch define back in patch 1, then use it here?
> > > > 
> > > > It looks better. Thanks for your idea.
> > > > 
> > > 
> > > There are other places where GFP_HIGHUSER is used for pages that are not easily
> > > reclaimed. It is easier clearer to add __GFP_EASY_RECLAIM at the places you
> > > know pages are easily reclaimed rather than removing __GFP_EASY_RECLAIM from
> > > awkward places.
> > 
> > I thought that other pages can be migrated by Chlistoph-san's (and
> > Kame-san's) patch.
> 
> Then the pages are not "easily reclaimed", they can just be moved by
> some other mechanism.

Ah. My naming was no good. :-(


> > May I ask which page should be no EASY_RECLAIM?
> 
> Based on http://lxr.linux.no/ident?i=GFP_HIGHUSER, examples include HugeTLB
> pages, pages allocated by the infiniband driver, pages allocated by the NFS
> driver and inode pages.

Hmmmm.
Ok. Your proposal looks better.

Thanks.

-- 
Yasunori Goto 


