Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVBQXLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVBQXLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVBQXJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:09:13 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:24720 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261226AbVBQXDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:03:47 -0500
Date: Fri, 18 Feb 2005 00:03:42 +0100
From: Andi Kleen <ak@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andi Kleen <ak@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] page table iterators
Message-ID: <20050217230342.GA3115@wotan.suse.de>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au> <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108680578.5665.14.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I though about both ways yesterday, and in the end, I prefer Nick stuff,
> at least for now. It gives us also more flexibility to change gory
> implementation details in the future. I still have to run it through a
> bit of torture testing though.

They're really solving different problems. My code is just aimed
at getting x86-64 fork/exec/etc. as fast as before 4level again
(currently they are significantly slower because they have to walk
a lot more page tables) 

The problem is that the index based approach (I think you have to use
indexes for this, pointers get very messy) probably does not 
fit very well into Nick's complex macros.  

Nick's macros are essentially just code transformations with
some micro optimizations. 

That's not bad, but it won't give you the big speedups 
the lazy walking approach will give.

And to be honest we only have about 6 or 7 of these walkers
in the whole kernel. And 90% of them are in memory.c
While doing 4level I think I changed all of them around several
times and it wasn't that big an issue.  So it's not that we
have a big pressing problem here... 

-Andi
