Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbWCPUff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWCPUff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbWCPUff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:35:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932722AbWCPUfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:35:34 -0500
Date: Thu, 16 Mar 2006 12:35:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: "Bryan O'Sullivan" <bos@pathscale.com>, Andrew Morton <akpm@osdl.org>,
       rdreier@cisco.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <Pine.LNX.4.61.0603162003140.25033@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0603161234160.3618@g5.osdl.org>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> 
 <ada4q27fban.fsf@cisco.com>  <1141948516.10693.55.camel@serpentine.pathscale.com>
  <ada1wxbdv7a.fsf@cisco.com>  <1141949262.10693.69.camel@serpentine.pathscale.com>
  <20060309163740.0b589ea4.akpm@osdl.org>  <1142470579.6994.78.camel@localhost.localdomain>
  <ada3bhjuph2.fsf@cisco.com>  <1142475069.6994.114.camel@localhost.localdomain>
  <adaslpjt8rg.fsf@cisco.com>  <1142477579.6994.124.camel@localhost.localdomain>
  <20060315192813.71a5d31a.akpm@osdl.org>  <1142485103.25297.13.camel@camp4.serpentine.com>
  <20060315213813.747b5967.akpm@osdl.org>  <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
  <1142523201.25297.56.camel@camp4.serpentine.com> 
 <Pine.LNX.4.61.0603161629150.23220@goblin.wat.veritas.com>
 <1142538765.10950.16.camel@serpentine.pathscale.com>
 <Pine.LNX.4.61.0603162003140.25033@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Mar 2006, Hugh Dickins wrote:

> On Thu, 16 Mar 2006, Bryan O'Sullivan wrote:
> > 
> > OK.  Would it be correct to say that this is what we should do, then?
> > 
> >       * On 2.6.15 and later kernels, use __GFP_COMP at allocation time,
> >         and get_page in ->nopage.  This is what we're doing as of this
> >         morning, and it works.
> >       * For backports to 2.6.14 and earlier, avoid __GFP_COMP, mark each
> >         page with SetPageReserved at allocation time, and do nothing
> >         special in ->nopage.  Do we need to ClearPageReserved before
> >         freeing?
> 
> Yes, I believe that's exactly right - so long as you do ClearPageReserved
> from each of its constituent 0-order-pages before freeing the >0-order
> page, in the <= 2.6.14 case.

The alternative is to always allocate the pages one by one ("order-0"), 
and do get_page() when you return them in the ->nopage handler. That will 
work with any kernel, so it has the simplicity thing going for it.

		Linus
