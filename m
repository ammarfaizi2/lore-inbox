Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315002AbSDWBF6>; Mon, 22 Apr 2002 21:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315004AbSDWBF5>; Mon, 22 Apr 2002 21:05:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:65182 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315002AbSDWBF5>;
	Mon, 22 Apr 2002 21:05:57 -0400
Date: Mon, 22 Apr 2002 21:05:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] race in request_module()
In-Reply-To: <20020422175858.C24927@one-eyed-alien.net>
Message-ID: <Pine.GSO.4.21.0204222101370.5686-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Apr 2002, Matthew Dharm wrote:

> Isn't the real problem here that we've got a "rogue" running around
> removing things that we might be about to use?
> 
> Yes, I think that request_module() should indicate to the caller if
> something "suitable" was found.  But I think having rmmod -a running around
> sweeping things randomly is bad.
> 
> Perhaps what we need is a way to tell _how_long_ago_ the count on a module
> last changed.  Thus, rmmod -a could decide to only remove modules that were
> last used more than an hour ago, or somesuch.  Push the policy question into
> userspace.

Still doesn't solve the problem.  And BTW, there are userland races of
similar kind - foo.o depends on bar.o, modprobe loads bar.o, goes to look
for foo.o and gets bar.o removed from under it.

The thing being, relying on time doesn't help - e.g. we might have modules
on automounted volume and delays may be really long if the thing happens
at time when load is high.

