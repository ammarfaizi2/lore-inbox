Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318216AbSHKJNJ>; Sun, 11 Aug 2002 05:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318242AbSHKJNJ>; Sun, 11 Aug 2002 05:13:09 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:52356 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S318216AbSHKJNH>;
	Sun, 11 Aug 2002 05:13:07 -0400
To: <linux-kernel@vger.kernel.org>
Cc: marcelo@conectiva.com.br, Stephane Wirtel <stephane.wirtel@belgacom.net>
Subject: Re: [PATCH] 2.4.20-pre1 warnings cleanup
References: <m3y9be2ulv.fsf@defiant.pm.waw.pl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 11 Aug 2002 10:48:21 +0200
In-Reply-To: <m3y9be2ulv.fsf@defiant.pm.waw.pl>
Message-ID: <m3r8h5233e.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Oops,

Krzysztof Halasa <khc@pm.waw.pl> writes:

> The following patch clears some compiler warning messages from 2.4.20-pre1
> and eliminates unused code.

The patch is attached.
-- 
Krzysztof Halasa
Network Administrator

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=warnings-2.4.20-pre1.patch

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
