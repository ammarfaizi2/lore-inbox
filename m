Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274774AbRKHQMc>; Thu, 8 Nov 2001 11:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274813AbRKHQMW>; Thu, 8 Nov 2001 11:12:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59146 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274774AbRKHQML>; Thu, 8 Nov 2001 11:12:11 -0500
Date: Thu, 8 Nov 2001 08:08:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: out_of_memory() heuristic broken for different mem configurations
 (fwd)
In-Reply-To: <Pine.LNX.4.21.0111081239270.1689-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0111080805280.1480-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Nov 2001, Marcelo Tosatti wrote:
>
> I guess you forgot to apply the following patch on 2.4.15-pre1, right ?

The thing is, I _really_ think it is broken.

The way to make it fail is to have many large SHARED mappings - in which
case we have backing space for 99% of all memory, and returning -1 just
because a few pages need swap-space and can't be thrown out is wrong.

Try it with no swap, and having some processes that MAP_SHARED much more
than available memory and many (small) processes that do not, and need
swap-space. It should work fine - we're never even _close_ to being out of
memory, but your change makes "swap_out()" fail all the time.

		Linus

