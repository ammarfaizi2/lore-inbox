Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUJLUoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUJLUoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 16:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUJLUoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 16:44:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1797 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S267767AbUJLUo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 16:44:29 -0400
Date: Tue, 12 Oct 2004 20:43:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mike.miller@hp.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: iss_storagedev@hp.com, Cciss-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix block/cciss.c with PROC_FS=n
Message-ID: <20041012184346.GC18579@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the following compile error in both 2.6.9-rc4 and 2.6.9-rc4-mm1 
when compiling with CONFIG_PROC_FS=n:


<--  snip  -->

...
  LD      .tmp_vmlinux1
kernel/built-in.o(.text+0x1d42b): In function `crash_create_proc_entry':
: undefined reference to `proc_vmcore'
drivers/built-in.o(.text+0x234eb8): In function `cciss_init_one':
: undefined reference to `cciss_scsi_setup'
drivers/built-in.o(.text+0x235173): In function `cciss_remove_one':
: undefined reference to `cciss_unregister_scsi'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The patch below fixes this issue.


I don't know whether this might qualify it for 2.6.9:
- it fixes the only CONFIG_PROC_FS=n compile error I found in 2.6.9-rc4
- it has obviously no effect in the CONFIG_PROC_FS=y case


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-rc4-mm1-full/drivers/block/cciss.c.old	2004-10-12 20:36:33.000000000 +0200
+++ linux-2.6.9-rc4-mm1-full/drivers/block/cciss.c	2004-10-12 20:37:16.000000000 +0200
@@ -185,10 +185,11 @@
         }
         return c;
 }
-#ifdef CONFIG_PROC_FS
 
 #include "cciss_scsi.c"		/* For SCSI tape support */
 
+#ifdef CONFIG_PROC_FS
+
 /*
  * Report information about this controller.
  */

