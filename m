Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUB2UaI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 15:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbUB2UaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 15:30:08 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32401 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262132AbUB2UaD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 15:30:03 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Richard Zidlicky <rz@linux-m68k.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Worrisome IDE PIO transfers...
Date: Sun, 29 Feb 2004 21:36:33 +0100
User-Agent: KMail/1.5.3
Cc: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <4041232C.7030305@pobox.com> <Pine.GSO.4.58.0402290950590.7483@waterleaf.sonytel.be> <20040229192320.GA20299@linux-m68k.org>
In-Reply-To: <20040229192320.GA20299@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402292136.33589.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 of February 2004 20:23, Richard Zidlicky wrote:
> On Sun, Feb 29, 2004 at 09:52:08AM +0100, Geert Uytterhoeven wrote:
> > On Sun, 29 Feb 2004, Bartlomiej Zolnierkiewicz wrote:
> > > On Sunday 29 of February 2004 01:58, Jeff Garzik wrote:
> > > > > I like Alan's idea to use loopback instead of "bswap".
> > > >
> > > > Neat but no more zerocopy that way.  I much prefer a
> > > > swap-as-you-go...
> > >
> > > Okay, better solution:
> > >
> > > - on Atari/Q40:
> > >   if drive->bswap use insw/outsw instead of swapping variants
> >
> > Yep, that sounds the most logical. Richard?
>
> looks good.
>
> However it appears to fix only part of the problem -  we need some
> logic to ensure only disk data is swapped.
> Bswapping WIN_DOWNLOAD_MICROCODE data would not be very
> clever I guess.

Actually drive->bswap should die as I overlooked the fact that we are
_not_ swapping disk data (byteswapped data is used for FS) on Atari/Q40.

Therefore the real solution is to use device-mapper instead of drive->bswap
and on Atari/Q40 use standard insw/outs only if blk_fs_request(drive->rq),
for everything else insw_swapw/outsw_swapw should be used.

Does it make any sense? :)

Bartlomiej

