Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWA0WC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWA0WC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWA0WC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:02:59 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:57287 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1030350AbWA0WC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:02:59 -0500
From: Zach Brown <zach.brown@oracle.com>
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Message-Id: <20060127220242.13917.839.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH 1/2] [x86-64] align per-cpu section to configured cache bytes
Date: Fri, 27 Jan 2006 14:02:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[x86-64] align per-cpu section to configured cache bytes

Align the start of the per-cpu section to the configured number of bytes in a
cache line.  This stops a BUG_ON() from triggering in load_module() when
DEFINE_PER_CPU() is used in a module and the section isn't cacheline-aligned.
Rusty also found this and sent a patch in a while ago
(http://lkml.org/lkml/2004/10/19/17), I don't know what came of that.

  Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 arch/x86_64/kernel/vmlinux.lds.S |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6.16-rc1-mm3-per-cpu-alignment/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- 2.6.16-rc1-mm3-per-cpu-alignment.orig/arch/x86_64/kernel/vmlinux.lds.S	2006-01-27 10:19:49.000000000 -0800
+++ 2.6.16-rc1-mm3-per-cpu-alignment/arch/x86_64/kernel/vmlinux.lds.S	2006-01-27 11:41:36.000000000 -0800
@@ -173,7 +173,7 @@
   __initramfs_start = .;
   .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { *(.init.ramfs) }
   __initramfs_end = .;	
-  . = ALIGN(32);
+  . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
   __per_cpu_start = .;
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
   __per_cpu_end = .;
