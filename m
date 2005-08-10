Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVHJIkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVHJIkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 04:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbVHJIkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 04:40:12 -0400
Received: from Volter-FW.ser.netvision.net.il ([212.143.107.30]:61545 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S965045AbVHJIkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 04:40:10 -0400
Date: Wed, 10 Aug 2005 11:39:43 +0300
To: Hugh Dickins <hugh@veritas.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
Message-ID: <20050810083943.GM16361@minantech.com>
References: <20050719165542.GB16028@mellanox.co.il> <20050725171928.GC12206@mellanox.co.il> <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com> <20050726133553.GA22276@mellanox.co.il> <Pine.LNX.4.61.0508091759050.14886@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508091759050.14886@goblin.wat.veritas.com>
From: glebn@voltaire.com (Gleb Natapov)
X-OriginalArrivalTime: 10 Aug 2005 08:40:13.0066 (UTC) FILETIME=[1FDD26A0:01C59D87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 07:13:33PM +0100, Hugh Dickins wrote:
> Even more I'd prefer one of these two solutions below, which sidestep
> that uncleanliness - but both of these would be in mmap only, no clean
> way to change afterwards (except by munmap or mmap MAP_FIXED):
> 
> 1.  Use the standard mmap(NULL, len, PROT_READ|PROT_WRITE,
>     MAP_SHARED|MAP_ANONYMOUS, -1, 0) which gives you a memory object
>     shared with children, so write-protection and COW won't come into it.
> 
> or if there's good reason why that's no good,
> 
> 2.  Define a MAP_DONTCOPY to mmap: we have a fine tradition of MAP_flags
>     to achieve this or that effect, adding one more would be cleaner than
>     now corrupting mprotect or madvise.
> 
They are both relying on the way user allocates memory for RDMA. The idea behind 
Michael's propose it to let library (MPI for instance) to tell to the
kernel that the pages are used for RDMA and it is not safe to copy them now. 
The pages may be anywhere in the process address space bss, text, stack
whatever.

--
			Gleb.
