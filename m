Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSGDTry>; Thu, 4 Jul 2002 15:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSGDTrx>; Thu, 4 Jul 2002 15:47:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:38353 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313558AbSGDTrw>; Thu, 4 Jul 2002 15:47:52 -0400
Date: Thu, 4 Jul 2002 21:50:17 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>, <hch@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] remove obsolete disk statistics header from /proc/partitions
Message-ID: <Pine.NEB.4.44.0207042036380.14934-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.579 removes the disk statistics in /proc/partitions.

But the header line is still present:

<--  snip  -->

# cat /proc/partitions
major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse
running use aveq

  22    64   20039544 hdd
  22    65   20039512 hdd1
   3     0   20010312 hda
   3     1    1028128 hda1
   3     2    1020127 hda2
   3     3          1 hda3
   3     5    3076416 hda5
   3     6    2867571 hda6
   3     7    1959898 hda7
   3     8   10056658 hda8
#

<--  snip   -->


I suggest the following patch to remove it:


--- drivers/block/genhd.c.old	Thu Jul  4 20:32:35 2002
+++ drivers/block/genhd.c	Thu Jul  4 20:33:26 2002
@@ -163,9 +163,7 @@
 	char buf[64];
 	int len, n;

-	len = sprintf(page, "major minor  #blocks  name     "
-			"rio rmerge rsect ruse wio wmerge "
-			"wsect wuse running use aveq\n\n");
+	len = sprintf(page, "major minor  #blocks  name\n\n");


 	read_lock(&gendisk_lock);


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


