Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbULKQQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbULKQQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 11:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbULKQQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 11:16:10 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27909 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261957AbULKQQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 11:16:01 -0500
Date: Sat, 11 Dec 2004 17:15:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: bjornw@axis.com, dev-etrax@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] cris: remove kernel 2.0 #ifdef's (fwd)
Message-ID: <20041211161551.GR22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial patch forwarded below still applies against 2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Sat, 7 Feb 2004 21:35:25 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: bjornw@axis.com
Cc: dev-etrax@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] cris: remove kernel 2.0 #ifdef's

The patch below removes some kernel 2.0 #ifdef's from 
arch/cris/arch-v10/kernel/fasttimer.c .

Please apply
Adrian

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

