Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312414AbSEINsh>; Thu, 9 May 2002 09:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312491AbSEINsh>; Thu, 9 May 2002 09:48:37 -0400
Received: from hera.cwi.nl ([192.16.191.8]:10950 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312414AbSEINsf>;
	Thu, 9 May 2002 09:48:35 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 9 May 2002 15:48:32 +0200 (MEST)
Message-Id: <UTC200205091348.g49DmWe18144.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, dalecki@evision-ventures.com
Subject: Re: [PATCH] hdreg.h
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > People complain that fdisk doesn't compile under 2.5.14
    > because hdreg.h has acquired stuff that cannot be included
    > from userspace. Will release util-linux 2.11r later tonight
    > with a local copy.
    > But now that I look at this file: it still contains
    > struct hd_big_geometry and HDIO_GETGEO_BIG.
    > Please remove them.

    If fdisk doesn't use it. I will take your patch immediately.
    One arbitrary ioctl which was introduced ad hock less. :-).

No, fdisk, cfdisk, sfdisk do not use HDIO_GETGEO_BIG.
And indeed, the ioctl is completely meaningless.

I sent the patch both to you and to Linus because it also touches
sd.c and a few other places outside the ide driver.

There is also HDIO_GETGEO_BIG_RAW, which is not entirely useless -
it gives the physical geometry that is used for actual I/O,
as opposed to the logical geometry used for the partition table.
Probably it is used only in hdparm. Modern disks use LBA and
HDIO_GETGEO_BIG_RAW is meaningless for them. Old disks that use
CHS almost always have equal physical and logical geometry.
If you throw out HDIO_GETGEO_BIG_RAW but make sure there is
a line in dmesg reporting the geometry used for CHS I/O in case
that is different from the logical I/O (bios_CHS), I wouldn't
mind at all.

Andries
