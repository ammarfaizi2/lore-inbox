Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129267AbQK0RwF>; Mon, 27 Nov 2000 12:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129361AbQK0Rvz>; Mon, 27 Nov 2000 12:51:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17412 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129267AbQK0Rvg>; Mon, 27 Nov 2000 12:51:36 -0500
Date: Mon, 27 Nov 2000 18:21:13 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Werner.Almesberger@epfl.ch, adam@yggdrasil.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001127182113.A15029@athlon.random>
In-Reply-To: <200011270556.VAA12506@baldur.yggdrasil.com> <20001127094139.H599@almesberger.net> <200011270839.AAA28672@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011270839.AAA28672@pizda.ninka.net>; from davem@redhat.com on Mon, Nov 27, 2000 at 12:39:55AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 12:39:55AM -0800, David S. Miller wrote:
> Also I believe linkers are allowed to arbitrarily reorder members in
> the data and bss sections.  I could be wrong on this one though.

I'm not sure either, but we certainly rely on that behaviour somewhere.
Just to make an example fs/dquot.c:

	int nr_dquots, nr_free_dquots;

kernel/sysctl.c:

	{FS_NRDQUOT, "dquot-nr", &nr_dquots, 2*sizeof(int),

The above is ok also on mips in practice though.

In 2.2.x there was more of them.

Regardless if we're allowed to rely on the ordering the above is bad coding
practice because somebody could forget about the dependency on the ordering and
put something between nr_dquotes and nr_free_dquotes :), so such dependency
should be avoided anyways...

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
