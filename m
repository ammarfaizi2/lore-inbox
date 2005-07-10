Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVGKAMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVGKAMl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVGKAKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:10:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:56466 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261198AbVGJTfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:16 -0400
Date: Sun, 10 Jul 2005 19:35:15 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linuxppc64-dev@ozlabs.org
Subject: [PATCH 7/82] remove linux/version.h include from arch/ppc64
Message-ID: <20050710193515.7.NnOUBt2443.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

use system_utsname for progress and debug header


Signed-off-by: Olaf Hering <olh@suse.de>

arch/ppc64/kernel/btext.c         |    1 -
arch/ppc64/kernel/pSeries_setup.c |    4 ++--
arch/ppc64/kernel/prom.c          |    1 -
arch/ppc64/kernel/prom_init.c     |    1 -
arch/ppc64/kernel/setup.c         |    4 ++--
arch/ppc64/kernel/vio.c           |    1 -
6 files changed, 4 insertions(+), 8 deletions(-)

Index: linux-2.6.13-rc2-mm1/arch/ppc64/kernel/btext.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ppc64/kernel/btext.c
+++ linux-2.6.13-rc2-mm1/arch/ppc64/kernel/btext.c
@@ -7,7 +7,6 @@
#include <linux/kernel.h>
#include <linux/string.h>
#include <linux/init.h>
-#include <linux/version.h>

#include <asm/sections.h>
#include <asm/prom.h>
Index: linux-2.6.13-rc2-mm1/arch/ppc64/kernel/pSeries_setup.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ppc64/kernel/pSeries_setup.c
+++ linux-2.6.13-rc2-mm1/arch/ppc64/kernel/pSeries_setup.c
@@ -37,7 +37,7 @@
#include <linux/ioport.h>
#include <linux/console.h>
#include <linux/pci.h>
-#include <linux/version.h>
+#include <linux/utsname.h>
#include <linux/adb.h>
#include <linux/module.h>
#include <linux/delay.h>
@@ -253,7 +253,7 @@ static int __init pSeries_init_panel(voi
{
/* Manually leave the kernel version on the panel. */
ppc_md.progress("Linux ppc64n", 0);
-	ppc_md.progress(UTS_RELEASE, 0);
+	ppc_md.progress(system_utsname.version, 0);

return 0;
}
Index: linux-2.6.13-rc2-mm1/arch/ppc64/kernel/prom.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ppc64/kernel/prom.c
+++ linux-2.6.13-rc2-mm1/arch/ppc64/kernel/prom.c
@@ -22,7 +22,6 @@
#include <linux/kernel.h>
#include <linux/string.h>
#include <linux/init.h>
-#include <linux/version.h>
#include <linux/threads.h>
#include <linux/spinlock.h>
#include <linux/types.h>
Index: linux-2.6.13-rc2-mm1/arch/ppc64/kernel/prom_init.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ppc64/kernel/prom_init.c
+++ linux-2.6.13-rc2-mm1/arch/ppc64/kernel/prom_init.c
@@ -22,7 +22,6 @@
#include <linux/kernel.h>
#include <linux/string.h>
#include <linux/init.h>
-#include <linux/version.h>
#include <linux/threads.h>
#include <linux/spinlock.h>
#include <linux/types.h>
Index: linux-2.6.13-rc2-mm1/arch/ppc64/kernel/setup.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ppc64/kernel/setup.c
+++ linux-2.6.13-rc2-mm1/arch/ppc64/kernel/setup.c
@@ -25,7 +25,7 @@
#include <linux/seq_file.h>
#include <linux/ioport.h>
#include <linux/console.h>
-#include <linux/version.h>
+#include <linux/utsname.h>
#include <linux/tty.h>
#include <linux/root_dev.h>
#include <linux/notifier.h>
@@ -653,7 +653,7 @@ void __init setup_system(void)
smp_release_cpus();
#endif /* defined(CONFIG_SMP) && !defined(CONFIG_PPC_ISERIES) */

-	printk("Starting Linux PPC64 %sn", UTS_RELEASE);
+	printk("Starting Linux PPC64 %sn", system_utsname.version);

printk("-----------------------------------------------------n");
printk("ppc64_pft_size                = 0x%lxn", ppc64_pft_size);
Index: linux-2.6.13-rc2-mm1/arch/ppc64/kernel/vio.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ppc64/kernel/vio.c
+++ linux-2.6.13-rc2-mm1/arch/ppc64/kernel/vio.c
@@ -14,7 +14,6 @@

#include <linux/init.h>
#include <linux/console.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kobject.h>
#include <linux/mm.h>
