Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316771AbSEUXJM>; Tue, 21 May 2002 19:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316772AbSEUXJL>; Tue, 21 May 2002 19:09:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13580 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316771AbSEUXJK>; Tue, 21 May 2002 19:09:10 -0400
Date: Tue, 21 May 2002 16:08:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: Dave McCracken <dmccr@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] POSIX personality
In-Reply-To: <p73d6vpxjzm.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.33.0205211603340.15094-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21 May 2002, Andi Kleen wrote:
> 
> One reason for it would be that it would be more efficient. All the various
> shared state needed for POSIX thread group emulation could be put into a 
> single structure with a single reference count.

Now, that's a separate issue - the issue of the exact _granularity_ of the 
bits, and how you group things together.

On that front, I don't have any strong feelings - but I suspect that it 
almost always ends up being fairly obvious when it is "right" to group 
things together, and when it isn't.

For example, we probably could have had just one bit for (FS | FILES), and 
the same is probably true of (SIGHAND | THREAD), but on the whole we 
haven't really had any gray areas when it comes to the grouping. And I 
don't see any coming up.

Does that mean that we might have a CLONE_POSIXDAMAGE that just covers all
the strange POSIX stuff that make no sense anywhere else? Maybe. But I'd
want that to be just another bit with the same semantic behaviour as the
existing ones, _not_ be some external "POSIX personality".

		Linus

