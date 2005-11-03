Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbVKCPAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbVKCPAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVKCPAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:00:52 -0500
Received: from gold.veritas.com ([143.127.12.110]:5729 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030244AbVKCPAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:00:51 -0500
Date: Thu, 3 Nov 2005 14:59:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
In-Reply-To: <20051103143713.GB31134@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0511031447080.23441@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511031333220.22885@goblin.wat.veritas.com>
 <20051103143713.GB31134@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Nov 2005 15:00:51.0259 (UTC) FILETIME=[619998B0:01C5E087]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Michael S. Tsirkin wrote:
> All existing drivers that set VM_DONTCOPY also set VM_IO.
> So lets just disable playing with these flags from madvise if VM_IO is set.
> There's no reason I can see that the driver should have a say
> on what the process does with its own (non-IO) memory.
> Sounds good?

You're then saying that a process cannot set VM_DONTCOPY on a VM_IO
area to prevent the first child getting the area, but clear it after
so the next child does get a copy of the area.  I think it'd be wrong
(surprising) to limit the functionality in that way.

> By the way, as a separate issue, we still have a problem with DMA to pages
> which are *needed* by the child process. What do you think about VM_COPY
> (to do the old unix thing of actually copying the page instead of
> setting the COW flag) and a matching madvise call to set/clear it?

I don't much want to add another path into copy_pte_range, actually
copying pages.  If the process really wants DMA into such areas,
then it should contain the code for the child to COW them itself?

Hugh
