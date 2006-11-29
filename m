Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758570AbWK2Dy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758570AbWK2Dy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 22:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758285AbWK2Dy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 22:54:27 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:27878 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1758274AbWK2Dy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 22:54:26 -0500
Date: Tue, 28 Nov 2006 19:54:45 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, linux-arch@vger.kernel.org
Subject: [PATCH] lib functions: always build hweight for loadable modules
Message-Id: <20061128195445.20ada433.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Always build hweight8/16/32/64() functions into the kernel so that
loadable modules may use them.

I didn't remove GENERIC_HWEIGHT since ALPHA_EV67, ia64, and some
variants of UltraSparc(64) provide their own hweight functions.

Fixes config/build problems with NTFS=m and JOYSTICK_ANALOG=m.

Kernel: arch/x86_64/boot/bzImage is ready  (#19)
  Building modules, stage 2.
  MODPOST 94 modules
WARNING: "hweight32" [fs/ntfs/ntfs.ko] undefined!
WARNING: "hweight16" [drivers/input/joystick/analog.ko] undefined!
WARNING: "hweight8" [drivers/input/joystick/analog.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 lib/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-git10.orig/lib/Makefile
+++ linux-2.6.19-rc6-git10/lib/Makefile
@@ -25,7 +25,7 @@ lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += 
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_SEMAPHORE_SLEEPERS) += semaphore-sleepers.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
-lib-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
+obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 obj-$(CONFIG_PLIST) += plist.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o


---
