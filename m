Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSEVU6Z>; Wed, 22 May 2002 16:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313128AbSEVU6Y>; Wed, 22 May 2002 16:58:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24837 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313070AbSEVU6X>; Wed, 22 May 2002 16:58:23 -0400
Date: Wed, 22 May 2002 13:58:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Have the 2.4 kernel memory management problems on large machines
  been fixed?
In-Reply-To: <p73sn4kaq3u.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.33.0205221352300.1531-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 May 2002, Andi Kleen wrote:
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > 	bigpage = alloc_bigpage_from_magic_zone();
> 
> How should magic zone be handled? Do you propose to just size it with
> __setup() and not put anything smaller than 4MB pages into it ?
> Otherwise fragmentation will likely kill it quickly.

I'd just suggest a __setup() for it initially, let's see how it gets used.

There are certainly other options down the road, and I think that's one 
reason you want to keep a very spartan interface and to make it not expose 
any big details _except_ for the actual hw limitations.

> Do you think something like that would be worth it or do you prefer
> the really dumb version that just never tries to use the pages in 
> magic dumb zone for anything else?

I'd really go for the dumb approach first, see what the Oracle users
think, and make sure that the _administration_ of the memory is totally
separate from the use of it (ie don't allow the oracle binary to do any 
setup, start the setup with a kernel boot line, and down the line see if 
you can add some more dynamic "try to free 8MB of contiguous RAM and add 
it to the magic zone" things that would be run externally from Oracle).

And let's not _just_ blame oracle, maybe other uses can actually be found
for this (eg XFree86 for UMA graphics cards etc might actually want to use
something like this eventually).

		Linus

