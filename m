Return-Path: <linux-kernel-owner+w=401wt.eu-S932438AbXARNGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbXARNGQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbXARNFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:05:50 -0500
Received: from cantor.suse.de ([195.135.220.2]:50517 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932333AbXARNER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:17 -0500
Message-Id: <20070118130029.828327000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:58:59 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 10/26] Dynamic kernel command-line - ia64
Content-Disposition: inline; filename=dynamic-kernel-command-line-ia64.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/ia64/kernel/efi.c   |    4 ++--
 arch/ia64/kernel/sal.c   |    4 ++--
 arch/ia64/kernel/setup.c |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/ia64/kernel/efi.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/ia64/kernel/efi.c
+++ linux-2.6.20-rc4-mm1/arch/ia64/kernel/efi.c
@@ -413,11 +413,11 @@ efi_init (void)
 	efi_char16_t *c16;
 	u64 efi_desc_size;
 	char *cp, vendor[100] = "unknown";
-	extern char saved_command_line[];
+	extern char __initdata boot_command_line[];
 	int i;
 
 	/* it's too early to be able to use the standard kernel command line support... */
-	for (cp = saved_command_line; *cp; ) {
+	for (cp = boot_command_line; *cp; ) {
 		if (memcmp(cp, "mem=", 4) == 0) {
 			mem_limit = memparse(cp + 4, &cp);
 		} else if (memcmp(cp, "max_addr=", 9) == 0) {
Index: linux-2.6.20-rc4-mm1/arch/ia64/kernel/sal.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/ia64/kernel/sal.c
+++ linux-2.6.20-rc4-mm1/arch/ia64/kernel/sal.c
@@ -194,9 +194,9 @@ static void __init
 chk_nointroute_opt(void)
 {
 	char *cp;
-	extern char saved_command_line[];
+	extern char __initdata boot_command_line[];
 
-	for (cp = saved_command_line; *cp; ) {
+	for (cp = boot_command_line; *cp; ) {
 		if (memcmp(cp, "nointroute", 10) == 0) {
 			no_int_routing = 1;
 			printk ("no_int_routing on\n");
Index: linux-2.6.20-rc4-mm1/arch/ia64/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/ia64/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/ia64/kernel/setup.c
@@ -463,7 +463,7 @@ setup_arch (char **cmdline_p)
 	ia64_patch_vtop((u64) __start___vtop_patchlist, (u64) __end___vtop_patchlist);
 
 	*cmdline_p = __va(ia64_boot_param->command_line);
-	strlcpy(saved_command_line, *cmdline_p, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
 
 	efi_init();
 	io_port_init();

-- 
