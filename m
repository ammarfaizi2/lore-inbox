Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130065AbRCTTbD>; Tue, 20 Mar 2001 14:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130660AbRCTTax>; Tue, 20 Mar 2001 14:30:53 -0500
Received: from aeon.tvd.be ([195.162.196.20]:13216 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S130065AbRCTTai>;
	Tue, 20 Mar 2001 14:30:38 -0500
Date: Tue, 20 Mar 2001 20:29:37 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: st corruption with 2.4.3-pre4
In-Reply-To: <Pine.GSO.4.10.10103200858110.4932-100000@escobaria.sonytel.be>
Message-ID: <Pine.LNX.4.05.10103202024310.4053-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Geert Uytterhoeven wrote:
> On Mon, 19 Mar 2001, Jeff Garzik wrote:
> > Is the corruption reproducible?  If so, does the corruption go away if
> 
> Yes, it is reproducible. In all my tests, I tarred 16 files of 16 MB each to
> tape (I used a new one).
>   - test 1: 4 files with failed md5sum (no further investigation on type of
> 	    corruption)
>   - test 2: 7 files with failed md5sum, 7 blocks of 32 consecutive bytes were
> 	    corrupted, all starting at an offset of the form 32*x+1.
>   - test 3: 7 files with failed md5sum, 7 blocks of 32 consecutive bytes were
> 	    corrupted, all starting at an offset of the form 32*x+1.
> 
> The files seem to be corrupted during writing only, as reading always gives the
> exact same (corrupted) data back.
> 
> Copying files from the disk on the MESH to a disk on the Sym53c875 (which also
> has the tape drive) shows no corruption.

I did some more tests:
  - The problem also occurs when tarring up files from a disk on the Sym53c875.
  - The corrupted data always occurs at offset 32*x (the `+1' above was caused
    by hexdump, starting counting at 1).
  - The 32 bytes of corrupted data at offset 32*x are always a copy of the data
    at offset 32*x-10240.
  - Since 10240 is the default blocksize of tar (bug in tar?), I made a tarball
    on disk instead of on tape, but no corruption.
  - 32 is the size of a cacheline on PPC. Is there a missing cacheflush
    somewhere in the Sym53c875 driver? But then it should happen on disk as
    well?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

