Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbSA2VwB>; Tue, 29 Jan 2002 16:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281916AbSA2Vvw>; Tue, 29 Jan 2002 16:51:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58381 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281214AbSA2Vvh>; Tue, 29 Jan 2002 16:51:37 -0500
Date: Tue, 29 Jan 2002 13:50:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.44.0201291512330.25443-100000@waste.org>
Message-ID: <Pine.LNX.4.33.0201291326340.1334-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Oliver Xymoron wrote:
>
> I don't think read-only for the tables is sufficient if the pages
> themselves are writable.

At least on x86, the WRITE bit in the page directory entries will override
any bits int he PTE. In other words, it doesn't make the page directory
entries thmselves unwritable - it makes the final pages unwritable.

Which are exactly the semantics we want.

I have this strong feeling (but am lazy enough to not try to find the
documentation) that on alpha the access bits in the upper page tables are
just ignored (ie you have to actually turn off the present bit), which is
a bit sad as it shouldn't matter from a PAL-code standpoint (just two more
"and" instructions to and all the levels access bits together).

		Linus

