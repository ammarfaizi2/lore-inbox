Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVERU0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVERU0l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVERU0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:26:40 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:64506 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262349AbVERU0Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 16:26:25 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc4-mm2
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050516021302.13bd285a.akpm@osdl.org>
References: <20050516021302.13bd285a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 18 May 2005 22:26:04 +0200
Message-Id: <1116447964.23209.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mån 2005-05-16 klockan 02:13 -0700 skrev Andrew Morton:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm2/
> 
> 
> - davem has set up a mm-commits mailing list so people can review things
>   which are added to or removed from the -mm tree.  Do
> 
> 	echo subscribe mm-commits | mail majordomo@vger.kernel.org
> 
> - x86_64 architecture update from Andi.
> 
> - Everything up to and including `spurious-interrupt-fix.patch' is planned
>   for 2.6.12 merging.  Plus a few other things in there.
> 
> - Another DVB subsystem update
> 

I need this to be able to compile on x64 without CONFIG_ACPI (yeah it's
probably wrong all the way, but can someone that knows acpi fix it
please?). Tested on i386 & x64 w & w/o CONFIG_ACPI.


Index: kexec/include/linux/acpi.h
===================================================================
--- kexec.orig/include/linux/acpi.h	2005-05-18 22:04:11.000000000 +0200
+++ kexec/include/linux/acpi.h	2005-05-18 22:13:13.000000000 +0200
@@ -25,8 +25,6 @@
 #ifndef _LINUX_ACPI_H
 #define _LINUX_ACPI_H
 
-#ifdef CONFIG_ACPI
-
 #ifndef _LINUX
 #define _LINUX
 #endif
@@ -419,6 +417,8 @@
 
 #else	/*!CONFIG_ACPI_BOOT*/
 
+static inline int acpi_boot_init (void) { return 0; }
+static inline int acpi_boot_table_init (void) { return 0; }
 #define acpi_mp_config	0
 
 #endif 	/*!CONFIG_ACPI_BOOT*/
@@ -531,18 +531,4 @@
 
 extern int pnpacpi_disabled;
 
-#else	/* CONFIG_ACPI */
-
-static inline int acpi_boot_init(void)
-{
-	return 0;
-}
-
-static inline int acpi_boot_table_init(void)
-{
-	return 0;
-}
-
-#endif	/* CONFIG_ACPI */
-
 #endif	/* _LINUX_ACPI_H */


