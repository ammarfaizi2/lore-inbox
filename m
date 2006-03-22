Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWCVRxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWCVRxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWCVRxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:53:41 -0500
Received: from mx.pathscale.com ([64.160.42.68]:18353 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932250AbWCVRxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:53:39 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603221729300.8148@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org>
	 <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
	 <1142523201.25297.56.camel@camp4.serpentine.com>
	 <Pine.LNX.4.61.0603161629150.23220@goblin.wat.veritas.com>
	 <1142538765.10950.16.camel@serpentine.pathscale.com>
	 <Pine.LNX.4.61.0603162003140.25033@goblin.wat.veritas.com>
	 <1142974347.29199.87.camel@serpentine.pathscale.com>
	 <Pine.LNX.4.61.0603212316001.16342@goblin.wat.veritas.com>
	 <1143043088.17406.17.camel@serpentine.pathscale.com>
	 <Pine.LNX.4.61.0603221729300.8148@goblin.wat.veritas.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 22 Mar 2006 09:53:39 -0800
Message-Id: <1143050019.17406.52.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 17:46 +0000, Hugh Dickins wrote:

> Ah, great, then I needn't look through your code, phew (no offence)!

Indeed :-)

> That may well be a good plan (given the doubts Nick raised about
> whether dma_alcohol_rent gives the right kind of struct page non-slab
> memory on all arches).

Well, it Works For Me (TM) right now.  Thank goodness.  And the driver
is about 200 lines shorter without the nopage handler and consequent
mucking about.

> But one way in which the stars will be slightly
> misaligned: for 2.6.14 and earlier you'll need to SetPageReserved on
> each constituent of the >0-page, to get remap_pfn_range to map it (and
> ClearPageReserved before freeing the >0-page); that won't do any harm
> on 2.6.15 and 2.6.16 (apart from enlarging the code unnecessarily);
> but we might one day remove those macros, from driver use anyway.

Yes, we're already doing this.  So far, I've tested on 2.6.12, 2.6.15,
and 2.6.16 using remap_pfn_range, and everything appears to be
cromulent.

	<b

