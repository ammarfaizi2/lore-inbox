Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbTFGOca (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 10:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTFGOc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 10:32:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1493 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261444AbTFGOc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 10:32:28 -0400
Date: Sat, 7 Jun 2003 16:45:58 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: bcollins@debian.org, linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [patch] 2.5.70-mm5: fix ieee1394_core.c compile if !CONFIG_PROC_FS
Message-ID: <20030607144558.GO15311@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error with !CONFIG_PROC_FS:

<--  snip  -->

...
  CC      drivers/ieee1394/ieee1394_core.o
drivers/ieee1394/ieee1394_core.c: In function `ieee1394_cleanup':
drivers/ieee1394/ieee1394_core.c:1231: `proc_bus' undeclared (first use in this function)
drivers/ieee1394/ieee1394_core.c:1231: (Each undeclared identifier is reported only once
drivers/ieee1394/ieee1394_core.c:1231: for each function it appears in.)
make[2]: *** [drivers/ieee1394/ieee1394_core.o] Error 1

<--  snip  -->


The following patch fixes it:


--- linux-2.5.70-mm5/drivers/ieee1394/ieee1394_core.c.old	2003-06-07 16:42:35.000000000 +0200
+++ linux-2.5.70-mm5/drivers/ieee1394/ieee1394_core.c	2003-06-07 16:42:47.000000000 +0200
@@ -1228,7 +1228,9 @@
 
 	unregister_chrdev(IEEE1394_MAJOR, "ieee1394");
 	devfs_remove("ieee1394");
+#ifdef CONFIG_PROC_FS
 	remove_proc_entry("ieee1394", proc_bus);
+#endif
 }
 
 module_init(ieee1394_init);



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

