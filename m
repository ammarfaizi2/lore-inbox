Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSIOCtG>; Sat, 14 Sep 2002 22:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317673AbSIOCtG>; Sat, 14 Sep 2002 22:49:06 -0400
Received: from i061220.ap.plala.or.jp ([218.47.61.220]:23942 "HELO
	mana.fennel.org") by vger.kernel.org with SMTP id <S317648AbSIOCtF>;
	Sat, 14 Sep 2002 22:49:05 -0400
Date: Sun, 15 Sep 2002 11:53:48 +0900 (JST)
Message-Id: <20020915.115348.74604731.sian@big.or.jp>
To: linux-kernel@vger.kernel.org
Cc: conman@kolivas.net
Subject: Re: devfs on 2.5.34 and invisible partition
From: Hiroshi Takekawa <sian@big.or.jp>
In-Reply-To: <1032046397.3d83c73d5b732@kolivas.net>
References: <1032046397.3d83c73d5b732@kolivas.net>
X-Mailer: Mew version 3.0.64 on Emacs 21.3 / Mule 5.0
 =?iso-2022-jp?B?KBskQjgtTFobKEIvU0FLQUtJKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My /dev/hda7 (ide/host0/bus0/target0/lun0/part7) was rendered invisible with
> devfs enabled in 2.5.34.
> Disabling devfs made it visible again.

Is /dev/hda7 the last partition of /dev/hda? Then apply this to
check.c in linux/fs/partitions/.

--- check.c~	Tue Sep 10 19:34:55 2002
+++ check.c	Wed Sep 11 19:55:29 2002
@@ -327,7 +327,7 @@
 	devfs_auto_unregister(dev->disk_de, slave);
 	if (!(dev->flags & GENHD_FL_DEVFS))
 		devfs_auto_unregister (slave, dir);
-	for (part = 1, p++; part < max_p; part++, p++)
+	for (part = 1; part < max_p; part++, p++)
 		if (p->nr_sects)
 			devfs_register_partition(dev, part);
 #endif
