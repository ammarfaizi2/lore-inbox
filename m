Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSDRWGM>; Thu, 18 Apr 2002 18:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314477AbSDRWGM>; Thu, 18 Apr 2002 18:06:12 -0400
Received: from [195.39.17.254] ([195.39.17.254]:20621 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314475AbSDRWGK>;
	Thu, 18 Apr 2002 18:06:10 -0400
Date: Fri, 19 Apr 2002 00:03:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Device support for basic device
Message-ID: <20020418220303.GA17913@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds support for devicefs for i8259.c and time.c. Please apply,

							Pavel

--- linux/arch/i386/kernel/i8259.c	Thu Apr 18 22:44:39 2002
+++ linux-dm/arch/i386/kernel/i8259.c	Thu Apr 18 23:48:49 2002
@@ -11,6 +11,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
+#include <linux/device.h>
 
 #include <asm/atomic.h>
 #include <asm/system.h>
@@ -236,6 +237,18 @@
 		goto handle_real_irq;
 	}
 }
+
+static struct device device_i8259A = {
+	name:	       	"i8259A",
+	bus_id:		"0020",
+};
+
+static void __init init_8259A_devicefs(void)
+{
+	register_sys_device(&device_i8259A);
+}
+
+__initcall(init_8259A_devicefs);
 
 void __init init_8259A(int auto_eoi)
 {
--- linux/arch/i386/kernel/time.c	Sun Mar 10 20:07:25 2002
+++ linux-dm/arch/i386/kernel/time.c	Thu Apr 18 23:48:30 2002
@@ -42,6 +42,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/module.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -635,6 +636,17 @@
 bad_ctc:
 	return 0;
 }
+
+static struct device device_i8253;
+
+static void time_init_driverfs(void)
+{
+	strcpy(device_i8253.name, "i8253");
+	strcpy(device_i8253.bus_id, "0040");
+	register_sys_device(&device_i8253);
+}
+
+__initcall(time_init_driverfs);
 
 void __init time_init(void)
 {

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
