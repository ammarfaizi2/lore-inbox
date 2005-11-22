Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVKVLLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVKVLLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbVKVLLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:11:04 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:14776 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964914AbVKVLLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:11:03 -0500
Date: Tue, 22 Nov 2005 11:10:58 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andi Kleen <ak@suse.de>, Andy Whitcroft <apw@shadowen.org>,
       linux-mm@kvack.org, mingo@elte.hu, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH 2/5] Light Fragmentation Avoidance V20: 002_usemap
In-Reply-To: <4382F8DD.9090908@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0511221110220.2476@skynet>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
 <200511160036.54461.ak@suse.de> <Pine.LNX.4.58.0511160137540.8470@skynet>
 <200511160252.05494.ak@suse.de> <Pine.LNX.4.58.0511160200530.8470@skynet>
 <4382EF48.1050107@shadowen.org> <20051122102237.GK20775@brahms.suse.de>
 <Pine.LNX.4.58.0511221026200.31192@skynet> <4382F8DD.9090908@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, KAMEZAWA Hiroyuki wrote:

> Mel Gorman wrote:
> > > #define PG_checked               8      /* kill me in 2.5.<early>. */
> > >
> > > ?
> > >
> > > At least PG_uncached isn't used on many architectures too, so could
> > > be reused. I don't know why those that use it don't check VMAs instead.
> > >
> >
> >
> > PG_unchecked appears to be totally unused. It's only users are the macros
> > that manipulate the bit and mm/page_alloc.c . It appears it has been a
> > long time since it was used to it is a canditate for reuse.
> >
>
> Just a notification..
> from 2.6.14
>
> PageUncached      375 include/asm-ia64/uaccess.h       if (PageUncached(page))
> PageUncached      393 include/asm-ia64/uaccess.h       if (PageUncached(page))
>
> This is used by /dev/mem
>
>
> PageChecked       196 fs/afs/dir.c     if (!PageChecked(page))
> PageChecked       169 fs/ext2/dir.c    if (!PageChecked(page))
> PageChecked      1372 fs/ext3/inode.c  if (!page_has_buffers(page) ||
> PageChecked(page)) {
> PageChecked      1441 fs/ext3/inode.c  WARN_ON(PageChecked(page));
> PageChecked      2350 fs/reiserfs/inode.c      int checked =
> PageChecked(page);
> PageChecked      2853 fs/reiserfs/inode.c      WARN_ON(PageChecked(page));
>
> This is used by fs, now.
>

d'oh. I was looking for the flags, not the macros :(

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
