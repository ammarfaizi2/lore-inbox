Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154500AbPHYPBJ>; Wed, 25 Aug 1999 11:01:09 -0400
Received: by vger.rutgers.edu id <S154370AbPHYO6b>; Wed, 25 Aug 1999 10:58:31 -0400
Received: from [216.70.176.28] ([216.70.176.28]:1529 "EHLO rsts-11.mit.edu") by vger.rutgers.edu with ESMTP id <S154534AbPHYO4f>; Wed, 25 Aug 1999 10:56:35 -0400
Date: Wed, 25 Aug 1999 10:54:13 -0400
Message-Id: <199908251454.KAA01398@rsts-11.mit.edu>
To: osman@Cable.EU.org
CC: linux-kernel@vger.rutgers.edu
In-reply-to: <Pine.LNX.4.10.9908240528280.2367-100000@fw.Cable.EU.org> (message from Osman on Tue, 24 Aug 1999 05:38:25 +0200 (CEST))
Subject: Re: Question: finding boundaries of ext2fs-partitions.
From: tytso@mit.edu
Address: 1 Amherst St., Cambridge, MA 02139
Phone: (617) 253-8091
References: <Pine.LNX.4.10.9908240528280.2367-100000@fw.Cable.EU.org>
Sender: owner-linux-kernel@vger.rutgers.edu

   Date:   Tue, 24 Aug 1999 05:38:25 +0200 (CEST)
   From: Osman <osman@Cable.EU.org>

   I heard from an other list that there was a discussion here a few weeks
   ago or some, about this topic.
   I need a prg wich will help me in rebuilding/recreating my partition
   table.
   The data is still there, only the table was lost due to a mistake I made
   while installing RH6.0.

The following list of tools that will allow you to rebuild partition
tables was written up by Andries Brouwer (Andries.Brouwer@cwi.nl) a few
months ago, and as far as I know it's still an accurate description of
the various choices you have out there for this task.  

In my personal opinion, gpart is probably the best of the bunch at this
point, although all of the programs are relatively new and aren't
foolproof.  In particular, nearly all of them can be confused by
previous filesystems whose superblocks are still present on the disk.
(In the future, programs could be made smarter by looking at the mount
times to see which filesystem is more recent if there are two
overlapping filesystems.  As far as I know none of the programs do this
kind of hueristics for you, so manual human judgement will be required.)

Anyway, here's Anderies's list:

   (i) findsuper is a small utility that finds blocks with the ext2
   superblock signature, and prints out location and some info.
   It is in the non-installed part of the e2progs distribution.

   (ii) rescuept is a utility that recognizes ext2 superblocks,
   FAT partitions, swap partitions, and extended partition tables;
   it prints out information that can be used with fdisk or sfdisk
   to reconstruct the partition table.
   It is in the non-installed part of the util-linux distribution.

   (iii) fixdisktable (http://bmrc.berkeley.edu/people/chaffee/fat32.html)
   is a utility that handles ext2, FAT, NTFS, ufs, BSD disklabels
   (but not yet v1 Linux swap partitions); it actually will rewrite
   the partition table, if you give it permission.

   (iv) gpart (http://home.pages.de/~michab/gpart/) is a utility
   that handles ext2, FAT, Linux swap, HPFS, NTFS, FreeBSD and
   Solaris/x86 disklabels, minix, reiser fs; it prints a proposed
   contents for the primary partition table, and is well-documented.

Hope this helps!

						 - Ted


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
