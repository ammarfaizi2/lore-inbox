Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVHKOH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVHKOH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVHKOH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:07:58 -0400
Received: from Volter-FW.ser.netvision.net.il ([212.143.107.30]:2271 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750944AbVHKOH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:07:57 -0400
Date: Thu, 11 Aug 2005 17:07:30 +0300
To: Hugh Dickins <hugh@veritas.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
Message-ID: <20050811140729.GU16361@minantech.com>
References: <20050725171928.GC12206@mellanox.co.il> <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com> <20050726133553.GA22276@mellanox.co.il> <Pine.LNX.4.61.0508091759050.14886@goblin.wat.veritas.com> <20050810083943.GM16361@minantech.com> <Pine.LNX.4.61.0508101412530.3153@goblin.wat.veritas.com> <20050810132611.GP16361@minantech.com> <Pine.LNX.4.61.0508101623480.4525@goblin.wat.veritas.com> <20050811080205.GR16361@minantech.com> <Pine.LNX.4.61.0508111446030.10888@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508111446030.10888@goblin.wat.veritas.com>
From: glebn@voltaire.com (Gleb Natapov)
X-OriginalArrivalTime: 11 Aug 2005 14:07:51.0969 (UTC) FILETIME=[0FE57110:01C59E7E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 03:04:29PM +0100, Hugh Dickins wrote:
> On Thu, 11 Aug 2005, Gleb Natapov wrote:
> > What about the idea that was floating around about new VM flag that will
> > instruct kernel to copy pages belonging to the vma on fork instead of mark
> > them as cow?
> 
> It's a pretty good idea, and thanks for reminding us of it.
> 
> It suffers from the general difficulty with fixes within get_user_pages,
> that we need down_write(&mm->mmap_sem) to split_vma, and even just to
> update vm_flags, whereas get_user_pages is entered with down_read.
> 
Why do it form get_user_pages? Lets use madvise/mprotect interface.
Program can mrpotect(VM_COPYONFORK) address range before registering it.

--
			Gleb.
