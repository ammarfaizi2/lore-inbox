Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUIWV2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUIWV2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUIWV06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:26:58 -0400
Received: from baikonur.stro.at ([213.239.196.228]:38069 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267397AbUIWVWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:22:45 -0400
Subject: [patch 3/3]  replace dprintk with pr_debug 	in microcode.c
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 23:22:46 +0200
Message-ID: <E1CAb38-0005vD-A6@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







Hi.

Replaced dprintk with pr_debug from kernel.h
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/arch/i386/kernel/microcode.c |   31 +++++++------------
 1 files changed, 13 insertions(+), 18 deletions(-)

diff -puN arch/i386/kernel/microcode.c~pr_debug-i386_kernel_microcode arch/i386/kernel/microcode.c
--- linux-2.6.9-rc2-bk7/arch/i386/kernel/microcode.c~pr_debug-i386_kernel_microcode	2004-09-21 20:51:35.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/arch/i386/kernel/microcode.c	2004-09-21 20:51:35.000000000 +0200
@@ -69,7 +69,8 @@
  *		Thanks to Stuart Swales for pointing out this bug.
  */
 
-
+//#define DEBUG /* pr_debug */
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
_
