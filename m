Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVGJUSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVGJUSo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVGJTlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:41:32 -0400
Received: from ns2.suse.de ([195.135.220.15]:25564 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261213AbVGJTfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:23 -0400
Date: Sun, 10 Jul 2005 19:35:10 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: starvik@axis.com
Subject: [PATCH 2/82] remove linux/version.h include from arch/cris
Message-ID: <20050710193510.2.MMDCbI2304.2247.olh@nectarine.suse.de>
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

remove code for obsolete kernel versions

Signed-off-by: Olaf Hering <olh@suse.de>

arch/cris/arch-v10/drivers/pcf8563.c   |    1 -
arch/cris/arch-v10/kernel/fasttimer.c  |    1 -
arch/cris/arch-v32/drivers/nandflash.c |    1 -
arch/cris/arch-v32/drivers/pcf8563.c   |    1 -
arch/cris/arch-v32/kernel/fasttimer.c  |   25 -------------------------
5 files changed, 29 deletions(-)

Index: linux-2.6.13-rc2-mm1/arch/cris/arch-v10/drivers/pcf8563.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/cris/arch-v10/drivers/pcf8563.c
+++ linux-2.6.13-rc2-mm1/arch/cris/arch-v10/drivers/pcf8563.c
@@ -19,7 +19,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/types.h>
Index: linux-2.6.13-rc2-mm1/arch/cris/arch-v10/kernel/fasttimer.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/cris/arch-v10/kernel/fasttimer.c
+++ linux-2.6.13-rc2-mm1/arch/cris/arch-v10/kernel/fasttimer.c
@@ -112,7 +112,6 @@
#include <asm/rtc.h>

#include <linux/config.h>
-#include <linux/version.h>

#include <asm/arch/svinto.h>
#include <asm/fasttimer.h>
Index: linux-2.6.13-rc2-mm1/arch/cris/arch-v32/drivers/pcf8563.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/cris/arch-v32/drivers/pcf8563.c
+++ linux-2.6.13-rc2-mm1/arch/cris/arch-v32/drivers/pcf8563.c
@@ -18,7 +18,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/types.h>
Index: linux-2.6.13-rc2-mm1/arch/cris/arch-v32/drivers/nandflash.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/cris/arch-v32/drivers/nandflash.c
+++ linux-2.6.13-rc2-mm1/arch/cris/arch-v32/drivers/nandflash.c
@@ -14,7 +14,6 @@
*
*/

-#include <linux/version.h>
#include <linux/slab.h>
#include <linux/init.h>
#include <linux/module.h>
Index: linux-2.6.13-rc2-mm1/arch/cris/arch-v32/kernel/fasttimer.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/cris/arch-v32/kernel/fasttimer.c
+++ linux-2.6.13-rc2-mm1/arch/cris/arch-v32/kernel/fasttimer.c
@@ -121,7 +121,6 @@
#include <asm/system.h>

#include <linux/config.h>
-#include <linux/version.h>

#include <asm/arch/hwregs/reg_map.h>
#include <asm/arch/hwregs/reg_rdwr.h>
@@ -604,23 +603,9 @@ void schedule_usleep(unsigned long us)

#ifdef CONFIG_PROC_FS
static int proc_fasttimer_read(char *buf, char **start, off_t offset, int len
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
,int *eof, void *data_unused
-#else
-                        ,int unused
-#endif
);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
static struct proc_dir_entry *fasttimer_proc_entry;
-#else
-static struct proc_dir_entry fasttimer_proc_entry =
-{
-  0, 9, "fasttimer",
-  S_IFREG | S_IRUGO, 1, 0, 0,
-  0, NULL /* ops -- default to array */,
-  &proc_fasttimer_read /* get_info */,
-};
-#endif
#endif /* CONFIG_PROC_FS */

#ifdef CONFIG_PROC_FS
@@ -629,11 +614,7 @@ static struct proc_dir_entry fasttimer_p
#define BIG_BUF_SIZE (500 + NUM_TIMER_STATS * 300)

static int proc_fasttimer_read(char *buf, char **start, off_t offset, int len
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
,int *eof, void *data_unused
-#else
-                        ,int unused
-#endif
)
{
unsigned long flags;
@@ -809,9 +790,7 @@ static int proc_fasttimer_read(char *buf

memcpy(buf, bigbuf + offset, len);
*start = buf;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
*eof = 1;
-#endif

return len;
}
@@ -975,12 +954,8 @@ void fast_timer_init(void)
printk("fast_timer_init()n");

#ifdef CONFIG_PROC_FS
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
if ((fasttimer_proc_entry = create_proc_entry( "fasttimer", 0, 0 )))
fasttimer_proc_entry->read_proc = proc_fasttimer_read;
-#else
-    proc_register_dynamic(&proc_root, &fasttimer_proc_entry);
-#endif
#endif /* PROC_FS */
if(request_irq(TIMER_INTR_VECT, timer_trig_interrupt, SA_INTERRUPT,
"fast timer int", NULL))
