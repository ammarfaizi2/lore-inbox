Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135676AbREGXYE>; Mon, 7 May 2001 19:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135251AbREGXXz>; Mon, 7 May 2001 19:23:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:56327 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135676AbREGXXs>; Mon, 7 May 2001 19:23:48 -0400
Date: Mon, 7 May 2001 16:23:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105071820460.7506-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0105071621220.1475-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 May 2001, Marcelo Tosatti wrote:
> 
> On 7 May 2001, Linus Torvalds wrote:
> 
> > But it is important to re-calculate the deadness after getting the
> > lock. Before, it was just an informed guess. After the lock, it is
> > knowledge. And you can use informed guesses for heuristics, but you
> > must _not_ use them for any serious decisions.
> 
> And thats what swap_writepage() is doing:

Ehh.. swap_writepage() is called with the page locked. So it _can_ depend
on it.

If the page isn't locked there, then THAT is a bug. A major one.

		Linus

