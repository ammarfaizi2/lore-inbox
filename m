Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUDHMKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 08:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUDHMKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 08:10:11 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:16086 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261704AbUDHMKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 08:10:06 -0400
Date: Thu, 08 Apr 2004 21:10:03 +0900 (JST)
Message-Id: <20040408.211003.128419019.taka@valinux.co.jp>
To: mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Cc: iwamoto@valinux.co.jp
Subject: Re: [Lhms-devel] Re: [patch 0/3] memory hotplug prototype
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040408101904.D6ED4706C3@sv1.valinux.co.jp>
References: <29700000.1081361575@flay>
	<20040408091610.65C29706C3@sv1.valinux.co.jp>
	<20040408101904.D6ED4706C3@sv1.valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > > > This is an updated version of memory hotplug prototype patch, which I
> > > > have posted here several times.
> > > 
> > > I really, really suggest you take a look at Dave McCracken's work, which
> > > he posted as "Basic nonlinear for x86" recently. It's going to be much
> > > much easier to use this abstraction than creating 1000s of zones ...
> > 
> > Well, I think his patch is orthogonal to mine.  My ultimate target
> > is IA64 and it will only support node-sized memory hotplugging.
> > 
> > If you need fine-grained memory resizing, that shouldn't be hard to
> > do.  As others have pointed out, per section hotremovable is not as
> > easy as per zone one, but we've done a similar thing for hugetlbfs
> > support.  Look for PG_again in Takahashi's patch.
> 
> Err, s/PG_again/PG_booked/
> Pages with PG_booked bit set are skipped in alloc_pages.
> Alternatively, when such pages are freed, they can be linked to
> another list than free_list to avoid being used again, but buddy
> bits handling would be a bit tricky in this case.

It might be possible but it's not easy to do.

If page count equals 0, where do you think the page is?
It might be in the buddy system or in the per-cpu-pages pools,
or it might be a part of coumpound page, or it's just being
allocated/freed. If it in the buddy system, which free_area of zones
is it linked?  

It's very hard to determin that where it is, so that
I introduced PG_booked flag to avoid to re-use it.

Is there any better way?


Thank you,
Hirokazu Takahashi.
