Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWCPR1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWCPR1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbWCPR1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:27:04 -0500
Received: from gold.veritas.com ([143.127.12.110]:34647 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751264AbWCPR1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:27:03 -0500
X-IronPort-AV: i="4.02,198,1139212800"; 
   d="scan'208"; a="57282640:sNHT34354816"
Date: Thu, 16 Mar 2006 17:27:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <1142521718.25297.37.camel@camp4.serpentine.com>
Message-ID: <Pine.LNX.4.61.0603161724070.23220@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> 
 <ada4q27fban.fsf@cisco.com>  <1141948516.10693.55.camel@serpentine.pathscale.com>
  <ada1wxbdv7a.fsf@cisco.com>  <1141949262.10693.69.camel@serpentine.pathscale.com>
  <20060309163740.0b589ea4.akpm@osdl.org>  <1142470579.6994.78.camel@localhost.localdomain>
  <ada3bhjuph2.fsf@cisco.com>  <1142475069.6994.114.camel@localhost.localdomain>
  <adaslpjt8rg.fsf@cisco.com>  <1142477579.6994.124.camel@localhost.localdomain>
  <20060315192813.71a5d31a.akpm@osdl.org>  <1142485103.25297.13.camel@camp4.serpentine.com>
  <20060315213813.747b5967.akpm@osdl.org> <1142521718.25297.37.camel@camp4.serpentine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Mar 2006 17:27:02.0139 (UTC) FILETIME=[D6646CB0:01C6491E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Bryan O'Sullivan wrote:
> 
> This is more or less what we're doing now.  Except we're not doing a
> get_page after dma_alloc_coherent, and vmops->nopage is doing a
> get_page.  Reading between the lines, I guess the driver should be doing
> a get_page right after the allocation, and a put_page before it does the
> free?  This matches my mental model at least, but it seems that my model
> is a bit mental.

There's no need to do a get_page after the allocation and a put_page
before the free (though you could, it's just extra unnecessary work):
the allocation comes with a reference count of 1, the free frees up
that last remaining reference count of 1 (as Andrew explained more
lucidly elsewhere in his mail).

Hugh
