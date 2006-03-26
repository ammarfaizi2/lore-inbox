Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWCZMZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWCZMZv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWCZMZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:25:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63236 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751301AbWCZMZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:25:45 -0500
Date: Sun, 26 Mar 2006 14:25:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] BLK_DEV_IO_TRACE Kconfig fixes
Message-ID: <20060326122540.GL4053@stusta.de>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323014046.2ca1d9df.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 01:40:46AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc6-mm2:
>...
>  git-blktrace.patch
>...
>  git trees.
>...

BLK_DEV_IO_TRACE breaks the rule "If you select something, you must 
endure that the dependencies of what you are select'ing are fulfilled."
resulting in the following compile error with CONFIG_SYSFS=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
fs/built-in.o: In function `debugfs_init':inode.c:(.init.text+0x3d35): 
undefined reference to `kernel_subsys'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

This patch fixes this bug.

Additionally, it moves the BLK_DEV_IO_TRACE option that now depends on 
DEBUG_KERNEL into the menu with the other DEBUG_KERNEL options.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 block/Kconfig     |   12 ------------
 lib/Kconfig.debug |   13 +++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

--- linux-2.6.16-mm1-full/block/Kconfig.old	2006-03-26 01:49:51.000000000 +0100
+++ linux-2.6.16-mm1-full/block/Kconfig	2006-03-26 01:55:28.000000000 +0100
@@ -11,18 +11,6 @@
 	  your machine, or if you want to have a raid or loopback device
 	  bigger than 2TB.  Otherwise say N.
 
-config BLK_DEV_IO_TRACE
-	bool "Support for tracing block io actions"
-	select RELAY
-	select DEBUG_FS
-	help
-	  Say Y here, if you want to be able to trace the block layer actions
-	  on a given queue. Tracing allows you to see any traffic happening
-	  on a block device queue. For more information (and the user space
-	  support tools needed), fetch the blktrace app from:
-
-	  git://brick.kernel.dk/data/git/blktrace.git
-
 config LSF
 	bool "Support for Large Single Files"
 	depends on X86 || (MIPS && 32BIT) || PPC32 || ARCH_S390_31 || SUPERH || UML
--- linux-2.6.16-mm1-full/lib/Kconfig.debug.old	2006-03-26 01:51:40.000000000 +0100
+++ linux-2.6.16-mm1-full/lib/Kconfig.debug	2006-03-26 01:55:42.000000000 +0100
@@ -213,6 +213,19 @@
 
 	  If unsure, say N.
 
+config BLK_DEV_IO_TRACE
+	bool "Support for tracing block io actions"
+	depends on DEBUG_KERNEL && SYSFS
+	select RELAY
+	select DEBUG_FS
+	help
+	  Say Y here, if you want to be able to trace the block layer actions
+	  on a given queue. Tracing allows you to see any traffic happening
+	  on a block device queue. For more information (and the user space
+	  support tools needed), fetch the blktrace app from:
+
+	  git://brick.kernel.dk/data/git/blktrace.git
+
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && (X86 || CRIS || M68K || M68KNOMMU || FRV || UML)

