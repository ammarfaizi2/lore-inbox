Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269189AbUJQQMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269189AbUJQQMT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269182AbUJQQLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:11:15 -0400
Received: from vsmtp1.tin.it ([212.216.176.141]:54223 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S269181AbUJQQJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:09:11 -0400
Subject: [PATCH 3/8] replacing/fixing printk with pr_debug/pr_info in
	arch/i386 - microcode.c
From: Daniele Pizzoni <auouo@tin.it>
To: kernel-janitors <kernel-janitors@lists.osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1098032565.3023.122.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 19:10:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom macro dprintk with pr_debug from kernel.h.

Signed-off-by: Daniele Pizzoni <auouo@tin.it>

Index: linux-2.6.9-rc4/arch/i386/kernel/microcode.c
===================================================================
--- linux-2.6.9-rc4.orig/arch/i386/kernel/microcode.c	2004-10-17 16:57:00.402604736 +0200
+++ linux-2.6.9-rc4/arch/i386/kernel/microcode.c	2004-10-17 17:01:15.561814640 +0200
@@ -70,6 +70,7 @@
  */
 
 
+#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/module.h>
@@ -88,12 +89,6 @@ MODULE_AUTHOR("Tigran Aivazian <tigran@v
 MODULE_LICENSE("GPL");
 
 #define MICROCODE_VERSION 	"1.14"
-#define MICRO_DEBUG 		0
-#if MICRO_DEBUG
-#define dprintk(x...) printk(KERN_INFO x)
-#else
-#define dprintk(x...)
-#endif
 
 #define DEFAULT_UCODE_DATASIZE 	(2000) 	  /* 2000 bytes */
 #define MC_HEADER_SIZE		(sizeof (microcode_header_t))  	  /* 48 bytes */
@@ -172,7 +167,7 @@ static void collect_cpu_info (void *unus
 	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
 	/* get the current revision from MSR 0x8B */
 	rdmsr(MSR_IA32_UCODE_REV, val[0], uci->rev);
-	dprintk("microcode: collect_cpu_info : sig=0x%x, pf=0x%x, rev=0x%x\n", 
+	pr_debug("microcode: collect_cpu_info : sig=0x%x, pf=0x%x, rev=0x%x\n", 
 			uci->sig, uci->pf, uci->rev);
 }
 
@@ -180,22 +175,22 @@ static inline void mark_microcode_update
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
 
-	dprintk("Microcode Found.\n");
-	dprintk("   Header Revision 0x%x\n", mc_header->hdrver);
-	dprintk("   Loader Revision 0x%x\n", mc_header->ldrver);
-	dprintk("   Revision 0x%x \n", mc_header->rev);
-	dprintk("   Date %x/%x/%x\n",
+	pr_debug("Microcode Found.\n");
+	pr_debug("   Header Revision 0x%x\n", mc_header->hdrver);
+	pr_debug("   Loader Revision 0x%x\n", mc_header->ldrver);
+	pr_debug("   Revision 0x%x \n", mc_header->rev);
+	pr_debug("   Date %x/%x/%x\n",
 		((mc_header->date >> 24 ) & 0xff),
 		((mc_header->date >> 16 ) & 0xff),
 		(mc_header->date & 0xFFFF));
-	dprintk("   Signature 0x%x\n", sig);
-	dprintk("   Type 0x%x Family 0x%x Model 0x%x Stepping 0x%x\n",
+	pr_debug("   Signature 0x%x\n", sig);
+	pr_debug("   Type 0x%x Family 0x%x Model 0x%x Stepping 0x%x\n",
 		((sig >> 12) & 0x3),
 		((sig >> 8) & 0xf),
 		((sig >> 4) & 0xf),
 		((sig & 0xf)));
-	dprintk("   Processor Flags 0x%x\n", pf);
-	dprintk("   Checksum 0x%x\n", cksum);
+	pr_debug("   Processor Flags 0x%x\n", pf);
+	pr_debug("   Checksum 0x%x\n", cksum);
 
 	if (mc_header->rev < uci->rev) {
 		printk(KERN_ERR "microcode: CPU%d not 'upgrading' to earlier revision"
@@ -209,7 +204,7 @@ static inline void mark_microcode_update
 		goto out;
 	}
 
-	dprintk("microcode: CPU%d found a matching microcode update with "
+	pr_debug("microcode: CPU%d found a matching microcode update with "
 		" revision 0x%x (current=0x%x)\n", cpu_num, mc_header->rev, uci->rev);
 	uci->cksum = cksum;
 	uci->pf = pf; /* keep the original mc pf for cksum calculation */


