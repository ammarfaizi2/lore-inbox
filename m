Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265981AbRF1O1g>; Thu, 28 Jun 2001 10:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265979AbRF1O1R>; Thu, 28 Jun 2001 10:27:17 -0400
Received: from [202.96.44.20] ([202.96.44.20]:9604 "HELO smtp.263.net")
	by vger.kernel.org with SMTP id <S265967AbRF1O1J>;
	Thu, 28 Jun 2001 10:27:09 -0400
Message-ID: <001201c0ffdd$989f35c0$0101a8c0@weqeqe>
Reply-To: "Zeng Yu" <yu_zeng@263.net>
From: "Zeng Yu" <yu_zeng@263.net>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <001e01c0ff14$0bdc7540$0101a8c0@weqeqe> <20010627165945.A16936@athlon.random>
Subject: Re: Ramdisk Bug?
Date: Thu, 28 Jun 2001 22:21:15 +0800
Organization: Capitel
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think find a ramdisk bug of 2.4.4 kernel -- ramdisk
> > use both buffers and cached mem of the same size, thus
> > double the mem use.
> > mke2fs -m0 /dev/ram1
> > mount /dev/ram1 /mnt
> > dd if=/dev/zero of=/mnt/data bs=1k count=110000
> > cat /proc/meminfo will see that both buffers and
> > cached mem increase about 110M of size. More worse,
> > the cached mem won't be released untile the ramdisk
> > be umounted. I attach the meminfo and slabinfo before
>
> the "more worse" part is the only thing which is wrong. The fact cache
> also grows to 110M is expected and it won't change. With the
> blkdev-pagecache patch the cache will grow to 220M and it will shrink to
> 110M if you are low on memory (buffer cache will only be allocated for
> the superblock and inode metadata with ext2).

broken, clean 2.4.4 kernel with blkdev-pagecache-1 and o_direct-5 patch
mke2fs /dev/ram0; mount /dev/ram0 /mnt
VFS:can't find an ext2 filesystem on dev ramdisk(1,0)
mount:wrong fs type, bad option, bad superblock on /dev/ram0 ...
I miss something?

BTW, I noticed that the blkdev-pagecache had been submitted early in 2.4.5
pre1,
but not included in 2.4.5 final, 2.4.5 still has the bug -- can't release
mem unless
the ramdisk unmounted. Would this be considered not a problem or just a
bearable
side-effect for some elegant designs?

> use ramfs if you want zero ram duplication and you don't care about the
> physical representation on disk of your data in cache.
 ramfs's src code inode.c says it not for general use, so not try and I
can't find any
docs about how to use it.

> Try this patch to fix the "more worst part"  (beware totally untested).
seems works. will do more tests though. thanks!

regard,

Zeng Yu

