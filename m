Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265276AbUF3ClQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUF3ClQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 22:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265534AbUF3ClQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 22:41:16 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:49381 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S265276AbUF3ClO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 22:41:14 -0400
Date: Tue, 29 Jun 2004 22:41:12 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
To: jsimmons@infradead.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] asiliantfb fixes
Message-ID: <Pine.LNX.4.58.0406292217520.5837@ally.lammerts.org>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
this patch fixes the asiliantfb driver. A call to the init function
was missing so it was never actually used. The other fix is in the
init function writing somewhere using a physical address instead of a
virtual address.

Eric

--- linux-2.6.7/drivers/video/fbmem.c.orig	2004-06-23 21:53:18.000000000 -0400
+++ linux-2.6.7/drivers/video/fbmem.c	2004-06-28 22:10:45.000000000 -0400
@@ -172,6 +172,7 @@
 extern int kyrofb_setup(char*);
 extern int mc68x328fb_init(void);
 extern int mc68x328fb_setup(char *);
+extern int asiliantfb_init(void);

 static struct {
 	const char *name;
@@ -245,6 +246,9 @@
 #ifdef CONFIG_FB_CT65550
 	{ "chipsfb", chips_init, NULL },
 #endif
+#ifdef CONFIG_FB_ASILIANT
+	{ "asiliant", asiliantfb_init, NULL },
+#endif
 #ifdef CONFIG_FB_IMSTT
 	{ "imsttfb", imsttfb_init, imsttfb_setup },
 #endif
--- linux-2.6.7/drivers/video/asiliantfb.c.orig	2004-06-28 22:03:38.000000000 -0400
+++ linux-2.6.7/drivers/video/asiliantfb.c	2004-06-28 22:04:28.000000000 -0400
@@ -571,7 +571,7 @@
 	}

 	pci_write_config_dword(dp, 4, 0x02800083);
-	writeb(3, addr + 0x400784);
+	writeb(3, p->screen_base + 0x400784);

 	init_asiliant(p, addr);

