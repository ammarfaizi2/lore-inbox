Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281824AbRKQUrt>; Sat, 17 Nov 2001 15:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281825AbRKQUrj>; Sat, 17 Nov 2001 15:47:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47118 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281824AbRKQUrV>; Sat, 17 Nov 2001 15:47:21 -0500
Date: Sat, 17 Nov 2001 12:42:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jan Hubicka <jh@suse.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: i386 flags register clober in inline assembly
In-Reply-To: <20011117214041.D3789@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0111171238150.1731-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Nov 2001, Jan Hubicka wrote:
>
> Actually the main dificulty I see is storing cc0 to variable.  CC0 is hard
> register and pretty strange one - you can't move it, you can't spill.

Well, you _can_ spill it, but you need to use "pushfl/popfl" to
spill/restore.

Also, if you're clever you don't spill cc0 itself, but the _comparison_,
ie if you need to spill in

	asm(.. "=cc" (cc0))
	if (cc0 > 0)

a sufficiently clever spill-engine would spill not eflags,  but instead
spill "cc0 > 0", which it can do with the "seq" expansions..

gcc already does know about "store-flag" instructions, although I
certainly agree that the _patterns_ of usage may end up being very
different than existing conditional comparisons..

		Linus

