Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWCPRqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWCPRqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWCPRqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:46:15 -0500
Received: from gold.veritas.com ([143.127.12.110]:31120 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932435AbWCPRqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:46:14 -0500
X-IronPort-AV: i="4.02,198,1139212800"; 
   d="scan'208"; a="57283639:sNHT32080436"
Date: Thu, 16 Mar 2006 17:46:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <1142521943.25297.42.camel@camp4.serpentine.com>
Message-ID: <Pine.LNX.4.61.0603161738010.23812@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> 
 <ada4q27fban.fsf@cisco.com>  <1141948516.10693.55.camel@serpentine.pathscale.com>
  <ada1wxbdv7a.fsf@cisco.com>  <1141949262.10693.69.camel@serpentine.pathscale.com>
  <20060309163740.0b589ea4.akpm@osdl.org>  <1142470579.6994.78.camel@localhost.localdomain>
  <ada3bhjuph2.fsf@cisco.com>  <1142475069.6994.114.camel@localhost.localdomain>
  <adaslpjt8rg.fsf@cisco.com>  <1142477579.6994.124.camel@localhost.localdomain>
  <20060315192813.71a5d31a.akpm@osdl.org>  <1142485103.25297.13.camel@camp4.serpentine.com>
  <20060315213813.747b5967.akpm@osdl.org>  <ada8xrbszmx.fsf@cisco.com>
 <1142521943.25297.42.camel@camp4.serpentine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Mar 2006 17:46:14.0037 (UTC) FILETIME=[84FA1C50:01C64921]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Bryan O'Sullivan wrote:
> On Wed, 2006-03-15 at 21:54 -0800, Roland Dreier wrote:
> 
> > How about the case where one wants to map pages from
> > dma_alloc_coherent() into userspace?
> 
> This is precisely our case, btw.  The pages in question are allocated
> during fops->open (some during dev->probe).  mmap and nopage never
> allocate anything.
> 
> >   It seems one should do
> > get_page() in .nopage, and then the driver can do dma_free_coherent()
> > when the vma is released.
> 
> If that were the case, I'm unclear on how I would do this.  Add a
> vmops->close method along with the existing vmops->nopage handler?

If neither mmap nor nopage allocated something, then vmops->close
would be the wrong point at which to free it, I think.

If dev->probe allocated something, module unload would be the right
point to free it.  If fops->open allocated something, fops->release
would be the right point to free it.

I think.  Beware, I've never written a Linux driver, and may well
have this wrong or oversimplified: in which case, I'll have annoyed
someone enough for them to correct me very soon.

Hugh
