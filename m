Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUIWUTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUIWUTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUIWUSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:18:22 -0400
Received: from baikonur.stro.at ([213.239.196.228]:62683 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S264991AbUIWUSB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:18:01 -0400
Subject: [patch 3/3]  remove old ifdefs fasttimer
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:18:02 +0200
Message-ID: <E1CAa2U-00070C-IS@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 Patches to remove some old ifdefs.
 remove most of the #include <linux/version.h>
 kill compat cruft like #define ahd_pci_set_dma_mask pci_set_dma_mask

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/arch/cris/arch-v10/kernel/fasttimer.c |   31 ----------
 1 files changed, 2 insertions(+), 29 deletions(-)

diff -puN arch/cris/arch-v10/kernel/fasttimer.c~remove-old-ifdefs-fasttimer arch/cris/arch-v10/kernel/fasttimer.c
--- linux-2.6.9-rc2-bk7/arch/cris/arch-v10/kernel/fasttimer.c~remove-old-ifdefs-fasttimer	2004-09-21 20:46:58.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/arch/cris/arch-v10/kernel/fasttimer.c	2004-09-21 20:46:58.000000000 +0200
@@ -102,7 +102,6 @@
 #include <asm/rtc.h>
 
 #include <linux/config.h>
-#include <linux/version.h>
 
 #include <asm/arch/svinto.h>
 #include <asm/fasttimer.h>
@@ -599,23 +598,8 @@ void schedule_usleep(unsigned long us)
 
 #ifdef CONFIG_PROC_FS
 static int proc_fasttimer_read(char *buf, char **start, off_t offset, int len
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-                       ,int *eof, void *data_unused
-#else
-                        ,int unused
-#endif
-                               );
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
+			,int *eof, void *data_unused);
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
@@ -624,12 +608,7 @@ static struct proc_dir_entry fasttimer_p
 #define BIG_BUF_SIZE (500 + NUM_TIMER_STATS * 300)
 
 static int proc_fasttimer_read(char *buf, char **start, off_t offset, int len
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-                       ,int *eof, void *data_unused
-#else
-                        ,int unused
-#endif
-                               )
+			,int *eof, void *data_unused)
 {
   unsigned long flags;
   int i = 0;
@@ -805,9 +784,7 @@ static int proc_fasttimer_read(char *buf
 
   memcpy(buf, bigbuf + offset, len);
   *start = buf;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
   *eof = 1;
-#endif
 
   return len;
 }
@@ -982,12 +959,8 @@ void fast_timer_init(void)
     }
 #endif
 #ifdef CONFIG_PROC_FS
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
    if ((fasttimer_proc_entry = create_proc_entry( "fasttimer", 0, 0 )))
      fasttimer_proc_entry->read_proc = proc_fasttimer_read;
-#else
-    proc_register_dynamic(&proc_root, &fasttimer_proc_entry);
-#endif
 #endif /* PROC_FS */
     if(request_irq(TIMER1_IRQ_NBR, timer1_handler, SA_SHIRQ,
                    "fast timer int", NULL))
_
