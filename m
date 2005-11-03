Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVKCOeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVKCOeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbVKCOeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:34:19 -0500
Received: from [194.90.237.34] ([194.90.237.34]:4292 "EHLO mtlex01.yok.mtl.com")
	by vger.kernel.org with ESMTP id S1751343AbVKCOeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:34:18 -0500
Date: Thu, 3 Nov 2005 16:37:14 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051103143713.GB31134@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.61.0511031333220.22885@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511031333220.22885@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hugh Dickins <hugh@veritas.com>:
> Two warnings if someone would like to post a MADV_DONTCOPY patch.
> It should include a matching MADV_DOCOPY to clear the condition, but
> that must not be allowed to clear VM_DONTCOPY set originally by driver:
> perhaps you'll end up with a VM_UDONTCOPY or something like that.

Thanks!
All existing drivers that set VM_DONTCOPY also set VM_IO.
So lets just disable playing with these flags from madvise if VM_IO is set.
There's no reason I can see that the driver should have a say
on what the process does with its own (non-IO) memory.
Sounds good?

By the way, as a separate issue, we still have a problem with DMA to pages
which are *needed* by the child process. What do you think about VM_COPY
(to do the old unix thing of actually copying the page instead of
setting the COW flag) and a matching madvise call to set/clear it?

> And Badari has a MADV_REMOVE patch in the works, taking the next
> slot (just after MADV_DONTNEED in most of the arches): probably
> best for you to base yours on top of his (though yours is simpler
> and might jump ahead).
> 
> Hugh

Yep, I saw that posted for inclusion in -mm.

-- 
MST
