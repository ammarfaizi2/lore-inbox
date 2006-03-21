Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbWCUQVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWCUQVP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWCUQVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:14 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:26636 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932415AbWCUQVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:10 -0500
Cc: Zach Brown <zach.brown@oracle.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 06/46] x86: align per-cpu section to configured cache bytes
In-Reply-To: <1142958054501-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:54 +0100
Message-Id: <114295805457-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This matches the fix for a bug seen on x86-64.  Test booted on old hardware
that had 32 byte cachelines to begin with.

Signed-off-by: Zach Brown <zach.brown@oracle.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/i386/kernel/vmlinux.lds.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

379b5441aeb895fe55b877a8a9c187e8728f774c
diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index 4710195..18f99cc 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -7,6 +7,7 @@
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
+#include <asm/cache.h>
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
@@ -115,7 +116,7 @@ SECTIONS
   __initramfs_start = .;
   .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { *(.init.ramfs) }
   __initramfs_end = .;
-  . = ALIGN(32);
+  . = ALIGN(L1_CACHE_BYTES);
   __per_cpu_start = .;
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
   __per_cpu_end = .;
-- 
1.0.GIT


