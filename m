Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSHMIi2>; Tue, 13 Aug 2002 04:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSHMIi1>; Tue, 13 Aug 2002 04:38:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3570 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313628AbSHMIi0>; Tue, 13 Aug 2002 04:38:26 -0400
Date: Tue, 13 Aug 2002 10:42:13 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: John Kim <john@larvalstage.com>
cc: linux-kernel@vger.kernel.org, <drew@colorado.edu>
Subject: Re: devfs compile breaks on 2.4.20-pre2
In-Reply-To: <Pine.LNX.4.44.0208130011120.1762-100000@daria.larvalstage.com>
Message-ID: <Pine.NEB.4.44.0208131041160.14606-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, John Kim wrote:

> has been modified from 2.4.20-pre1.  I see that 'number' member has been
> removed from hd_struct in include/linux/genhd.h.
>
> Functions devfs_register_disc and devfs_register_partitions in
> fs/partitions/check.c is still expecting "number" it to be there.
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

> John Kim

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

