Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130343AbQLINmH>; Sat, 9 Dec 2000 08:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130773AbQLINl6>; Sat, 9 Dec 2000 08:41:58 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:52904 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130343AbQLINlm>;
	Sat, 9 Dec 2000 08:41:42 -0500
Date: Sat, 9 Dec 2000 08:11:15 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries Brouwer <aeb@veritas.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@chiara.elte.hu>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
In-Reply-To: <20001209135659.B839@veritas.com>
Message-ID: <Pine.GSO.4.21.0012090804120.29053-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Andries Brouwer wrote:

> On Sat, Dec 09, 2000 at 05:40:47AM -0500, Alexander Viro wrote:
> 
> > > @@ -1210,7 +1204,6 @@
> > [breada()]
> > 	Umm... why do we keep it, in the first place? AFAICS the only
> > in-tree user is hpfs_map_sector() and it doesn't look like we really
> > need it there. OTOH, trimming the buffer.c down is definitely nice.
> > Mikulas?
> 
> Throw it out. The number of users has diminished over time.
> Recently isofs stopped using breada.
> The hpfs use was broken, I fixed it a bit some time ago, but
> there is nothing against throwing it out altogether, I think.

I've looked at the use of hpfs_map_sector() (and hpfs_map_4sectors() - sorry)
and it looks like we would be better off doing getblk() on affected sectors
and ll_rw_block() on the whole bunch - we end up calling breada() for
increasing block numbers with decreasing readahead window anyway.

So it probably should go - it gives no real win. Mikulas has the final
word here - he is the HPFS maintainer, so...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
