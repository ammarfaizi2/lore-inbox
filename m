Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWBMTuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWBMTuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWBMTuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:50:01 -0500
Received: from gold.veritas.com ([143.127.12.110]:22635 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964817AbWBMTuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:50:00 -0500
Date: Mon, 13 Feb 2006 19:50:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: William Irwin <wli@holomorphy.com>, Roland Dreier <rdreier@cisco.com>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [openib-general] Re: madvise MADV_DONTFORK/MADV_DOFORK
In-Reply-To: <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0602131943050.9573@goblin.wat.veritas.com>
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
 <adar767133j.fsf@cisco.com> <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Feb 2006 19:49:59.0986 (UTC) FILETIME=[AC61C120:01C630D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Linus Torvalds wrote:
> 
> and the usage ends up matching that (except for some really strange issue 
> with hugepage counting, which just looks wrong, but never mind).

Yes, I cc'ed wli on my reply to Michael,
we're hoping he'll just say delete that block.

> I can see where Hugh is coming from, but I think it's adding cruft very 
> much for a "be very careful" reason.
> 
> I would suggest that if you wanted to be very careful, you'd simply 
> disallow changing - or perhaps just clearing - that DONTCOPY flag on 
> special regions (ie ones that have been marked with VM_IO or VM_RESERVED).

Fair enough, disallow clearing on VM_IO (VM_RESERVED is on its way out,
does little more than perpetuate a few accounting anomalies I think).
So no new VM_DONTFORK flag, stick with VM_DONTCOPY: that's fine with me.

Hugh
