Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbULOAsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbULOAsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbULOApW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:45:22 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:31690 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261791AbULOAoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:44:04 -0500
Date: Wed, 15 Dec 2004 01:43:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
Message-ID: <20041215004335.GX16322@dualathlon.random>
References: <20041214164548.GA18817@kroah.com> <Pine.LNX.4.44.0412142304160.11826-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0412142304160.11826-100000@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 11:26:48PM +0000, Hugh Dickins wrote:
> On Tue, 14 Dec 2004, Greg KH wrote:
> > 
> > So I finally try to get dri working on my laptop and I get the following
> > kernel bug when killing X (the program gish was running at the time):
> > 
> > kernel BUG at mm/rmap.c:480!
> > EIP is at page_remove_rmap+0x32/0x40
> > Process gish (pid: 10864, threadinfo=c8aea000 task=c7c2c040)
> >  [<c0141495>] zap_pte_range+0x135/0x290
> >...
> >  [<c0145f41>] exit_mmap+0x71/0x140
> >  [<c01163c4>] mmput+0x24/0x80
> >  [<c011a756>] do_exit+0x146/0x370
> >...
> 
> It's my BUG_ON(page_mapcount(page) < 0).
> 
> We've had about one report per month, over the last six months.
> But this is the first citing "gish"; sometimes it's been "cc1".
> 
> I've given it a lot of thought, but I'm still mystified.  The last
> report turned out to be attributable to bad memory; but this BUG_ON
> is too persistent and specific to be put down to that in all cases.

The killing X smells like it could be related to drm or other kernel X
drivers. Could you try not to load the drm/agp stuff and see if it goes
away?
