Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319359AbSHQFEG>; Sat, 17 Aug 2002 01:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319360AbSHQFEG>; Sat, 17 Aug 2002 01:04:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:62737 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S319359AbSHQFEF>; Sat, 17 Aug 2002 01:04:05 -0400
Date: Sat, 17 Aug 2002 01:18:17 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Skidley <skidley@roadrunner.nf.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre3
In-Reply-To: <20020817045924.GC377@hendrix>
Message-ID: <Pine.LNX.4.44.0208170117360.8089-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Aug 2002, Skidley wrote:

> check.c: In function `devfs_register_disc':
> check.c:328: structure has no member named `number'
> check.c:329: structure has no member named `number'
> check.c: In function `devfs_register_partitions':
> check.c:361: structure has no member named `number'
> make[3]: *** [check.o] Error 1
> make[3]: Leaving directory
> `/home/skidley/kernel/linux-2.4.20-pre3/fs/partitions'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory
> `/home/skidley/kernel/linux-2.4.20-pre3/fs/partitions'
> make[1]: *** [_subdir_partitions] Error 2
> make[1]: Leaving directory `/home/skidley/kernel/linux-2.4.20-pre3/fs'
> make: *** [_dir_fs] Error 2

Yeah, I forgot to apply the fix to this one, sorry.

Here it is:

Subject: [PATCH] fix current BK tree compilation with devfs enabled


Not that I care for devfs, but there was at least one report on lkml.

I tried to also put the devfs_handle_t under CONFIG_DEVFS_FS, but the
devfs wrappers require it.  And yes, I'm seriously pissed that devfs
puts wordsize objects everywhere even if not enabled.


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

