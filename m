Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbRCTJFj>; Tue, 20 Mar 2001 04:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRCTJF3>; Tue, 20 Mar 2001 04:05:29 -0500
Received: from mail.sonytel.be ([193.74.243.200]:44535 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S129259AbRCTJFU>;
	Tue, 20 Mar 2001 04:05:20 -0500
Date: Tue, 20 Mar 2001 10:03:37 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: st corruption with 2.4.3-pre4
In-Reply-To: <3AB63F5F.B7C3E71A@mandrakesoft.com>
Message-ID: <Pine.GSO.4.10.10103200858110.4932-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2001, Jeff Garzik wrote:
> Is the corruption reproducible?  If so, does the corruption go away if

Yes, it is reproducible. In all my tests, I tarred 16 files of 16 MB each to
tape (I used a new one).
  - test 1: 4 files with failed md5sum (no further investigation on type of
	    corruption)
  - test 2: 7 files with failed md5sum, 7 blocks of 32 consecutive bytes were
	    corrupted, all starting at an offset of the form 32*x+1.
  - test 3: 7 files with failed md5sum, 7 blocks of 32 consecutive bytes were
	    corrupted, all starting at an offset of the form 32*x+1.

The files seem to be corrupted during writing only, as reading always gives the
exact same (corrupted) data back.

Copying files from the disk on the MESH to a disk on the Sym53c875 (which also
has the tape drive) shows no corruption.

> you rip out the scsi_error patch in 2.4.3-preXX?

After reverting that patch, the problem got worse:
  - test 4: 15 files with failed md5sum, a total of 40 blocks of 32 consecutive
	    bytes were corrupted, all starting at an offset of the form 32*x+1.

So it seems to be related to scsi_error.c.

If you have some suggestions, I'm willing to try them. I'd like to trust
whatever Amanda writes to my backup tapes :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

