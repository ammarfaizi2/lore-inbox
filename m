Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbWCPTwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbWCPTwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWCPTwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:52:50 -0500
Received: from mx.pathscale.com ([64.160.42.68]:37587 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932687AbWCPTwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:52:50 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603161629150.23220@goblin.wat.veritas.com>
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
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 16 Mar 2006 11:52:45 -0800
Message-Id: <1142538765.10950.16.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 17:23 +0000, Hugh Dickins wrote:

> But your backport driver will
> have to be using PageReserved still, not relying on __GFP_COMP: although
> __GFP_COMP was defined in 2.6.9 and a few earlier, it used to take effect
> only when #ifdef CONFIG_HUGETLB_PAGE - only in 2.6.15 did we make it
> available to all configurations.  You'll have irritating accounting
> differences between the two drivers: it used to be the case that put_page
> on a PageReserved page did nothing, so you had to avoid get_page on it to
> get the page accounting right; we straightened that out in 2.6.15.

OK.  Would it be correct to say that this is what we should do, then?

      * On 2.6.15 and later kernels, use __GFP_COMP at allocation time,
        and get_page in ->nopage.  This is what we're doing as of this
        morning, and it works.
      * For backports to 2.6.14 and earlier, avoid __GFP_COMP, mark each
        page with SetPageReserved at allocation time, and do nothing
        special in ->nopage.  Do we need to ClearPageReserved before
        freeing?

Thanks,

	<b

