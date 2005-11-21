Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVKUCEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVKUCEI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 21:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVKUCEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 21:04:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57105 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932173AbVKUCEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 21:04:05 -0500
Date: Mon, 21 Nov 2005 03:04:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: tigran@veritas.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] arch/i386/kernel/microcode.c: remove the obsolete microcode_ioctl
Message-ID: <20051121020404.GV16060@stusta.de>
References: <20051120233116.GN16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120233116.GN16060@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ grmbl, wrong version of the patch sent... ]

Nowadays, even Debian stable ships a microcode_ctl utility recent enough 
to no longer use this ioctl.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/ioctl-mess.txt   |    4 ----
 Documentation/ioctl-number.txt |    2 --
 arch/i386/kernel/microcode.c   |   17 -----------------
 include/asm-i386/processor.h   |    2 --
 include/asm-x86_64/processor.h |    3 ---
 5 files changed, 28 deletions(-)

--- linux-2.6.15-rc1-mm2-full/arch/i386/kernel/microcode.c.old	2005-11-20 21:30:59.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/arch/i386/kernel/microcode.c	2005-11-20 21:31:24.000000000 +0100
@@ -457,26 +457,9 @@
 	return ret;
 }
 
-static int microcode_ioctl (struct inode *inode, struct file *file, 
-		unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-		/* 
-		 *  XXX: will be removed after microcode_ctl 
-		 *  is updated to ignore failure of this ioctl()
-		 */
-		case MICROCODE_IOCFREE:
-			return 0;
-		default:
-			return -EINVAL;
-	}
-	return -EINVAL;
-}
-
 static struct file_operations microcode_fops = {
 	.owner		= THIS_MODULE,
 	.write		= microcode_write,
-	.ioctl		= microcode_ioctl,
 	.open		= microcode_open,
 };
 
--- linux-2.6.15-rc1-mm2-full/Documentation/ioctl-mess.txt.old	2005-11-21 00:38:33.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/Documentation/ioctl-mess.txt	2005-11-21 00:38:44.000000000 +0100
@@ -2599,10 +2599,6 @@
 I: (int) arg
 O: -
 
-N: MICROCODE_IOCFREE
-I: -
-O: -
-
 N: MMTIMER_GETBITS
 I: -
 O: -
--- linux-2.6.15-rc1-mm2-full/Documentation/ioctl-number.txt.old	2005-11-21 00:39:05.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/Documentation/ioctl-number.txt	2005-11-21 00:39:28.000000000 +0100
@@ -78,8 +78,6 @@
 '#'	00-3F	IEEE 1394 Subsystem	Block for the entire subsystem
 '1'	00-1F	<linux/timepps.h>	PPS kit from Ulrich Windl
 					<ftp://ftp.de.kernel.org/pub/linux/daemons/ntp/PPS/>
-'6'	00-10	<asm-i386/processor.h>	Intel IA32 microcode update driver
-					<mailto:tigran@veritas.com>
 '8'	all				SNP8023 advanced NIC card
 					<mailto:mcr@solidum.com>
 'A'	00-1F	linux/apm_bios.h
--- linux-2.6.15-rc1-mm2-full/include/asm-i386/processor.h.old	2005-11-21 00:39:41.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/asm-i386/processor.h	2005-11-21 00:40:33.000000000 +0100
@@ -602,8 +602,6 @@
 	unsigned int reserved[3];
 	struct extended_signature sigs[0];
 };
-/* '6' because it used to be for P6 only (but now covers Pentium 4 as well) */
-#define MICROCODE_IOCFREE	_IO('6',0)
 
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
 static inline void rep_nop(void)
--- linux-2.6.15-rc1-mm2-full/include/asm-x86_64/processor.h.old	2005-11-21 00:40:37.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/asm-x86_64/processor.h	2005-11-21 00:40:42.000000000 +0100
@@ -357,9 +357,6 @@
 	struct extended_signature sigs[0];
 };
 
-/* '6' because it used to be for P6 only (but now covers Pentium 4 as well) */
-#define MICROCODE_IOCFREE	_IO('6',0)
-
 
 #define ASM_NOP1 K8_NOP1
 #define ASM_NOP2 K8_NOP2

