Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUDHMlo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 08:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUDHMlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 08:41:44 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:45782 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261735AbUDHMlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 08:41:42 -0400
Date: Thu, 08 Apr 2004 21:41:36 +0900 (JST)
Message-Id: <20040408.214136.133069123.taka@valinux.co.jp>
To: mbligh@aracnet.com
Cc: kravetz@us.ibm.com, iwamoto@valinux.co.jp, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [patch 0/3] memory hotplug prototype
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3840000.1081377218@flay>
References: <29700000.1081361575@flay>
	<20040407185953.GC4292@w-mikek2.beaverton.ibm.com>
	<3840000.1081377218@flay>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> >> > This is an updated version of memory hotplug prototype patch, which I
> >> > have posted here several times.
> >> 
> >> I really, really suggest you take a look at Dave McCracken's work, which
> >> he posted as "Basic nonlinear for x86" recently. It's going to be much
> >> much easier to use this abstraction than creating 1000s of zones ...
> >> 
> > 
> > I agree.  However, one could argue that taking a zone offline is 'easier'
> > than taking a 'section' offline: at least right now.  Note that I said
> > easier NOT better.  Currently a section represents a subset of one or more
> > zones.  Ideally, these sections represent units that can be added or
> > removed.  IIRC these sections only define a range of physical memory.
> > To determine if it is possible to take a section offline, one needs to
> > dig into the zone(s) that the section may be associated with.  We'll
> > have to do things like:
> > - Stop allocations of pages associated with the section.
> > - Grab all 'free pages' associated with the section.
> > - Try to reclaim/free all pages associated with the section.
> >   - Work on this until all pages in the section are not in use (or free).
> >   - OR give up if we know we will not succeed.
> > 
> > My claim of zones being easier to work with today is due to the
> > fact that zones contain much of the data/infrastructure to make
> > these types of operations easy.  For example, in IWAMOTO's code a
> > node/zone can be take offline when 'z->present_pages == z->free_pages'.
> 
> I really think the level of difference in difficultly here is trivial.
> The hard bit is freeing the pages, not measuring them. I would suspect
> altering the swap path to just not "free" the pages, but put them into
> a pool for hotplug is fairly easy.

This is what IWAMOTO did.

The swap path won't work well as you expect since it can't handle
busy pages. It just skips them and only frees silent pages.

And page cache memory without backing store can't be handled
either.

Regards,
Hirokazu Takahashi

