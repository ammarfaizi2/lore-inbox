Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSHMIYG>; Tue, 13 Aug 2002 04:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSHMIYG>; Tue, 13 Aug 2002 04:24:06 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16882 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312560AbSHMIYF>; Tue, 13 Aug 2002 04:24:05 -0400
Date: Tue, 13 Aug 2002 10:27:52 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Ivan Gyurdiev <ivangurdiev@attbi.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre2
In-Reply-To: <200208120158.19207.ivangurdiev@attbi.com>
Message-ID: <Pine.NEB.4.44.0208131026390.14606-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Ivan Gyurdiev wrote:

> make[3]: Entering directory `/usr/src/linux-2.4.20-pre2/fs/partitions'
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-pre2/include -Wall
> -Wstrict-prototypes                                -Wno-trigraphs -O2
> -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -
> mpreferred-stack-boundary=2 -march=athlon    -nostdinc -I
> /usr/lib/gcc-lib/athlon-redhat-linux/3.2/include
> -DKBUILD_BASENAME=check  -DEXPORT_SYMTAB -c check.c
> check.c: In function `devfs_register_disc':
> check.c:328: structure has no member named `number'
> check.c:329: structure has no member named `number'
> check.c: In function `devfs_register_partitions':
> check.c:361: structure has no member named `number'
>...


The following patch made by Christoph Hellwig fixes it:


--- linux-2.4.20-bk-20020810/include/linux/genhd.h	Sat Aug 10 14:37:16 2002
+++ linux/include/linux/genhd.h	Mon Aug 12 23:40:37 2002
@@ -62,7 +62,9 @@ struct hd_struct {
 	unsigned long start_sect;
 	unsigned long nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
-
+#ifdef CONFIG_DEVFS_FS
+	int number;
+#endif /* CONFIG_DEVFS_FS */
 #ifdef CONFIG_BLK_STATS
 	/* Performance stats: */
 	unsigned int ios_in_flight;


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


