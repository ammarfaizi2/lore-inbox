Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbTH0HM3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 03:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbTH0HM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 03:12:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39400 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263215AbTH0HMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 03:12:20 -0400
Date: Wed, 27 Aug 2003 09:12:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Joerg Reuter DL1BKE <jreuter@yaina.de>
Cc: linux-net@vger.kernel.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix bpqether.c compile without CONFIG_PROC_FS
Message-ID: <20030827071215.GL7038@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error when trying to compile 2.6.0-test4-mm1 
without CONFIG_PROC_FS (but this problem is most likely not limited to 
-mm):

<--  snip  -->

...
  CC      drivers/net/hamradio/bpqether.o
drivers/net/hamradio/bpqether.c: In function `bpq_init_driver':
drivers/net/hamradio/bpqether.c:608: parse error before `do'
...
make[3]: *** [drivers/net/hamradio/bpqether.o] Error 1

<--  snip  -->


It seems something like the following patch is needed:


--- linux-2.6.0-test4-mm1/drivers/net/hamradio/bpqether.c~	2003-08-23 01:55:31.000000000 +0200
+++ linux-2.6.0-test4-mm1/drivers/net/hamradio/bpqether.c	2003-08-27 09:00:04.000000000 +0200
@@ -605,6 +605,7 @@
 
 	printk(banner);
 
+#ifdef CONFIG_PROC_FS
 	if (!proc_net_fops_create("bpqether", S_IRUGO, &bpq_info_fops)) {
 		printk(KERN_ERR
 			"bpq: cannot create /proc/net/bpqether entry.\n");
@@ -612,6 +613,7 @@
 		dev_remove_pack(&bpq_packet_type);
 		return -ENOENT;
 	}
+#endif  /* CONFIG_PROC_FS */
 
 	rtnl_lock();
 	for (dev = dev_base; dev != NULL; dev = dev->next) {



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

