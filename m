Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132274AbQLIV5C>; Sat, 9 Dec 2000 16:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132270AbQLIV4y>; Sat, 9 Dec 2000 16:56:54 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:23815 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132228AbQLIV4q>; Sat, 9 Dec 2000 16:56:46 -0500
Date: Sat, 9 Dec 2000 22:25:13 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alexander Viro <viro@math.psu.edu>
cc: Andries Brouwer <aeb@veritas.com>, Linus Torvalds <torvalds@transmeta.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@chiara.elte.hu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
In-Reply-To: <Pine.GSO.4.21.0012090804120.29053-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.3.96.1001209221321.19153A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2000, Alexander Viro wrote:

> On Sat, 9 Dec 2000, Andries Brouwer wrote:
> 
> > On Sat, Dec 09, 2000 at 05:40:47AM -0500, Alexander Viro wrote:
> > 
> > > > @@ -1210,7 +1204,6 @@
> > > [breada()]
> > > 	Umm... why do we keep it, in the first place? AFAICS the only
> > > in-tree user is hpfs_map_sector() and it doesn't look like we really
> > > need it there. OTOH, trimming the buffer.c down is definitely nice.
> > > Mikulas?
> > 
> > Throw it out. The number of users has diminished over time.
> > Recently isofs stopped using breada.
> > The hpfs use was broken, I fixed it a bit some time ago, but
> > there is nothing against throwing it out altogether, I think.
> 
> I've looked at the use of hpfs_map_sector() (and hpfs_map_4sectors() - sorry)
> and it looks like we would be better off doing getblk() on affected sectors
> and ll_rw_block() on the whole bunch - we end up calling breada() for
> increasing block numbers with decreasing readahead window anyway.
> 
> So it probably should go - it gives no real win. Mikulas has the final
> word here - he is the HPFS maintainer, so...

I did a test. I disabled readahead except for reading all 4 buffers in
map_4sectors.

I observed 14% slowdown on walking directories with find and 4% slowdown
on grepping one my working directory (10M, 281 files).

If you can't make it otherwise you can rip readahead out. If there is a
possibility to keep it, it would be better.

Mikulas


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
