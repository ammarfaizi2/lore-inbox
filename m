Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318736AbSIKMBD>; Wed, 11 Sep 2002 08:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318738AbSIKMBD>; Wed, 11 Sep 2002 08:01:03 -0400
Received: from i050225.ap.plala.or.jp ([218.47.50.225]:8576 "HELO
	mana.fennel.org") by vger.kernel.org with SMTP id <S318736AbSIKMBC>;
	Wed, 11 Sep 2002 08:01:02 -0400
Date: Wed, 11 Sep 2002 21:05:40 +0900 (JST)
Message-Id: <20020911.210540.103443979.sian@big.or.jp>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.34 partition off by one
From: Hiroshi Takekawa <sian@big.or.jp>
X-Mailer: Mew version 3.0.64 on Emacs 21.3 / Mule 5.0
 =?iso-2022-jp?B?KBskQjgtTFobKEIvU0FLQUtJKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I needed this patch to boot my machine, Linux-2.5.34 devfs enabled.
My root fs is on /dev/hda6, the last partition of /dev/hda.
create_dev("/dev/root", ...) in do_mounts.c failed because /dev/hda6
was not found by devfs_get_handle().  It appears that
devfs_register_partition() is not called for /dev/hda6...

Please apply if this patch is right and it hasn't been fixed yet.

Sincerely,

--
Hiroshi Takekawa <sian@big.or.jp>


--- check.c~    Tue Sep 10 19:34:55 2002
+++ check.c     Wed Sep 11 19:55:29 2002
@@ -327,7 +327,7 @@
        devfs_auto_unregister(dev->disk_de, slave);
        if (!(dev->flags & GENHD_FL_DEVFS))
                devfs_auto_unregister (slave, dir);
-       for (part = 1, p++; part < max_p; part++, p++)
+       for (part = 1; part < max_p; part++, p++)
                if (p->nr_sects)
                        devfs_register_partition(dev, part);
 #endif
