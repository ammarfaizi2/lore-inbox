Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932707AbWCPUKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbWCPUKS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWCPUKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:10:17 -0500
Received: from gold.veritas.com ([143.127.12.110]:65201 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932707AbWCPUKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:10:16 -0500
X-IronPort-AV: i="4.02,198,1139212800"; 
   d="scan'208"; a="57290985:sNHT30534816"
Date: Thu, 16 Mar 2006 20:10:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <1142538765.10950.16.camel@serpentine.pathscale.com>
Message-ID: <Pine.LNX.4.61.0603162003140.25033@goblin.wat.veritas.com>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Mar 2006 20:10:14.0850 (UTC) FILETIME=[A34D8A20:01C64935]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Bryan O'Sullivan wrote:
> 
> OK.  Would it be correct to say that this is what we should do, then?
> 
>       * On 2.6.15 and later kernels, use __GFP_COMP at allocation time,
>         and get_page in ->nopage.  This is what we're doing as of this
>         morning, and it works.
>       * For backports to 2.6.14 and earlier, avoid __GFP_COMP, mark each
>         page with SetPageReserved at allocation time, and do nothing
>         special in ->nopage.  Do we need to ClearPageReserved before
>         freeing?

Yes, I believe that's exactly right - so long as you do ClearPageReserved
from each of its constituent 0-order-pages before freeing the >0-order
page, in the <= 2.6.14 case.

You wisely remarked earlier that you'd not yet checked for memory leaks:
that is of course the complementary, less obvious, error to the troubles
you've been having so far: and I wish you luck when you come to check,
hoping that I haven't merely misled you from one side to the other!

Hugh
