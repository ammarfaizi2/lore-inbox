Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUBGUgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 15:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUBGUgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 15:36:47 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34262 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265958AbUBGUfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 15:35:32 -0500
Date: Sat, 7 Feb 2004 21:35:25 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: bjornw@axis.com
Cc: dev-etrax@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] cris: remove kernel 2.0 #ifdef's
Message-ID: <20040207203525.GB7388@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes some kernel 2.0 #ifdef's from 
arch/cris/arch-v10/kernel/fasttimer.c .

Please apply
Adrian

--- linux-2.6.2-mm1/arch/cris/arch-v10/kernel/fasttimer.c.old	2004-02-07 20:17:47.000000000 +0100
+++ linux-2.6.2-mm1/arch/cris/arch-v10/kernel/fasttimer.c	2004-02-07 20:18:42.000000000 +0100
@@ -592,23 +592,8 @@
 
 #ifdef CONFIG_PROC_FS
 static int proc_fasttimer_read(char *buf, char **start, off_t offset, int len
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-                       ,int *eof, void *data_unused
-#else
-                        ,int unused
-#endif
-                               );
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
+                       ,int *eof, void *data_unused);
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
@@ -617,12 +602,7 @@
 #define BIG_BUF_SIZE (500 + NUM_TIMER_STATS * 300)
 
 static int proc_fasttimer_read(char *buf, char **start, off_t offset, int len
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-                       ,int *eof, void *data_unused
-#else
-                        ,int unused
-#endif
-                               )
+                       ,int *eof, void *data_unused)
 {
   unsigned long flags;
   int i = 0;
@@ -798,9 +778,7 @@
 
   memcpy(buf, bigbuf + offset, len);
   *start = buf;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
   *eof = 1;
-#endif
 
   return len;
 }
@@ -975,12 +953,8 @@
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
