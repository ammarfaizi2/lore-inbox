Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTE0KWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 06:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTE0KWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 06:22:05 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:18705 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263187AbTE0KWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 06:22:04 -0400
Date: Tue, 27 May 2003 20:35:05 +1000
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fixes agp_* struct renaming casualties
Message-ID: <20030527103505.GA23493@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following patch fixes some remaining references to agp_* structures
without struct.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/video/i810/i810.h
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/video/i810/i810.h,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 i810.h
--- drivers/video/i810/i810.h	4 May 2003 23:53:41 -0000	1.1.1.4
+++ drivers/video/i810/i810.h	27 May 2003 10:29:33 -0000
@@ -203,8 +203,8 @@
 #define LOCKUP                      8
 
 struct gtt_data {
-	agp_memory *i810_fb_memory;
-	agp_memory *i810_cursor_memory;
+	struct agp_memory *i810_fb_memory;
+	struct agp_memory *i810_cursor_memory;
 };
 
 struct mode_registers {
Index: drivers/video/sis/sis_main.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/video/sis/sis_main.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 sis_main.c
--- drivers/video/sis/sis_main.c	4 May 2003 23:53:35 -0000	1.1.1.4
+++ drivers/video/sis/sis_main.c	27 May 2003 10:30:47 -0000
@@ -2868,8 +2868,8 @@
 	unsigned long *write_port = 0;
 	SIS_CMDTYPE    cmd_type;
 #ifndef AGPOFF
-	agp_kern_info  *agp_info;
-	agp_memory     *agp;
+	struct agp_kern_info  *agp_info;
+	struct agp_memory     *agp;
 	u32            agp_phys;
 #endif
 #endif
@@ -2946,8 +2946,8 @@
 
 #ifndef AGPOFF
 	if (sisfb_queuemode == AGP_CMD_QUEUE) {
-		agp_info = vmalloc(sizeof(agp_kern_info));
-		memset((void*)agp_info, 0x00, sizeof(agp_kern_info));
+		agp_info = vmalloc(sizeof(*agp_info));
+		memset((void*)agp_info, 0x00, sizeof(*agp_info));
 		agp_copy_info(agp_info);
 
 		agp_backend_acquire();

--rwEMma7ioTxnRzrJ--
