Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVLUB1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVLUB1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 20:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVLUB1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 20:27:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15121 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932232AbVLUB1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 20:27:51 -0500
Date: Wed, 21 Dec 2005 02:27:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, uclinux-v850@lsi.nec.co.j
Subject: [RFC: 2.6 patch] include/linux/irq.h: #include <linux/smp.h>
Message-ID: <20051221012750.GD5359@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan's crosscompile page [1] shows, that one regression in 2.6.15-rc is 
that the v850 defconfig does no longer compile.

The compile error is:

<--  snip  -->

...
  CC      arch/v850/kernel/setup.o
In file included from /usr/src/ctest/rc/kernel/arch/v850/kernel/setup.c:17:
/usr/src/ctest/rc/kernel/include/linux/irq.h:13:43: asm/smp.h: No such file or directory
make[2]: *** [arch/v850/kernel/setup.o] Error 1

<--  snip  -->


The #include <asm/smp.h> in irq.h was intruduced in 2.6.15-rc.

Since include/linux/irq.h needs code from asm/smp.h only in the 
CONFIG_SMP=y case and linux/smp.h #include's asm/smp.h only in the
CONFIG_SMP=y case, I'm suggesting this patch to #include <linux/smp.h>
in irq.h.

I've tested the compilation with both CONFIG_SMP=y and CONFIG_SMP=n
on i386.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc6/include/linux/irq.h.old	2005-12-20 21:45:57.000000000 +0100
+++ linux-2.6.15-rc6/include/linux/irq.h	2005-12-20 21:46:08.000000000 +0100
@@ -10,7 +10,7 @@
  */
 
 #include <linux/config.h>
-#include <asm/smp.h>		/* cpu_online_map */
+#include <linux/smp.h>
 
 #if !defined(CONFIG_ARCH_S390)
 


