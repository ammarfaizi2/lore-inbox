Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbTCaOPS>; Mon, 31 Mar 2003 09:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261653AbTCaOPS>; Mon, 31 Mar 2003 09:15:18 -0500
Received: from verein.lst.de ([212.34.181.86]:57862 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261651AbTCaOPP>;
	Mon, 31 Mar 2003 09:15:15 -0500
Date: Mon, 31 Mar 2003 16:26:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove kdevname() before someone starts using it again
Message-ID: <20030331162634.A14319@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.14/fs/libfs.c	Wed Jan  1 02:18:35 2003
+++ edited/fs/libfs.c	Wed Mar 26 21:32:02 2003
@@ -332,14 +332,3 @@
 	set_page_dirty(page);
 	return 0;
 }
-
-/*
- * Print device name (in decimal, hexadecimal or symbolic)
- * Note: returns pointer to static data!
- */
-const char * kdevname(kdev_t dev)
-{
-	static char buffer[32];
-	sprintf(buffer, "%02x:%02x", major(dev), minor(dev));
-	return buffer;
-}
--- 1.222/include/linux/fs.h	Sun Mar 23 07:14:19 2003
+++ edited/include/linux/fs.h	Wed Mar 26 21:32:08 2003
@@ -1074,7 +1074,6 @@
 extern void close_bdev_excl(struct block_device *, int);
 
 extern const char * cdevname(kdev_t);
-extern const char * kdevname(kdev_t);
 extern void init_special_inode(struct inode *, umode_t, dev_t);
 
 /* Invalid inode operations -- fs/bad_inode.c */
--- 1.7/include/linux/kdev_t.h	Fri Nov  1 13:28:19 2002
+++ edited/include/linux/kdev_t.h	Wed Mar 26 21:32:14 2003
@@ -101,8 +101,6 @@
 #define NODEV		(mk_kdev(0,0))
 #define B_FREE		(mk_kdev(0xff,0xff))
 
-extern const char * kdevname(kdev_t);	/* note: returns pointer to static data! */
-
 static inline int kdev_same(kdev_t dev1, kdev_t dev2)
 {
 	return dev1.value == dev2.value;
--- 1.186/kernel/ksyms.c	Sat Mar 22 05:05:21 2003
+++ edited/kernel/ksyms.c	Wed Mar 26 21:32:22 2003
@@ -511,7 +511,6 @@
 EXPORT_SYMBOL(vsprintf);
 EXPORT_SYMBOL(vsnprintf);
 EXPORT_SYMBOL(vsscanf);
-EXPORT_SYMBOL(kdevname);
 EXPORT_SYMBOL(__bdevname);
 EXPORT_SYMBOL(cdevname);
 EXPORT_SYMBOL(simple_strtoull);
