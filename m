Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262946AbVCDRys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbVCDRys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVCDRyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:54:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:23482 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263004AbVCDRyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:54:00 -0500
Date: Fri, 4 Mar 2005 09:53:50 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: chrisw@osdl.org, torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.11.1
Message-ID: <20050304175350.GB29289@kroah.com>
References: <20050304175302.GA29289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304175302.GA29289@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 09:53:02AM -0800, Greg KH wrote:
> I'll also be replying to this message with a copy of the patch itself,
> as it is small enough to do so.

Here it is....


diff -Nru a/Makefile b/Makefile
--- a/Makefile	2005-03-04 09:27:15 -08:00
+++ b/Makefile	2005-03-04 09:27:15 -08:00
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 11
-EXTRAVERSION =
+EXTRAVERSION = .1
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -Nru a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
--- a/drivers/input/serio/i8042-x86ia64io.h	2005-03-04 09:27:15 -08:00
+++ b/drivers/input/serio/i8042-x86ia64io.h	2005-03-04 09:27:15 -08:00
@@ -88,7 +88,7 @@
 };
 #endif
 
-#ifdef CONFIG_ACPI
+#if defined(__ia64__) && defined(CONFIG_ACPI)
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 
@@ -281,7 +281,7 @@
 	i8042_kbd_irq = I8042_MAP_IRQ(1);
 	i8042_aux_irq = I8042_MAP_IRQ(12);
 
-#ifdef CONFIG_ACPI
+#if defined(__ia64__) && defined(CONFIG_ACPI)
 	if (i8042_acpi_init())
 		return -1;
 #endif
@@ -300,7 +300,7 @@
 
 static inline void i8042_platform_exit(void)
 {
-#ifdef CONFIG_ACPI
+#if defined(__ia64__) && defined(CONFIG_ACPI)
 	i8042_acpi_exit();
 #endif
 }
diff -Nru a/drivers/md/raid6altivec.uc b/drivers/md/raid6altivec.uc
--- a/drivers/md/raid6altivec.uc	2005-03-04 09:27:15 -08:00
+++ b/drivers/md/raid6altivec.uc	2005-03-04 09:27:15 -08:00
@@ -108,7 +108,11 @@
 int raid6_have_altivec(void)
 {
 	/* This assumes either all CPUs have Altivec or none does */
+#ifdef CONFIG_PPC64
 	return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
+#else
+	return cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC;
+#endif
 }
 #endif
 
