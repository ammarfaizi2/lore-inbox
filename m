Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSFXUZA>; Mon, 24 Jun 2002 16:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSFXUY7>; Mon, 24 Jun 2002 16:24:59 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:56822 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315245AbSFXUY6>; Mon, 24 Jun 2002 16:24:58 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 24 Jun 2002 14:23:19 -0600
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when a laptop is powered by a battery?
Message-ID: <20020624202319.GS22411@clusterfs.com>
Mail-Followup-To: Miles Lane <miles@megapathdsl.net>,
	LKML <linux-kernel@vger.kernel.org>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1024948946.30229.19.camel@turbulence.megapathdsl.net>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 24, 2002  13:02 -0700, Miles Lane wrote:
> 1)  Add support to the boot/mounting process 
>     so that, if a machine is being powered by
>     battery, EXT3 partitions are mounted with
>     EXT2, instead?

Impossible right now.  While the on-disk format is the same, the
ext2 and ext3 drivers are totally different.

It's like asking if you can switch between IDE and SCSI drivers
automatically for a disk when you go on battery.
 
That said, it would be possible to update the ext3 code to allow it
to mount a filesystem without a journal by updating the journal
wrappers in include/linux/ext3_jbd.h.

Even so, the reasoning you give is a bad one - you are far safer
with ext3 on your laptop when it is running out of batteries,
because you are likely to run out of battery without unmounting
the filesystem cleanly, and that's just when you want ext3.

You should just change the flush parameters to be longer, or
figure out exactly why ext3 is writing stuff to disk when there
is no real I/O happening.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

