Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130664AbRARBXu>; Wed, 17 Jan 2001 20:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131026AbRARBXl>; Wed, 17 Jan 2001 20:23:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46097 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130664AbRARBXV>; Wed, 17 Jan 2001 20:23:21 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Subtle MM bug
Date: 17 Jan 2001 17:23:05 -0800
Organization: Transmeta Corporation
Message-ID: <945ghp$att$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <Pine.LNX.4.31.0101180126240.31432-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.31.0101180126240.31432-100000@localhost.localdomain>,
Rik van Riel  <riel@conectiva.com.br> wrote:
>On Wed, 10 Jan 2001, Linus Torvalds wrote:
>
>> I looked at it a year or two ago myself, and came to the
>> conclusion that I don't want to blow up our page table size by a
>> factor of three or more, so I'm not personally interested any
>> more. Maybe somebody else comes up with a better way to do it,
>> or with a really compelling reason to.
>
>OTOH, it _would_ get rid of all the balancing issues in one
>blow. And it would fix the aliasing issues and possibly the
>memory fragmentation problem too.

I totally disagree.

It might help fragmentation, but it has absolutely _no_ impact on
balancing. See my comments about not seeing the "accessed" bit until way
too late with a "find by physical" approach.

You simply _cannot_ use "find by physical" for balancing, unless you're
willing to pay the price of doing software accessed bits even on
hardware that does it for you in the page tables.  Which is a price MUCH
too high to pay, I suspect. 

The current vmscanning is the way to go.  Getting PageDirty was a big
step for it, because it is needed so that we can drop pages without
having to do IO like we historically did.  I doubt find-by-physical will
help AT ALL wrt balancing. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
