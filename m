Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316165AbSEOAFq>; Tue, 14 May 2002 20:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316166AbSEOAFp>; Tue, 14 May 2002 20:05:45 -0400
Received: from pensacola.gci.com ([205.140.80.79]:51466 "EHLO
	pensacola.gci.com") by vger.kernel.org with ESMTP
	id <S316165AbSEOAFo>; Tue, 14 May 2002 20:05:44 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA315082E17EE@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16+devfs+ide+scsi = Disaster! (data recovery tips requested)
Date: Tue, 14 May 2002 16:05:37 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I now join the ranks of the "Damn, I should have double-checked my
backups to make sure they were readable."

Booted into Linux last night to format a new IDE drive for a laptop.
My thought was to clone the existing (SCSI) windows partition for my
wife's laptop.  Then I could wipe the old partition after saving off
my data and have one more dedicated linux box laying around.

Everything looked okay when I fdisk'd the drive and the formatted
it with mkfs.vfat

That is, until I went to reboot.

Apparantly, there's a weird bug/race/conflict between devfs, scsi, and ide.

My CD/RW was on the IDE cable, which I had simply swapped out with the
mini-HD.

after the realization of what must have happend, i dug a little deeper.
fortunately lilo hadn't been wiped, and I did have linux on a second (scsi)
drive,
so I double-checked what devices it thought everthing was.

/dev/hda = block-device 8
/dev/sda = block-device 8

umm... this is bad !!

the scsi-ide module was loaded (because of the CD/RW) and it seems that
the combination of a hard-drive + scsi-ide and devfs just layed over the
top of the existing config.

My kernel is 2.4.16.  I can provide more information later, if requested.

So now I have a windows disk that has been formatted over with mkfs.vfat.

I tried norton's unformat, but that was unable to do much work (just
filled the root directory with things that looked like directories until
eventually the root dir was filled)

So, the long shot is that I've got to do some serious work if I want
to try to recover any data off of this drive.  And hopefully, this will
serve to warn people about serious data loss when mixing ide and scsi
without
verifying your entire configuration before embarking on destructive changes.

That said, Does anybody have any tips for data recovery off of a vfat
partition
from linux?

<sob>

Leif
(vowing to make sure that the next backup works, and to double-check
device numbers before fdisk/format anything!)

