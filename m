Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274337AbRIYBUf>; Mon, 24 Sep 2001 21:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274339AbRIYBUZ>; Mon, 24 Sep 2001 21:20:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65285 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274337AbRIYBUK>; Mon, 24 Sep 2001 21:20:10 -0400
Date: Mon, 24 Sep 2001 18:20:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 VM: what avoids from having lots of unwriteable inactive
 pages
In-Reply-To: <Pine.LNX.4.21.0109241934300.1207-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0109241817060.23252-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Sep 2001, Marcelo Tosatti wrote:
>
> We keep calling swap_out(), which will not deactivate pages which _can_ be
> written out, until we deactivate the pte's from the pages which are on the
> inactive list.

swap_out() will deactivate everything it finds to be not-recently used,
and that's how the inactive list ends up getting replenished.

But if you want to put an unconditional "refill_inactive()" after the
inactive shrink failed, just to work with the case of the active list
having a lot of interesting pages. That's not a mapped vs unmapped issue,
that's more a "maybe all the DMA pages are on the active list" kind of
thing.

		Linus

