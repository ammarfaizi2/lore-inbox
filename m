Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162923AbWLBLEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162923AbWLBLEF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162922AbWLBLAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:00:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:17093 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1759471AbWLBK7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Pwv5WLUnCt+Br4sYMrsf9u2m9uqX812oO8kfdvQtAgl3ZXYW/lq7Nqx165iC5KCjz1xCp6O5AgeukugfdMW3fbNzmX+wZhA+/J0Q9Sg24wpzMihU2xgAppjr9hP0poZMoNvvc9y6pkGeZN+kUQ3E5Nm5vVgLo8CwKUtAdEc37fo=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/26] Dynamic kernel command-line - powerpc
Date: Sat, 2 Dec 2006 12:54:14 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021254.14742.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/powerpc/kernel/legacy_serial.c linux-2.6.19/arch/powerpc/kernel/legacy_serial.c
--- linux-2.6.19.org/arch/powerpc/kernel/legacy_serial.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/powerpc/kernel/legacy_serial.c	2006-12-02 11:31:33.000000000 +0200
@@ -498,7 +498,7 @@ static int __init check_legacy_serial_co
 	DBG(" -> check_legacy_serial_console()\n");
 
 	/* The user has requested a console so this is already set up. */
-	if (strstr(saved_command_line, "console=")) {
+	if (strstr(boot_command_line, "console=")) {
 		DBG(" console was specified !\n");
 		return -EBUSY;
 	}
diff -urNp linux-2.6.19.org/arch/powerpc/kernel/prom.c linux-2.6.19/arch/powerpc/kernel/prom.c
--- linux-2.6.19.org/arch/powerpc/kernel/prom.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/powerpc/kernel/prom.c	2006-12-02 11:31:33.000000000 +0200
@@ -894,7 +894,7 @@ void __init early_init_devtree(void *par
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 
 	/* Save command line for /proc/cmdline and then parse parameters */
-	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
 	parse_early_param();
 
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
diff -urNp linux-2.6.19.org/arch/powerpc/kernel/udbg.c linux-2.6.19/arch/powerpc/kernel/udbg.c
--- linux-2.6.19.org/arch/powerpc/kernel/udbg.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/powerpc/kernel/udbg.c	2006-12-02 11:31:33.000000000 +0200
@@ -146,7 +146,7 @@ void __init disable_early_printk(void)
 {
 	if (!early_console_initialized)
 		return;
-	if (strstr(saved_command_line, "udbg-immortal")) {
+	if (strstr(boot_command_line, "udbg-immortal")) {
 		printk(KERN_INFO "early console immortal !\n");
 		return;
 	}
diff -urNp linux-2.6.19.org/arch/powerpc/platforms/powermac/setup.c linux-2.6.19/arch/powerpc/platforms/powermac/setup.c
--- linux-2.6.19.org/arch/powerpc/platforms/powermac/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/powerpc/platforms/powermac/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -505,8 +505,8 @@ void note_bootable_part(dev_t dev, int p
 	if ((goodness <= current_root_goodness) &&
 	    ROOT_DEV != DEFAULT_ROOT_DEVICE)
 		return;
-	p = strstr(saved_command_line, "root=");
-	if (p != NULL && (p == saved_command_line || p[-1] == ' '))
+	p = strstr(boot_command_line, "root=");
+	if (p != NULL && (p == boot_command_line || p[-1] == ' '))
 		return;
 
 	if (!found_boot) {
