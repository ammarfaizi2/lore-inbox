Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266413AbUBQS0Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 13:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266414AbUBQS0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 13:26:24 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6343 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266413AbUBQS0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 13:26:22 -0500
Date: Tue, 17 Feb 2004 19:26:15 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.3-rc3-mm1: fix Pentium M patch
Message-ID: <20040217182615.GO1308@fs.tum.de>
References: <20040216015823.2dafabb4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216015823.2dafabb4.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 01:58:23AM -0800, Andrew Morton wrote:
>...
> - Dropped the x86 CPU-type selection patches
>...
> Changes since 2.6.3-rc2-mm1:
>...
> -better-i386-cpu-selection.patch
> -cpu-options-default-to-y.patch
> -i386-default-to-n.patch
> 
>  Dropped
>...

This patch wasn't accepted when I sent the first versions against 2.5, 
and now it's too late for 2.6...

Well, that's life. I understand your reasons and I'll resubmit it for 
2.7 .

Removing the cpu selection patch uncovers a bug in my Pentium M I 
already wanted to get a brown paperbag for.

Besides this, it seems a small part of the cpu selection patch was 
actually in pentium-m-support.

The patch below resolves these two issues.

Please apply
Adrian

--- linux-2.6.3-rc3-mm1/arch/i386/Kconfig.old	2004-02-17 19:22:53.000000000 +0100
+++ linux-2.6.3-rc3-mm1/arch/i386/Kconfig	2004-02-17 19:23:28.000000000 +0100
@@ -348,8 +348,8 @@
 	int
 	default "7" if MPENTIUM4 || X86_GENERIC
 	default "4" if X86_ELAN || M486 || M386
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
-	default "6" if MK7 || MK8
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
+	default "6" if MK7 || MK8 || MPENTIUMM
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
--- linux-2.6.3-rc3-mm1/include/asm-i386/module.h.old	2004-02-17 19:24:18.000000000 +0100
+++ linux-2.6.3-rc3-mm1/include/asm-i386/module.h	2004-02-17 19:24:42.000000000 +0100
@@ -51,7 +51,7 @@
 #elif defined CONFIG_MVIAC3_2
 #define MODULE_PROC_FAMILY "VIAC3-2 "
 #else
-#define MODULE_PROC_FAMILY "this needs to be fixed"
+#error unknown processor family
 #endif
 
 #ifdef CONFIG_REGPARM


