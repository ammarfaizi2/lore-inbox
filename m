Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbSA2WDN>; Tue, 29 Jan 2002 17:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbSA2WDD>; Tue, 29 Jan 2002 17:03:03 -0500
Received: from waste.org ([209.173.204.2]:39387 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S280588AbSA2WCv>;
	Tue, 29 Jan 2002 17:02:51 -0500
Date: Tue, 29 Jan 2002 16:02:25 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33.0201291326340.1334-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0201291553150.25443-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Linus Torvalds wrote:

>
> On Tue, 29 Jan 2002, Oliver Xymoron wrote:
> >
> > I don't think read-only for the tables is sufficient if the pages
> > themselves are writable.
>
> At least on x86, the WRITE bit in the page directory entries will override
> any bits int he PTE. In other words, it doesn't make the page directory
> entries thmselves unwritable - it makes the final pages unwritable.
>
> Which are exactly the semantics we want.

Oh. Cool. I knew I must have been missing some detail.

> I have this strong feeling (but am lazy enough to not try to find the
> documentation) that on alpha the access bits in the upper page tables are
> just ignored (ie you have to actually turn off the present bit), which is
> a bit sad as it shouldn't matter from a PAL-code standpoint (just two more
> "and" instructions to and all the levels access bits together).

The "detached mm" approach should be sufficiently parallel to the
read-only page directory entries that the two can use almost the same
framework. The downside is faults on reads in the detached case, but that
shouldn't be significantly worse than the original copy, thanks to the
large fanout.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

