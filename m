Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132021AbRAKPse>; Thu, 11 Jan 2001 10:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132138AbRAKPsY>; Thu, 11 Jan 2001 10:48:24 -0500
Received: from monster.Stanford.EDU ([171.64.38.79]:3332 "EHLO
	monster.stanford.edu") by vger.kernel.org with ESMTP
	id <S132021AbRAKPsP>; Thu, 11 Jan 2001 10:48:15 -0500
Date: Thu, 11 Jan 2001 07:48:11 -0800
From: Peter Blomgren <blomgren@monster.Stanford.EDU>
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.1p2: compile fix (PKMAP_BASE undefined)
Message-ID: <20010111074811.A20412@monster.Stanford.EDU>
Reply-To: blomgren@math.Stanford.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: High Latency R Us
X-OS: Linux 2.2.17-1smp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three one-liners to make 2.4.1p2 compile.

--- linux/fs/proc/kcore.c.orig	Thu Jan 11 07:35:16 2001
+++ linux/fs/proc/kcore.c	Thu Jan 11 07:36:29 2001
@@ -19,7 +19,7 @@
 #include <linux/vmalloc.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
-
+#include <linux/highmem.h>
 
 static int open_kcore(struct inode * inode, struct file * filp)
 {
--- linux/mm/vmalloc.c.orig	Thu Jan 11 07:33:25 2001
+++ linux/mm/vmalloc.c	Thu Jan 11 07:34:22 2001
@@ -10,6 +10,7 @@
 #include <linux/vmalloc.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
+#include <linux/highmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
--- linux/arch/i386/kernel/traps.c.orig	Thu Jan 11 07:38:00 2001
+++ linux/arch/i386/kernel/traps.c	Thu Jan 11 07:38:20 2001
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/highmem.h>
 
 #ifdef CONFIG_MCA
 #include <linux/mca.h>

-- 
\Peter.
"The one who loves the most wins."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
