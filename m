Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbUCYAEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbUCYADz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:03:55 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:19099 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S262758AbUCXX7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:59:35 -0500
Subject: [patch 11/22] __early_param for m68knommu
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
From: trini@kernel.crashing.org
Message-Id: <20040324235933.RFQI4381.fed1mtao07.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:59:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Remove saved_command_line (and saving of the command line).
- Call parse_early_options


---

 linux-2.6-early_setup-trini/arch/m68knommu/kernel/setup.c       |    3 +--
 linux-2.6-early_setup-trini/arch/m68knommu/kernel/vmlinux.lds.S |    3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff -puN arch/m68knommu/kernel/setup.c~m68knommu arch/m68knommu/kernel/setup.c
--- linux-2.6-early_setup/arch/m68knommu/kernel/setup.c~m68knommu	2004-03-24 16:15:07.785434583 -0700
+++ linux-2.6-early_setup-trini/arch/m68knommu/kernel/setup.c	2004-03-24 16:15:07.790433457 -0700
@@ -226,8 +226,7 @@ void setup_arch(char **cmdline_p)
 
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
-	memcpy(saved_command_line, command_line, sizeof(saved_command_line));
-	saved_command_line[sizeof(saved_command_line)-1] = 0;
+	parse_early_options(cmdline_p);
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p)) 
diff -puN arch/m68knommu/kernel/vmlinux.lds.S~m68knommu arch/m68knommu/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/m68knommu/kernel/vmlinux.lds.S~m68knommu	2004-03-24 16:15:07.787434133 -0700
+++ linux-2.6-early_setup-trini/arch/m68knommu/kernel/vmlinux.lds.S	2004-03-24 16:15:07.790433457 -0700
@@ -262,6 +262,9 @@ SECTIONS {
 		__setup_start = .;
 		*(.init.setup)
 		__setup_end = .;
+		__early_begin = .;
+		__early_param : { *(__early_param) }
+		__early_end = .;
 		__start___param = .;
 		*(__param)
 		__stop___param = .;

_
