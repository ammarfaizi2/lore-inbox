Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbVKCPLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbVKCPLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVKCPLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:11:24 -0500
Received: from [194.90.237.34] ([194.90.237.34]:13014 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1030285AbVKCPLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:11:23 -0500
Date: Thu, 3 Nov 2005 17:14:21 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051103151421.GD31134@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.61.0511031447080.23441@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511031447080.23441@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hugh Dickins <hugh@veritas.com>:
> > All existing drivers that set VM_DONTCOPY also set VM_IO.
> > So lets just disable playing with these flags from madvise if VM_IO is set.
> > There's no reason I can see that the driver should have a say
> > on what the process does with its own (non-IO) memory.
> > Sounds good?
> 
> You're then saying that a process cannot set VM_DONTCOPY on a VM_IO
> area to prevent the first child getting the area, but clear it after
> so the next child does get a copy of the area.  I think it'd be wrong
> (surprising) to limit the functionality in that way.

Okay, I guess. I am just trying to avoid more VM_ flags.
Cant we get rid of the last requirement, then?
I dont see why the driver should have a say on what the process does with its
own memory.

> > By the way, as a separate issue, we still have a problem with DMA to pages
> > which are *needed* by the child process. What do you think about VM_COPY
> > (to do the old unix thing of actually copying the page instead of
> > setting the COW flag) and a matching madvise call to set/clear it?
> 
> I don't much want to add another path into copy_pte_range, actually
> copying pages.  If the process really wants DMA into such areas,
> then it should contain the code for the child to COW them itself?
> 
> Hugh

How do you do that, say, for a stack page, or global data section?

-- 
MST
