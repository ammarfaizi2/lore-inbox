Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274265AbRIYACv>; Mon, 24 Sep 2001 20:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274263AbRIYACm>; Mon, 24 Sep 2001 20:02:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2568 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S274258AbRIYACg>; Mon, 24 Sep 2001 20:02:36 -0400
Date: Mon, 24 Sep 2001 19:39:38 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 VM: what avoids from having lots of unwriteable inactive
 pages
In-Reply-To: <Pine.LNX.4.33.0109241653460.21624-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0109241934300.1207-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Sep 2001, Linus Torvalds wrote:

> 
> On Mon, 24 Sep 2001, Marcelo Tosatti wrote:
> >
> > What avoids us from having a lot of unfreeable (eg mapped by ptes) pages
> > on the inactive list ?
> 
> Nothing.
> 
> If we can't shrink them, we'll fall out and do vmscanning.
> 
> Which is exactly what we want to do - it automatically acts as a "uhhuh,
> we've got to do something now" thing.

Think about a case where the inactive list if _full_ of mapped pages.
(which can easily happen, because one fault (do_swap_page) will _not_ move
the page to the active list directly --- it has to be accessed (Referenced
bit) twice (mark_page_accessed)).

We _think_ we don't have a shortage, so we won't call refill_inactive().

We keep calling swap_out(), which will not deactivate pages which _can_ be
written out, until we deactivate the pte's from the pages which are on the
inactive list.

Nothing prevents that, right ? 

