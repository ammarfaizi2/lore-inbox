Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275734AbRJYRZH>; Thu, 25 Oct 2001 13:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275778AbRJYRYx>; Thu, 25 Oct 2001 13:24:53 -0400
Received: from ns.caldera.de ([212.34.180.1]:30667 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S275734AbRJYRYe>;
	Thu, 25 Oct 2001 13:24:34 -0400
Date: Thu, 25 Oct 2001 19:24:57 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]
Message-ID: <20011025192457.C10880@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the appended patch adds four exports needed for Linux-ABI:

 o do_fork & do_pipe because the emulated SysV syscalls call
   these directly.
 o the other two are needed by emulated syscongig() support.

Please apply,

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -Xdontdiff ../master/linux-2.4.14-pre1/kernel/ksyms.c linux-2.4.14-pre1/kernel/ksyms.c
--- ../master/linux-2.4.14-pre1/kernel/ksyms.c	Thu Oct 25 19:05:49 2001
+++ linux-2.4.14-pre1/kernel/ksyms.c	Thu Oct 25 19:16:47 2001
@@ -60,6 +60,7 @@
 extern void *sys_call_table;
 
 extern struct timezone sys_tz;
+extern int max_threads;
 extern int request_dma(unsigned int dmanr, char * deviceID);
 extern void free_dma(unsigned int dmanr);
 extern spinlock_t dma_spin_lock;
@@ -550,3 +551,11 @@
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
+
+/* for Linux-ABI */
+EXPORT_SYMBOL(do_fork);
+EXPORT_SYMBOL(do_pipe);
+
+/* sysconfig support */
+EXPORT_SYMBOL(nr_free_pages);
+EXPORT_SYMBOL(max_threads);
