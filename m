Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317581AbSFIJAq>; Sun, 9 Jun 2002 05:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSFIJAp>; Sun, 9 Jun 2002 05:00:45 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:46862 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317581AbSFIJAo>; Sun, 9 Jun 2002 05:00:44 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <200206090603.g5963FA458690@saturn.cs.uml.edu>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 09 Jun 2002 18:00:30 +0900
Message-ID: <871ybgddxt.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> Use the packed attribute on the struct, along with
> the right types. I don't think you need get_unaligned
> with a packed struct, because gcc will know that it
> needs to emit code for unaligned data.
> 
> At the very least you can get rid of the cast.
> 
> Before:
> logical_sector_size = le16_to_cpu(get_unaligned((u16*)&b->sector_size));
> 
> After:
> logical_sector_size = le16_to_cpu(b->sector_size);
> 
> The new struct:
> 
> /* Note the end: __attribute__ ((packed)) */
> struct fat_boot_sector {
>         char    ignored[3];     /* Boot strap short or near jump */
>         __u64   system_id;      /* Name - can be used to special case
>                                    partition manager volumes */
>         __u16   sector_size;    /* bytes per logical sector */
>         __u8    cluster_size;   /* sectors/cluster */
>         __u16   reserved;       /* reserved sectors */
>         __u8    fats;           /* number of FATs */
>         __u16   dir_entries;    /* root directory entries */
>         __u16   sectors;        /* number of sectors */
>         __u8    media;          /* media code */
>         __u16   fat_length;     /* sectors/FAT */
>         __u16   secs_track;     /* sectors per track */
>         __u16   heads;          /* number of heads */
>         __u32   hidden;         /* hidden sectors (unused) */
>         __u32   total_sect;     /* number of sectors (if sectors == 0) */
> 
>         /* The following fields are only used by FAT32 */
>         __u32   fat32_length;   /* sectors/FAT */
>         __u16   flags;          /* bit 8: fat mirroring, low 4: active fat */
>         __u16   version;        /* major, minor filesystem version */
>         __u32   root_cluster;   /* first cluster in root directory */
>         __u16   info_sector;    /* filesystem info sector */
>         __u16   backup_boot;    /* backup boot sector */
>         __u16   reserved2[6];   /* Unused */
> } __attribute__ ((packed)) ;

BTW, is this safe on other of i386 (ex. mips etc.)? I'm not sure.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
