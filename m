Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318102AbSHDFxI>; Sun, 4 Aug 2002 01:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318105AbSHDFxI>; Sun, 4 Aug 2002 01:53:08 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:3533 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S318102AbSHDFxH>;
	Sun, 4 Aug 2002 01:53:07 -0400
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH] 2.4.19 warnings cleanup
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 03 Aug 2002 22:06:21 +0200
Message-ID: <m3znw3k8qq.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The attached patch eliminates some compiler warning messages from
various parts of the kernel. It disables some unused code (compressed
ramdisk routines if no ramdisk support). Shouldn't break anything,
but I wouldn't rather apply it in final rc-* stages...

2.4.19 only.
-- 
Krzysztof Halasa
Network Administrator

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=warnings.patch

--- linux/drivers/char/agp/agpgart_be.c.orig	Sat Aug  3 18:30:26 2002
+++ linux/drivers/char/agp/agpgart_be.c	Sat Aug  3 18:32:41 2002
@@ -397,7 +397,7 @@
 static void agp_generic_agp_enable(u32 mode)
 {
 	struct pci_dev *device = NULL;
-	u32 command, scratch, cap_id;
+	u32 command, scratch;
 	u8 cap_ptr;
 
 	pci_read_config_dword(agp_bridge.dev,
@@ -4295,7 +4295,6 @@
 {
 	struct pci_dev *dev = NULL;
 	u8 cap_ptr = 0x00;
-	u32 cap_id, scratch;
 
 	if ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8, NULL)) == NULL)
 		return -ENODEV;
--- linux/arch/i386/kernel/dmi_scan.c.orig	Sat Aug  3 17:13:28 2002
+++ linux/arch/i386/kernel/dmi_scan.c	Sat Aug  3 19:02:47 2002
@@ -186,12 +186,13 @@
 #define MATCH(a,b)	{ a, b }
 
 /*
- *	We have problems with IDE DMA on some platforms. In paticular the
+ *	We have problems with IDE DMA on some platforms. In particular the
  *	KT7 series. On these it seems the newer BIOS has fixed them. The
  *	rule needs to be improved to match specific BIOS revisions with
  *	corruption problems
- */ 
- 
+ */
+
+#if 0
 static __init int disable_ide_dma(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_BLK_DEV_IDE
@@ -204,6 +205,7 @@
 #endif	
 	return 0;
 }
+#endif
 
 /* 
  * Reboot options and system auto-detection code provided by
--- linux/fs/dnotify.c.orig	Sat Aug  3 17:14:15 2002
+++ linux/fs/dnotify.c	Sat Aug  3 18:33:53 2002
@@ -135,7 +135,7 @@
 	}
 	if (changed)
 		redo_inode_mask(inode);
-out:
+
 	write_unlock(&dn_lock);
 }
 
--- linux/init/do_mounts.c.orig	Sat Aug  3 17:14:32 2002
+++ linux/init/do_mounts.c	Sat Aug  3 18:26:32 2002
@@ -882,6 +882,7 @@
 #define WSIZE 0x8000    /* window size--must be a power of two, and */
 			/*  at least 32K for zip's deflate method */
 
+#ifdef CONFIG_BLK_DEV_RAM
 static uch *inbuf;
 static uch *window;
 
@@ -1006,5 +1007,6 @@
 	kfree(window);
 	return result;
 }
+#endif /* CONFIG_BLK_DEV_RAM */
 
 #endif  /* BUILD_CRAMDISK */
--- linux/include/linux/namespace.h.orig	Sat Aug  3 17:14:31 2002
+++ linux/include/linux/namespace.h	Sat Aug  3 18:46:43 2002
@@ -38,5 +38,6 @@
 	atomic_inc(&namespace->count);
 }
 
+int __init init_rootfs(void);
 #endif
 #endif
--- linux/drivers/net/ppp_generic.c.orig	Sat Aug  3 17:13:58 2002
+++ linux/drivers/net/ppp_generic.c	Sat Aug  3 19:11:54 2002
@@ -378,7 +378,7 @@
 {
 	struct ppp_file *pf = file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
-	ssize_t ret;
+	ssize_t ret = 0; /* suppress compiler warning */
 	struct sk_buff *skb = 0;
 
 	if (pf == 0)
--- linux/arch/i386/kernel/setup.c.orig	Sat Aug  3 17:13:29 2002
+++ linux/arch/i386/kernel/setup.c	Sat Aug  3 19:17:22 2002
@@ -175,6 +175,8 @@
 static int disable_x86_fxsr __initdata = 0;
 static int disable_x86_ht __initdata = 0;
 
+static int __init have_cpuid_p(void);
+
 int enable_acpi_smp_table;
 
 #if defined(CONFIG_AGP) || defined(CONFIG_AGP_MODULE)

--=-=-=--
