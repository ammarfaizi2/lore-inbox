Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261234AbREUM0P>; Mon, 21 May 2001 08:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261255AbREUM0F>; Mon, 21 May 2001 08:26:05 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:10250 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261234AbREUMZx>; Mon, 21 May 2001 08:25:53 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105211226.OAA17560@green.mif.pg.gda.pl>
Subject: [PATCH] CONFIG_PROC_FS=n fixes
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
Date: Mon, 21 May 2001 14:26:05 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   The following patch fixes compilation problems of
- zoran (drivers/media/video/zr36067.c) 
- Compaq SMART2 disk array (drivers/block/cpqarray.c)

and possibly some others, when CONFIG_PROC_FS=n

Andrzej

***********************************************************************
diff -ur linux-2.4.4-ac11/drivers/media/video/zoran.h linux/drivers/media/video/zoran.h
--- linux-2.4.4-ac11/drivers/media/video/zoran.h	Mon May 21 12:57:46 2001
+++ linux/drivers/media/video/zoran.h	Mon May 21 14:14:16 2001
@@ -305,11 +305,8 @@
 	struct zoran_gbuffer jpg_gbuf[BUZ_MAX_FRAME];	/* MJPEG buffers' info */
 
 	/* Additional stuff for testing */
-#ifdef CONFIG_PROC_FS
-
 	struct proc_dir_entry *zoran_proc;
 
-#endif
 	int testing;
 	int jpeg_error;
 	int intr_counter_GIRQ1;
diff -ur linux-2.4.4-ac11/include/linux/proc_fs.h linux/include/linux/proc_fs.h
--- linux-2.4.4-ac11/include/linux/proc_fs.h	Mon May 21 12:03:41 2001
+++ linux/include/linux/proc_fs.h	Mon May 21 12:03:22 2001
@@ -171,6 +171,8 @@
 
 #else
 
+#define proc_root_driver NULL
+
 static inline struct proc_dir_entry *proc_net_create(const char *name, mode_t mode, 
 	get_info_t *get_info) {return NULL;}
 static inline void proc_net_remove(const char *name) {}
 
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
