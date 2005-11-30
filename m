Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbVK3TGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbVK3TGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbVK3TGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:06:09 -0500
Received: from smtpout.mac.com ([17.250.248.73]:2774 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751523AbVK3TGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:06:08 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <7A8BCD84-DEB2-403A-B46B-CF3430C382F1@mac.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-3-451539330
Cc: LKML Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.6.15-rc3] powerpc: Fix kexec on PPC32
From: Kyle Moffett <mrmacman_g4@mac.com>
Date: Wed, 30 Nov 2005 14:06:01 -0500
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-3-451539330
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

The PPC merge broke CONFIG_KEXEC on PPC32 very slightly.

Signed-off-by: Kyle Moffett <mrmacman_g4@mac.com>

--
NOTE: This is compile and boot tested, but I haven't had time to read  
the kexec docs and start playing with kexec yet, so it may not work  
correctly.


--Apple-Mail-3-451539330
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	x-unix-mode=0644;
	name="kexec.patch.txt"
Content-Disposition: attachment;
	filename=kexec.patch.txt

diff -ru linux-2.6.15-rc3/arch/ppc/kernel/machine_kexec.c linux-2.6.15-rc3-aphrodite1/arch/ppc/kernel/machine_kexec.c
--- linux-2.6.15-rc3/arch/ppc/kernel/machine_kexec.c	2005-11-29 12:57:27.000000000 -0500
+++ linux-2.6.15-rc3-aphrodite1/arch/ppc/kernel/machine_kexec.c	2005-11-29 14:45:48.000000000 -0500
@@ -34,11 +34,13 @@
  */
 note_buf_t crash_notes[NR_CPUS];
 
+#ifndef CONFIG_PPC_MERGE
 void machine_shutdown(void)
 {
 	if (ppc_md.machine_shutdown)
 		ppc_md.machine_shutdown();
 }
+#endif
 
 void machine_crash_shutdown(struct pt_regs *regs)
 {
diff -ru linux-2.6.15-rc3/include/asm-powerpc/machdep.h linux-2.6.15-rc3-aphrodite1/include/asm-powerpc/machdep.h
--- linux-2.6.15-rc3/include/asm-powerpc/machdep.h	2005-11-29 14:49:54.000000000 -0500
+++ linux-2.6.15-rc3-aphrodite1/include/asm-powerpc/machdep.h	2005-11-29 14:52:51.000000000 -0500
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
+#include <linux/kexec.h>
 
 #include <asm/setup.h>
 

--Apple-Mail-3-451539330--
