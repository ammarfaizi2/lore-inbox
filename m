Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbVHPHwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbVHPHwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 03:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbVHPHwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 03:52:50 -0400
Received: from Volter-FW.ser.netvision.net.il ([212.143.107.30]:5192 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S965136AbVHPHwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 03:52:50 -0400
Date: Tue, 16 Aug 2005 10:52:17 +0300
To: Bill Jordan <woodennickel@gmail.com>
Cc: Hugh Dickins <hugh@veritas.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
Message-ID: <20050816075217.GA6232@minantech.com>
References: <20050725171928.GC12206@mellanox.co.il> <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com> <20050726133553.GA22276@mellanox.co.il> <Pine.LNX.4.61.0508091759050.14886@goblin.wat.veritas.com> <20050810083943.GM16361@minantech.com> <Pine.LNX.4.61.0508101412530.3153@goblin.wat.veritas.com> <20050810132611.GP16361@minantech.com> <Pine.LNX.4.61.0508101623480.4525@goblin.wat.veritas.com> <20050811080205.GR16361@minantech.com> <5ebee0d10508150937da6c1ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ebee0d10508150937da6c1ed@mail.gmail.com>
From: glebn@voltaire.com (Gleb Natapov)
X-OriginalArrivalTime: 16 Aug 2005 07:52:38.0442 (UTC) FILETIME=[78DA98A0:01C5A237]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 12:37:50PM -0400, Bill Jordan wrote:
> On 8/11/05, Gleb Natapov <glebn@voltaire.com> wrote:
> > What about the idea that was floating around about new VM flag that will
> > instruct kernel to copy pages belonging to the vma on fork instead of mark
> > them as cow?
> > 
> 
> I think the big problem with this idea is the huge memory regions that
> InfiniBand applications are dealing with. If the application forks (or
> uses system()), you are going to copy a huge chunk of data (most
> likely swapping since the application memory footprint is probably
> already tuned to consume the available physical memory). And the copy
> is really for nothing since in most (or at least many) cases the child
> is just going to exec anyway.
If the child is going to exec it may call vfork or clone with CLONE_VM
flag. glibc system(3) does clone (CLONE_PARENT_SETTID | SIGCHLD) why not
CLONE_VM too? This single change will allow to use system() from MPI
programs thus eliminating many users problem. 
If the child isn't going to exec it should face the music.

--
			Gleb.
