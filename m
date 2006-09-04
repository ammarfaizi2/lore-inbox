Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWIDWSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWIDWSA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWIDWSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:18:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33039 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965010AbWIDWR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:17:59 -0400
Date: Tue, 5 Sep 2006 00:17:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, gerg@uclinux.org
Subject: [-mm patch] arch/m68knommu/kernel/sys_m68k.c must #include <asm/unistd.h>
Message-ID: <20060904221756.GB9173@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 01:58:18AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm3:
>...
> +provide-kernel_execve-on-all-architectures.patch
>...
>  kernel syscalls cleanup
>...

This patch fixes the following compile error on m68knommu:

<--  snip  -->

...
  CC      arch/m68knommu/kernel/sys_m68k.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/sys_m68k.c:215: error: '__NR_execve' undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/sys_m68k.c:215: error: (Each undeclared identifier is reported only once
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/sys_m68k.c:215: error: for each function it appears in.)
make[2]: *** [arch/m68knommu/kernel/sys_m68k.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/sys_m68k.c.old	2006-09-05 00:16:11.000000000 +0200
+++ linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/sys_m68k.c	2006-09-05 00:16:25.000000000 +0200
@@ -26,6 +26,7 @@
 #include <asm/traps.h>
 #include <asm/ipc.h>
 #include <asm/cacheflush.h>
+#include <asm/unistd.h>
 
 /*
  * sys_pipe() is the normal C calling standard for creating

