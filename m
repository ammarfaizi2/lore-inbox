Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268045AbRGVTJ4>; Sun, 22 Jul 2001 15:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268044AbRGVTJr>; Sun, 22 Jul 2001 15:09:47 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:65288 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268041AbRGVTJh>; Sun, 22 Jul 2001 15:09:37 -0400
Date: Sun, 22 Jul 2001 12:08:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@twiddle.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Why Plan 9 C compilers don't have asm("")
In-Reply-To: <20010722085330.A7735@twiddle.net>
Message-ID: <Pine.LNX.4.33.0107221159400.12342-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Sun, 22 Jul 2001, Richard Henderson wrote:
>
> Hmm.  Yes, that could work.  We'd still be changing the ABI, since
> the original source "bsr foo" would really mean "bsr foo+skip ldgp".
> But perhaps one that wouldn't matter for all practical purposes.

Ahh.. Well, that would be more of a linker relocation ABI change, not
really a run-time ABI change. And as it needs a new relocation type
anyway, because of the overflow case (I assume the current .rel20
complains loudly when it overflows, right?), this should be ok.

And the code to jump over ldgp obviously exists already if there's a
"-relax" linker option.

		Linus

