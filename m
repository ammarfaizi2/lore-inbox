Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291218AbSAaSeK>; Thu, 31 Jan 2002 13:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291221AbSAaSeB>; Thu, 31 Jan 2002 13:34:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64773 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291218AbSAaSdt>; Thu, 31 Jan 2002 13:33:49 -0500
Date: Thu, 31 Jan 2002 10:32:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>, Momchil Velikov <velco@fadata.bg>,
        John Stoffel <stoffel@casc.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020131190202.I1309@athlon.random>
Message-ID: <Pine.LNX.4.33.0201311031180.1637-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jan 2002, Andrea Arcangeli wrote:
> >
> > The radix tree is basically O(1), because the maximum depth of a 7-bit
> > radix tree is just 5. The index is only a 32-bit number.
>
> then it will break on archs with more ram than 1<<(32+PAGE_CACHE_SHIFT).

NO.

The radix tree is an index lookup mechanism.

The index is 32 bits.

That's true regardless of how much RAM you have.

> Also there must be some significant memory overhead that can be
> triggered with a certain layout of pages, in some configuration it
> should take much more ram than the hashtable if I understood well how it
> works.

Considering that the radix tree can _remove_ 8 bytes per "struct page", I
suspect you potentially win more memory than you lose.

		Linus

