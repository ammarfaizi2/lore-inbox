Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSFRRID>; Tue, 18 Jun 2002 13:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSFRRIC>; Tue, 18 Jun 2002 13:08:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6922 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317498AbSFRRIC>; Tue, 18 Jun 2002 13:08:02 -0400
Date: Tue, 18 Jun 2002 10:08:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/19] stack space reduction (remove MAX_BUF_PER_PAGE)
In-Reply-To: <3D0DAD69.5C667D63@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206181006200.2347-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Jun 2002, Andrew Morton wrote:
> Andrew Morton wrote:
> >
> > ..
> > +               do {
> > +                       if (buffer_async_read(bh))
> > +                               submit_bh(READ, bh);
> > +               } while ((bh = bh->b_this_page) != head);
>
> That's a bug.

I'm just not going to apply this patch.

Right now MAX_BUFFERS_PER_PAGE is 8 or 16, and the array of buffer heads
is thus 32 bytes on an x86. I'd much rather get a nice tight loop without
callbacks in the middle, and then submit 8 pre-approved buffers in one go,
than have issues like this.

If we have 64kB pages, such architectures will have to have a bigger
kernel stack. Which they will have, simply by virtue of having the very
same bigger page. So that problem kind of solves itself.

		Linus

