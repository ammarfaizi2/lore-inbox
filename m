Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbWA0WDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWA0WDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWA0WDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:03:04 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:58823 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1030351AbWA0WDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:03:03 -0500
From: Zach Brown <zach.brown@oracle.com>
To: Sam Ravnborg <sam@ravnborg.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Message-Id: <20060127220247.13917.8544.sendpatchset@tetsuo.zabbo.net>
In-Reply-To: <20060127220242.13917.839.sendpatchset@tetsuo.zabbo.net>
References: <20060127220242.13917.839.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH 2/2] [x86] align per-cpu section to configured cache bytes
Date: Fri, 27 Jan 2006 14:02:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[x86] align per-cpu section to configured cache bytes

This matches the fix for a bug seen on x86-64.  Test booted on old hardware
that had 32 byte cachelines to begin with.

  Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 arch/i386/kernel/vmlinux.lds.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: 2.6.16-rc1-per-cpu-align/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- 2.6.16-rc1-per-cpu-align.orig/arch/i386/kernel/vmlinux.lds.S	2006-01-27 13:21:34.000000000 -0800
+++ 2.6.16-rc1-per-cpu-align/arch/i386/kernel/vmlinux.lds.S	2006-01-27 13:32:55.000000000 -0800
@@ -7,6 +7,7 @@
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
+#include <asm/cache.h>
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
@@ -115,7 +116,7 @@
   __initramfs_start = .;
   .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { *(.init.ramfs) }
   __initramfs_end = .;
-  . = ALIGN(32);
+  . = ALIGN(L1_CACHE_BYTES);
   __per_cpu_start = .;
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
   __per_cpu_end = .;
