Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275790AbRJFWgX>; Sat, 6 Oct 2001 18:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275789AbRJFWgO>; Sat, 6 Oct 2001 18:36:14 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:34565 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275778AbRJFWfz>; Sat, 6 Oct 2001 18:35:55 -0400
Date: Sun, 7 Oct 2001 00:36:23 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: arjan@fenrus.demon.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <E15px1O-0000Ee-00@fenrus.demon.nl>
Message-ID: <Pine.LNX.3.96.1011007003418.18004C-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In article <Pine.LNX.3.96.1011006210743.7808D-100000@artax.karlin.mff.cuni.cz> you wrote:
> 
> > NOTE: no allocations in IRQ are safe. Not only high-order ones. 
> > Allocation in IRQ may fail any time and you must recover without lost of
> > functionality (network can lose packets any time, if you are doing some
> > general device driver, you must preallocate all buffers in process
> > context).
> 
> how again do you deal with calling vfree() on the ones where you used
> vmalloc instead of the buddy allocator ?

It's in the patch: if someone calls get_free_pages on vmallocated memory,
it will be freed with vfree instead of __get_free_pages.

Of course you can't allocate memory in process context and free it in
interrupt context - which you could do without __GFP_VMALLOC.

Mikulas

