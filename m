Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVBQIds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVBQIds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 03:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVBQIds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 03:33:48 -0500
Received: from one.firstfloor.org ([213.235.205.2]:48524 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262229AbVBQIdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 03:33:47 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix buf in zeromap_pud_range() losing virtual address
References: <1108625191.5425.61.camel@gaston>
From: Andi Kleen <ak@muc.de>
Date: Thu, 17 Feb 2005 09:33:46 +0100
In-Reply-To: <1108625191.5425.61.camel@gaston> (Benjamin Herrenschmidt's
 message of "Thu, 17 Feb 2005 18:26:31 +1100")
Message-ID: <m1zmy31t79.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>
> zeromap_pud_range() is one of these page tables walking functions that
> split the address into a base and an offset. It forgets to add back the
> "base" when calling the lower level zeromap_pmd_range(), thus passing a
> bogus virtual address. Most archs won't care, unless they do the above,
> since the lower level can allocate a PTE page.

Hmm, there might be even more cases of this. I remember pondering
it when I did the original 4 level work (sometimes we discard higher level 
virtual address bits during walking)

> (Note: We are in _urgent_ need to consolidate all those page table
> walking functions, they all do things in a subtely different way, with
> different checks (sometimes redudant) and inconsitent with each other,
> even within a given set of them. Hopefully, Nick has some work in
> progress there).

I have. But it will just make them more similar, not completely consolidate
them into an iterator, because that's too hard/ugly to do efficiently.

-Andi
