Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbULOStI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbULOStI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbULOStI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:49:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:26939 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262446AbULOStB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:49:01 -0500
Date: Wed, 15 Dec 2004 18:48:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
In-Reply-To: <20041215175805.GA9207@kroah.com>
Message-ID: <Pine.LNX.4.44.0412151830270.3267-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004, Greg KH wrote:
> On Wed, Dec 15, 2004 at 05:23:14PM +0000, Hugh Dickins wrote:
> > 
> > I think it very likely that your page_remove_rmap BUGs are caused by
> > the first idea that occurred to me, months back, which intervening
> > reports didn't seem to fit with: PageReserved(page) when the page is
> > mapped into userspace, but !PageReserved(page) when it gets unmapped.
> > 
> > Which would suggest some kind of refcounting bug in drivers/char/drm/,
> > such that the reserved pages get unreserved and freed before their
> > last unmap.  I've started looking for that, but drivers/char/drm/ is
> > unfamiliar territory to me, so I'd be glad for someone to beat me to it.
...
> > I'll report back whether they confirm or refute the hypothesis.
> 
> Here's the files.  gish.map has the map file and I've put the dmesg
> output inline below.

Thanks a lot.  They seem to refute the PageReserved -> !PageReserved
theory.  It sure looks like a problem in this area (gish.maps shows
this vma maps /dev/dri/card0), but not quite what I was expecting.

> If there's anything else I can do to help out, please let me know.

Thanks: I'm sure there will be later, but right now I need to
look further around that source before proposing anything more.

> Bad rmap in gish: page c1279380 flags 20000014 count 3 mapcount 0 addr b6913000 vm_flags 800fb
....
> Bad rmap in gish: page c127d360 flags 20000014 count 2 mapcount 0 addr b6b12000 vm_flags 800fb

And in gish.maps:
> b6b13000-b6b14000 r--s d8246000 00:0a 10806      /dev/dri/card0

Hugh

