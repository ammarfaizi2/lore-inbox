Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbUB2Osj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 09:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbUB2Osj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 09:48:39 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:36312 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262016AbUB2Osh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 09:48:37 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Worrisome IDE PIO transfers...
Date: Sun, 29 Feb 2004 15:55:49 +0100
User-Agent: KMail/1.5.3
Cc: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <4041232C.7030305@pobox.com> <200402290121.30498.bzolnier@elka.pw.edu.pl> <Pine.GSO.4.58.0402290943580.7483@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0402290943580.7483@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402291555.50036.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 of February 2004 09:50, Geert Uytterhoeven wrote:
> On Sun, 29 Feb 2004, Bartlomiej Zolnierkiewicz wrote:
> > [ Geert added to cc: ]
> >
> > On Sunday 29 of February 2004 00:24, Jeff Garzik wrote:
> > > Looking at the function that is used to transfer data when in PIO
> > > mode...
> > >
> > > void taskfile_output_data (ide_drive_t *drive, void *buffer, u32
> > > wcount) {
> > >          if (drive->bswap) {
> > >                  ata_bswap_data(buffer, wcount);
> > >                  HWIF(drive)->ata_output_data(drive, buffer, wcount);
> > >                  ata_bswap_data(buffer, wcount);
> > >          } else {
> > >                  HWIF(drive)->ata_output_data(drive, buffer, wcount);
> > >          }
> > > }
> > >
> > > Swapping the data in-place is very, very wrong...   you don't want to
> > > be touching the data that userspace might have mmap'd ... 
> > > Additionally, byteswapping back and forth for each PIO sector chews
> > > unnecessary CPU.
> >
> > This is used for accessing "normal" disks on beasts with byte-swapped IDE
> > bus (Atari/Q40/TiVo) and "byteswapped" disks on normal machines.
> >
> > [ Hm. actually I don't see how it can be used for accessing "normal"
> > disks, as data is byteswapped by IDE bus and then swapped back by IDE
> > driver. ]
>
> Why not? The only difference between `normal' and `byteswapped' disks is
> that the bytes in a 16-bit word are swapped (sic :-), so you can convert in
> both directions by swapping the bytes. Normal disks have been used on Atari
> before, so it should (still) work.

Oh yes, IDE driver fixes byteorder on Atari/Q40 only when "bswap" is used.

> BTW, the generic tree misses this patch, which was deemed inappropriate
> before, but is needed to make sure the drive identification block is
> correct on those machines:

Thanks.  I can't see a smarter way to fix this now. :/

Bartlomiej

