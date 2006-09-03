Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWICWbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWICWbP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWICWaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:30:52 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:23952 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751279AbWICWac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:30:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bqFbdOAPKjUEmn2pgKUDzv/bg4GIDpJY3YIalDeGNoMJvU+dI2emKiNbDoAM4eKj1Hy5dsvYu6gM2YVKrxksgtQ6IssKCT3ewlh1CMmc03UxR/H13S5sSwafDZSnObWC3EKaj1dzu+KyMPaGGA6g1+4m/J3XMBgd/lto/FM9Rnw=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 16/26] Dynamic kernel command-line - powerpc
Date: Mon, 4 Sep 2006 01:21:52 +0300
User-Agent: KMail/1.9.4
Cc: Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com,
       davej@codemonkey.org.uk, Riley@williams.name, trini@kernel.crashing.org,
       davem@davemloft.net, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org, wli@holomorphy.com, lethal@linux-sh.org, rc@rc0.org.uk,
       spyro@f2s.com, rth@twiddle.net, avr32@atmel.com, hskinnemoen@atmel.com,
       starvik@axis.com, ralf@linux-mips.org, matthew@wil.cx,
       grundler@parisc-linux.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
References: <200609040115.22856.alon.barlev@gmail.com>
In-Reply-To: <200609040115.22856.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609040121.53901.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/powerpc/kernel/legacy_serial.c linux-2.6.18-rc5-mm1/arch/powerpc/kernel/legacy_serial.c
--- linux-2.6.18-rc5-mm1.org/arch/powerpc/kernel/legacy_serial.c	2006-09-03 18:56:50.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/powerpc/kernel/legacy_serial.c	2006-09-03 19:47:58.000000000 +0300
@@ -498,7 +498,7 @@ static int __init check_legacy_serial_co
 	DBG(" -> check_legacy_serial_console()\n");
 
 	/* The user has requested a console so this is already set up. */
-	if (strstr(saved_command_line, "console=")) {
+	if (strstr(boot_command_line, "console=")) {
 		DBG(" console was specified !\n");
 		return -EBUSY;
 	}
diff -urNp linux-2.6.18-rc5-mm1.org/arch/powerpc/kernel/prom.c linux-2.6.18-rc5-mm1/arch/powerpc/kernel/prom.c
--- linux-2.6.18-rc5-mm1.org/arch/powerpc/kernel/prom.c	2006-09-03 18:56:50.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/powerpc/kernel/prom.c	2006-09-03 19:47:58.000000000 +0300
@@ -909,7 +909,7 @@ void __init early_init_devtree(void *par
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 
 	/* Save command line for /proc/cmdline and then parse parameters */
-	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
 	parse_early_param();
 
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
diff -urNp linux-2.6.18-rc5-mm1.org/arch/powerpc/kernel/udbg.c linux-2.6.18-rc5-mm1/arch/powerpc/kernel/udbg.c
--- linux-2.6.18-rc5-mm1.org/arch/powerpc/kernel/udbg.c	2006-09-03 18:55:13.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/powerpc/kernel/udbg.c	2006-09-03 19:47:58.000000000 +0300
@@ -146,7 +146,7 @@ void __init disable_early_printk(void)
 {
 	if (!early_console_initialized)
 		return;
-	if (strstr(saved_command_line, "udbg-immortal")) {
+	if (strstr(boot_command_line, "udbg-immortal")) {
 		printk(KERN_INFO "early console immortal !\n");
 		return;
 	}
diff -urNp linux-2.6.18-rc5-mm1.org/arch/powerpc/platforms/powermac/setup.c linux-2.6.18-rc5-mm1/arch/powerpc/platforms/powermac/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/powerpc/platforms/powermac/setup.c	2006-09-03 18:56:51.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/powerpc/platforms/powermac/setup.c	2006-09-03 19:47:58.000000000 +0300
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

-- 
VGER BF report: H 0
