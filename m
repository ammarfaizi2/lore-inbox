Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbUDFNj6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbUDFNj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:39:58 -0400
Received: from ns.suse.de ([195.135.220.2]:1439 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263812AbUDFNjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:39:51 -0400
Date: Tue, 6 Apr 2004 15:36:38 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] NUMA API for Linux 4/ Add IA64 support
Message-Id: <20040406153638.0ec6416b.ak@suse.de>
In-Reply-To: <20040406153322.5d6e986e.ak@suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add NUMA API system calls on IA64 and one bug fix required for it.

diff -u linux-2.6.5-numa/arch/ia64/kernel/acpi.c-o linux-2.6.5-numa/arch/ia64/kernel/acpi.c
--- linux-2.6.5-numa/arch/ia64/kernel/acpi.c-o	2004-04-06 13:12:00.000000000 +0200
+++ linux-2.6.5-numa/arch/ia64/kernel/acpi.c	2004-04-06 13:36:12.000000000 +0200
@@ -455,6 +455,7 @@
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (pxm_bit_test(i)) {
 			pxm_to_nid_map[i] = numnodes;
+			node_set_online(numnodes);
 			nid_to_pxm_map[numnodes++] = i;
 		}
 	}
diff -u linux-2.6.5-numa/arch/ia64/kernel/entry.S-o linux-2.6.5-numa/arch/ia64/kernel/entry.S
--- linux-2.6.5-numa/arch/ia64/kernel/entry.S-o	2004-03-21 21:12:05.000000000 +0100
+++ linux-2.6.5-numa/arch/ia64/kernel/entry.S	2004-04-06 13:36:12.000000000 +0200
@@ -1501,9 +1501,9 @@
 	data8 sys_clock_nanosleep
 	data8 sys_fstatfs64
 	data8 sys_statfs64
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall			// 1260
-	data8 sys_ni_syscall
+	data8 sys_mbind
+	data8 sys_get_mempolicy			// 1260
+	data8 sys_set_mempolicy
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
diff -u linux-2.6.5-numa/include/asm-ia64/unistd.h-o linux-2.6.5-numa/include/asm-ia64/unistd.h
--- linux-2.6.5-numa/include/asm-ia64/unistd.h-o	2004-04-06 13:12:19.000000000 +0200
+++ linux-2.6.5-numa/include/asm-ia64/unistd.h	2004-04-06 13:36:12.000000000 +0200
@@ -248,9 +248,9 @@
 #define __NR_clock_nanosleep		1256
 #define __NR_fstatfs64			1257
 #define __NR_statfs64			1258
-#define __NR_reserved1			1259	/* reserved for NUMA interface */
-#define __NR_reserved2			1260	/* reserved for NUMA interface */
-#define __NR_reserved3			1261	/* reserved for NUMA interface */
+#define __NR_mbind			1259
+#define __NR_get_mempolicy		1260
+#define __NR_set_mempolicy		1261
 
 #ifdef __KERNEL__
 
