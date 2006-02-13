Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWBMWyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWBMWyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWBMWyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:54:14 -0500
Received: from gold.veritas.com ([143.127.12.110]:6444 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030230AbWBMWyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:54:14 -0500
Date: Mon, 13 Feb 2006 22:54:57 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Linus Torvalds <torvalds@osdl.org>, William Irwin <wli@holomorphy.com>,
       Roland Dreier <rdreier@cisco.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [openib-general] Re: madvise MADV_DONTFORK/MADV_DOFORK
In-Reply-To: <20060213220947.GD13603@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0602132249150.4526@goblin.wat.veritas.com>
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
 <adar767133j.fsf@cisco.com> <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
 <Pine.LNX.4.61.0602131943050.9573@goblin.wat.veritas.com>
 <20060213210906.GC13603@mellanox.co.il> <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com>
 <20060213220947.GD13603@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Feb 2006 22:54:12.0895 (UTC) FILETIME=[686DD2F0:01C630F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, Michael S. Tsirkin wrote:
> Quoting r. Hugh Dickins <hugh@veritas.com>:
> 
> > Comments much better, thanks.  I didn't get your point about mlock'd
> > memory, but I'm content to believe you're thinking of an issue that
> > hasn't occurred to me.
> 
> I'm referring to the follwing, from man mlock(2):
> 
> "Cryptographic  security  software often handles critical bytes like passwords
> or secret keys as data structures. As a result of paging, these secrets could
> be  transfered  onto  a persistent swap store medium, where they might be
> accessible to the enemy long after the security  software  has erased the
> secrets in RAM and terminated."

Ah, I get it, thanks: once parent and child have distinct pages,
the child's is not locked in memory and might go out to swap.
Yes, a valid point, and a relevant use for MADV_DONTFORK.

Hugh
