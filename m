Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316236AbSEVQKb>; Wed, 22 May 2002 12:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316227AbSEVQJc>; Wed, 22 May 2002 12:09:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9744 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316226AbSEVQIk>; Wed, 22 May 2002 12:08:40 -0400
Date: Wed, 22 May 2002 09:08:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.21.0205221523450.23394-100000@serv>
Message-ID: <Pine.LNX.4.44.0205220904520.7580-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Roman Zippel wrote:
>
> We already don't let the general vm touch the pgd entries for the same
> reason, so I don't think that's really a big problem.
> Using the present bit has another consequence. unmap() had to be done in
> two phases:

I don't disagree. Are you interested in trying to write it up? It sounds
like a potentially good idea, with few downsides (but I can imagine some:
it does bad things to threads that just happen to share the same 4M area
for other stuff, and that start getting spurious page faults on another
CPU because _their_ area temporarily went away from under them).

I also suspect that it might simplify the TLB shootdown enough that we
wouldn't _have_ to split out the exit case and could use the shared
zapping. But I'm kind of worried about the potential threading issues.

(Rule of thumb: it's always a bad idea to cut down on parallelism, and
we'll _really_ be up shit creek if some threaded app comes along later
where munmap() ends up serializing threads too much).

			Linus

