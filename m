Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUDFNhw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbUDFNhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:37:52 -0400
Received: from ns.suse.de ([195.135.220.2]:18589 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263820AbUDFNho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:37:44 -0400
Date: Tue, 6 Apr 2004 15:35:55 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] NUMA API for Linux 3/ Add i386 support
Message-Id: <20040406153555.06d2f948.ak@suse.de>
In-Reply-To: <20040406153322.5d6e986e.ak@suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add NUMA API system calls for i386

diff -u linux-2.6.5-numa/arch/i386/kernel/entry.S-o linux-2.6.5-numa/arch/i386/kernel/entry.S
--- linux-2.6.5-numa/arch/i386/kernel/entry.S-o	1970-01-01 01:12:51.000000000 +0100
+++ linux-2.6.5-numa/arch/i386/kernel/entry.S	2004-04-06 15:06:46.000000000 +0200
@@ -882,5 +882,8 @@
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
-
+	.long sys_mbind
+	.long sys_get_mempolicy
+	.long sys_set_mempolicy
+	
 syscall_table_size=(.-sys_call_table)
diff -u linux-2.6.5-numa/include/asm-i386/unistd.h-o linux-2.6.5-numa/include/asm-i386/unistd.h
--- linux-2.6.5-numa/include/asm-i386/unistd.h-o	2004-04-06 13:12:19.000000000 +0200
+++ linux-2.6.5-numa/include/asm-i386/unistd.h	2004-04-06 15:07:21.000000000 +0200
@@ -279,8 +279,11 @@
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
 #define __NR_vserver		273
+#define __NR_mbind		273
+#define __NR_get_mempolicy	274
+#define __NR_set_mempolicy	275
 
-#define NR_syscalls 274
+#define NR_syscalls 275
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
