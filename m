Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUHEFwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUHEFwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267557AbUHEFwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:52:54 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:21509 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S267555AbUHEFwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:52:49 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Make MAX_INIT_ARGS 25
Date: Thu, 5 Aug 2004 07:52:46 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, spot@redhat.com, akpm@osdl.org
References: <20040804193243.36009baa@lembas.zaitcev.lan>
In-Reply-To: <20040804193243.36009baa@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uscEBLcevFBLPJC"
Message-Id: <200408050752.46409.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_uscEBLcevFBLPJC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 05 of August 2004 04:32, Pete Zaitcev wrote:

> --- linux-2.6.7/init/main.c	2004-06-16 16:54:07.000000000 -0700
> +++ linux-2.6.7-usb/init/main.c	2004-08-04 19:16:22.566593218 -0700
> @@ -102,8 +102,8 @@
>  /*
>   * Boot command-line arguments
>   */
> -#define MAX_INIT_ARGS 8
> -#define MAX_INIT_ENVS 8
> +#define MAX_INIT_ARGS 25
> +#define MAX_INIT_ENVS 25

You should also increase the COMMAND_LINE_SIZE.

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_uscEBLcevFBLPJC
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="kernel-MAX_INIT_ARGS.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kernel-MAX_INIT_ARGS.patch"

--- linux-2.6.7-rc2/init/main.c.org	2004-06-04 12:58:31.000000000 +0200
+++ linux-2.6.7-rc2/init/main.c	2004-06-04 13:43:02.000000000 +0200
@@ -103,8 +103,8 @@
 /*
  * Boot command-line arguments
  */
-#define MAX_INIT_ARGS 8
-#define MAX_INIT_ENVS 8
+#define MAX_INIT_ARGS 256
+#define MAX_INIT_ENVS 256
 
 extern void time_init(void);
 /* Default late time init is NULL. archs can override this later. */
--- linux-2.6.7/include/asm-i386/param.h.orig	2004-07-03 16:56:41.000000000 +0200
+++ linux-2.6.7/include/asm-i386/param.h	2004-07-03 19:10:53.358244832 +0200
@@ -18,6 +18,6 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 4096
 
 #endif
diff -Nur --exclude '*.orig' linux-2.6.7-rc3.org/include/asm-i386/setup.h linux-2.6.7-rc3/include/asm-i386/setup.h
--- linux-2.6.7-rc3.org/include/asm-i386/setup.h	2004-06-07 21:14:42.000000000 +0200
+++ linux-2.6.7-rc3/include/asm-i386/setup.h	2004-06-08 11:29:19.000000000 +0200
@@ -17,7 +17,7 @@
 #define MAX_NONPAE_PFN	(1 << 20)
 
 #define PARAM_SIZE 2048
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 4096
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
diff -Nur --exclude '*.orig' linux-2.6.7-rc3.org/include/asm-s390/setup.h linux-2.6.7-rc3/include/asm-s390/setup.h
--- linux-2.6.7-rc3.org/include/asm-s390/setup.h	2004-06-07 21:14:58.000000000 +0200
+++ linux-2.6.7-rc3/include/asm-s390/setup.h	2004-06-08 11:30:38.000000000 +0200
@@ -9,7 +9,7 @@
 #define _ASM_S390_SETUP_H
 
 #define PARMAREA		0x10400
-#define COMMAND_LINE_SIZE 	896
+#define COMMAND_LINE_SIZE 	4096
 #define RAMDISK_ORIGIN		0x800000
 #define RAMDISK_SIZE		0x800000
 
--- linux-2.6.7/include/asm-ppc/setup.h.orig	2004-07-06 17:53:17.000000000 +0200
+++ linux-2.6.7/include/asm-ppc/setup.h	2004-07-06 17:55:37.428864888 +0200
@@ -8,7 +8,7 @@
 #include <asm-m68k/setup.h>
 /* We have a bigger command line buffer. */
 #undef COMMAND_LINE_SIZE
-#define COMMAND_LINE_SIZE	512
+#define COMMAND_LINE_SIZE	4096
 
 #endif /* _PPC_SETUP_H */
 #endif /* __KERNEL__ */
--- linux-2.6.7/arch/ppc/syslib/prom.c.orig	2004-07-06 17:53:30.000000000 +0200
+++ linux-2.6.7/arch/ppc/syslib/prom.c	2004-07-06 17:55:57.781770776 +0200
@@ -85,7 +85,7 @@
 extern void enter_rtas(void *);
 void phys_call_rtas(int, int, int, ...);
 
-extern char cmd_line[512];	/* XXX */
+extern char cmd_line[COMMAND_LINE_SIZE];
 extern boot_infos_t *boot_infos;
 unsigned long dev_tree_size;
 

--Boundary-00=_uscEBLcevFBLPJC--
