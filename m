Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270261AbRH1FUE>; Tue, 28 Aug 2001 01:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270258AbRH1FTy>; Tue, 28 Aug 2001 01:19:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32671 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270253AbRH1FTp>;
	Tue, 28 Aug 2001 01:19:45 -0400
Date: Tue, 28 Aug 2001 01:20:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <9mf8ft$7pt$1@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0108280107180.1663-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Aug 2001, Linus Torvalds wrote:

> It was not davem who added the type argument.  It was me who _required_
> that min/max be very much explicitly type-aware, as I consider any other
> alternative to be inherently buggy. 

Sure. Any attempt to keep the old min/max and make them automagically
do the right thing is doomed since there is no _single_ right thing
we want from them and choice should be deliberate and explicit. No
arguments here.

> generating correct code.  And that's to a large degree because they
> force the user to specify what type he _thinks_ the comparison should be
> done in. 

<nod>

> The problem with putting the "type" in the name of the function/macro
> is/was that
> 
>  - there's a _lot_ of types. David actually had a version for this, and
>    there were separate versions for everything ranging from "int" to
>    "uint", to "s32" to "u32", to "size_t" etc etc.

Ugh. I have a serious feeling that most of them would be redundant, but...
OK, I guess that somebody might want "unsigned max of x and y % 256" (x
being unsigned char and y - unsigned long).  Yes, with stuff like that
we'd really need a function for every type, but I would be very surprised
if somebody actually needed that (and I'd rather see it written explicitly,
regardless of the mechanism we use).

>  - Some people would _still_ not understand what the advantage of
>    explicit typing would be, so we'd have drivers doing their own
>    min/max functions, not understanding the issues about signs and C
>    type conversion. 

Well, that's what grep is for.  Bet that we'll see MAX, __max, m4x and
all sorts of similar "workarounds", so grep'n'LART will be needed anyway.

