Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWCPOeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWCPOeD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 09:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWCPOeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 09:34:03 -0500
Received: from silver.veritas.com ([143.127.12.111]:28422 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751141AbWCPOeB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 09:34:01 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,197,1139212800"; 
   d="scan'208"; a="35973233:sNHT24247648"
Date: Thu, 16 Mar 2006 14:34:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       "Bryan O'Sullivan" <bos@pathscale.com>, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <4419062C.6000803@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0603161426010.21570@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
 <ada4q27fban.fsf@cisco.com> <1141948516.10693.55.camel@serpentine.pathscale.com>
 <ada1wxbdv7a.fsf@cisco.com> <1141949262.10693.69.camel@serpentine.pathscale.com>
 <20060309163740.0b589ea4.akpm@osdl.org> <1142470579.6994.78.camel@localhost.localdomain>
 <ada3bhjuph2.fsf@cisco.com> <1142475069.6994.114.camel@localhost.localdomain>
 <adaslpjt8rg.fsf@cisco.com> <1142477579.6994.124.camel@localhost.localdomain>
 <20060315192813.71a5d31a.akpm@osdl.org> <1142485103.25297.13.camel@camp4.serpentine.com>
 <20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com>
 <4419062C.6000803@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Mar 2006 14:34:01.0240 (UTC) FILETIME=[AAE4F180:01C64906]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Nick Piggin wrote:
> > 
> > How about the case where one wants to map pages from
> > dma_alloc_coherent() into userspace?  It seems one should do
> > get_page() in .nopage, and then the driver can do dma_free_coherent()
> > when the vma is released.
> 
> I think so, provided you set VM_IO on the vma. You need VM_IO to
> ensure that get_user_pages callers can't hijack your page's lifetime
> rules

Once __GFP_COMP is passed to the dma_alloc_coherent, as it needs to be
(unless going VM_PFNMAP), get_user_pages will be safe: no need for VM_IO.

Hugh
