Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbRGHSZj>; Sun, 8 Jul 2001 14:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266956AbRGHSZa>; Sun, 8 Jul 2001 14:25:30 -0400
Received: from [62.172.234.2] ([62.172.234.2]:56464 "EHLO
	alloc.wat.veritas.com") by vger.kernel.org with ESMTP
	id <S266955AbRGHSZX>; Sun, 8 Jul 2001 14:25:23 -0400
Date: Sun, 8 Jul 2001 19:26:01 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
X-X-Sender: <markhe@alloc.wat.veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: MOLNAR Ingo <mingo@chiara.elte.hu>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] copy_from_high_bh
In-Reply-To: <Pine.LNX.4.33.0107081102410.7044-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0107081918350.9756-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001, Linus Torvalds wrote:
> On Sun, 8 Jul 2001 markhe@veritas.com wrote:
> >
> >   mm/highmem.c/copy_from_high_bh() blocks interrupts while copying "down"
> > to a bounce buffer, for writing.
> >   This function is only ever called from create_bounce() (which cannot
> > be called from an interrupt context - it may block), and the kmap
> > 'KM_BOUNCE_WRITE' is only used in copy_from_high_bh().
>
> If so it's not just the interrupt disable that is unnecessary, the
> "kmap_atomic()" should also be just a plain "kmap()", I think.

  That might eat through kmap()'s virtual window too quickly.

  I did think about adding a test to see if the page was already mapped,
and falling back to kmap_atomic() if it isn't.  That should give the best
of both worlds?

Mark

