Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275709AbRJJNUi>; Wed, 10 Oct 2001 09:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275716AbRJJNU1>; Wed, 10 Oct 2001 09:20:27 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:9381 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S275709AbRJJNUJ>; Wed, 10 Oct 2001 09:20:09 -0400
Date: Wed, 10 Oct 2001 15:05:52 +0200
From: Urs.Ganse@t-online.de (Urs Ganse)
To: linux-kernel@vger.kernel.org
Cc: gtoumi@messel.emse.fr
Subject: fbmem.c lacks entries for sstfb
Message-ID: <20011010150552.A244@interblob>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone!

Since 2.4.10, sstfb, the Voodoo 1/2 framebuffer driver is included in
the kernel tree. It works fine as a module, but when it is compiled
fixed into the kernel, it won't initialize 'cause the appropiate
entries in fbmem.c are missing (they exist in the ac-branch,
though). The patch is attached.

Sincerely,
	Urs Ganse
--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fbmem-patch

--- linux/drivers/video/fbmem.c~	Wed Oct 10 12:42:47 2001
+++ linux/drivers/video/fbmem.c	Wed Oct 10 12:56:56 2001
@@ -124,6 +124,8 @@
 extern int e1355fb_setup(char*);
 extern int pvr2fb_init(void);
 extern int pvr2fb_setup(char*);
+extern int sstfb_init(void);
+extern int sstfb_setup(char*);
 
 static struct {
 	const char *name;
@@ -274,7 +276,9 @@
 #ifdef CONFIG_FB_PVR2
 	{ "pvr2", pvr2fb_init, pvr2fb_setup },
 #endif
-
+#ifdef CONFIG_FB_VOODOO1
+	{ "sst", sstfb_init, sstfb_setup },
+#endif
 	/*
 	 * Generic drivers that don't use resource management (yet)
 	 */

--WIyZ46R2i8wDzkSu--
