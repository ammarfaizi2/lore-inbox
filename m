Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbVHJI1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVHJI1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 04:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVHJI1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 04:27:46 -0400
Received: from [194.90.237.34] ([194.90.237.34]:38600 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S965047AbVHJI1q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 04:27:46 -0400
Date: Wed, 10 Aug 2005 11:30:07 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Roland Dreier <roland@topspin.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
Message-ID: <20050810083007.GD2405@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050719165542.GB16028@mellanox.co.il> <20050725171928.GC12206@mellanox.co.il> <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com> <20050726133553.GA22276@mellanox.co.il> <Pine.LNX.4.61.0508091759050.14886@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508091759050.14886@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Hugh Dickins <hugh@veritas.com>:
> > > The other reason I dislike the patch is that the problem it fixes is
> > > an old one, and I'd much rather have get_user_pages fix it for itself,
> > 
> > Please note that the problem this attempts to solve is not limited
> > to pages locked by get_user_pages: in an infiniband userspace initiator,
> > a hardware page is mapped into process memory and must not be inherited
> > by a child processes, otherwise hardware protection breaks.
> 
> Interesting.
> 
> But (correct me if I'm wrong, I know nothing about InfiniBand userspace
> initiators) that would be done by a driver, which can set VM_DONTCOPY
> on the vma, without us having to extend the mprotect or madvise API

Roland, Hugh here proposes setting VM_DONTCOPY on user-mapped PIO
memory from driver on mmap, to protect against child process
corrupting parent's user access region.

IIRC, we used to set this bit, but it was removed later - could you please
clarify why? Do you think its a good idea to restore this behaviour?

-- 
MST
