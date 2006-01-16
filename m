Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWAPJW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWAPJW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWAPJWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:22:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22763 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932263AbWAPJWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:22:12 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 17/25] Fix compilation with Alpha
Date: Mon, 16 Jan 2006 07:11:23 -0200
Message-id: <20060116091123.PS74256200017@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

- BOOT_SIZE name is also used at alpha and were breaking
compiling with allyesconfig.
- All BOOT_* renamed to AV7110_BOOT* to fix and keep names
with the same style.
Thanks to Andrew Morton for pointing this.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/ttpci/av7110_hw.c |   40 ++++++++++++++++++-----------------
 drivers/media/dvb/ttpci/av7110_hw.h |   12 +++++------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/media/dvb/ttpci/av7110_hw.c b/drivers/media/dvb/ttpci/av7110_hw.c
index cb37745..b2e63e9 100644
--- a/drivers/media/dvb/ttpci/av7110_hw.c
+++ b/drivers/media/dvb/ttpci/av7110_hw.c
@@ -146,52 +146,52 @@ static int load_dram(struct av7110 *av71
 {
 	int i;
 	int blocks, rest;
-	u32 base, bootblock = BOOT_BLOCK;
+	u32 base, bootblock = AV7110_BOOT_BLOCK;
 
 	dprintk(4, "%p\n", av7110);
 
-	blocks = len / BOOT_MAX_SIZE;
-	rest = len % BOOT_MAX_SIZE;
+	blocks = len / AV7110_BOOT_MAX_SIZE;
+	rest = len % AV7110_BOOT_MAX_SIZE;
 	base = DRAM_START_CODE;
 
 	for (i = 0; i < blocks; i++) {
-		if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0) {
+		if (waitdebi(av7110, AV7110_BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0) {
 			printk(KERN_ERR "dvb-ttpci: load_dram(): timeout at block %d\n", i);
 			return -ETIMEDOUT;
 		}
 		dprintk(4, "writing DRAM block %d\n", i);
 		mwdebi(av7110, DEBISWAB, bootblock,
-		       ((char*)data) + i * BOOT_MAX_SIZE, BOOT_MAX_SIZE);
+		       ((char*)data) + i * AV7110_BOOT_MAX_SIZE, AV7110_BOOT_MAX_SIZE);
 		bootblock ^= 0x1400;
-		iwdebi(av7110, DEBISWAB, BOOT_BASE, swab32(base), 4);
-		iwdebi(av7110, DEBINOSWAP, BOOT_SIZE, BOOT_MAX_SIZE, 2);
-		iwdebi(av7110, DEBINOSWAP, BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
-		base += BOOT_MAX_SIZE;
+		iwdebi(av7110, DEBISWAB, AV7110_BOOT_BASE, swab32(base), 4);
+		iwdebi(av7110, DEBINOSWAP, AV7110_BOOT_SIZE, AV7110_BOOT_MAX_SIZE, 2);
+		iwdebi(av7110, DEBINOSWAP, AV7110_BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
+		base += AV7110_BOOT_MAX_SIZE;
 	}
 
 	if (rest > 0) {
-		if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0) {
+		if (waitdebi(av7110, AV7110_BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0) {
 			printk(KERN_ERR "dvb-ttpci: load_dram(): timeout at last block\n");
 			return -ETIMEDOUT;
 		}
 		if (rest > 4)
 			mwdebi(av7110, DEBISWAB, bootblock,
-			       ((char*)data) + i * BOOT_MAX_SIZE, rest);
+			       ((char*)data) + i * AV7110_BOOT_MAX_SIZE, rest);
 		else
 			mwdebi(av7110, DEBISWAB, bootblock,
-			       ((char*)data) + i * BOOT_MAX_SIZE - 4, rest + 4);
+			       ((char*)data) + i * AV7110_BOOT_MAX_SIZE - 4, rest + 4);
 
-		iwdebi(av7110, DEBISWAB, BOOT_BASE, swab32(base), 4);
-		iwdebi(av7110, DEBINOSWAP, BOOT_SIZE, rest, 2);
-		iwdebi(av7110, DEBINOSWAP, BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
+		iwdebi(av7110, DEBISWAB, AV7110_BOOT_BASE, swab32(base), 4);
+		iwdebi(av7110, DEBINOSWAP, AV7110_BOOT_SIZE, rest, 2);
+		iwdebi(av7110, DEBINOSWAP, AV7110_BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
 	}
-	if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0) {
+	if (waitdebi(av7110, AV7110_BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0) {
 		printk(KERN_ERR "dvb-ttpci: load_dram(): timeout after last block\n");
 		return -ETIMEDOUT;
 	}
-	iwdebi(av7110, DEBINOSWAP, BOOT_SIZE, 0, 2);
-	iwdebi(av7110, DEBINOSWAP, BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
-	if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BOOT_COMPLETE) < 0) {
+	iwdebi(av7110, DEBINOSWAP, AV7110_BOOT_SIZE, 0, 2);
+	iwdebi(av7110, DEBINOSWAP, AV7110_BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
+	if (waitdebi(av7110, AV7110_BOOT_STATE, BOOTSTATE_AV7110_BOOT_COMPLETE) < 0) {
 		printk(KERN_ERR "dvb-ttpci: load_dram(): final handshake timeout\n");
 		return -ETIMEDOUT;
 	}
@@ -262,7 +262,7 @@ int av7110_bootarm(struct av7110 *av7110
 	//saa7146_setgpio(dev, 3, SAA7146_GPIO_INPUT);
 
 	mwdebi(av7110, DEBISWAB, DPRAM_BASE, bootcode, sizeof(bootcode));
-	iwdebi(av7110, DEBINOSWAP, BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
+	iwdebi(av7110, DEBINOSWAP, AV7110_BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
 
 	if (saa7146_wait_for_debi_done(av7110->dev, 1)) {
 		printk(KERN_ERR "dvb-ttpci: av7110_bootarm(): "
diff --git a/drivers/media/dvb/ttpci/av7110_hw.h b/drivers/media/dvb/ttpci/av7110_hw.h
index 84b8329..4e173c6 100644
--- a/drivers/media/dvb/ttpci/av7110_hw.h
+++ b/drivers/media/dvb/ttpci/av7110_hw.h
@@ -18,7 +18,7 @@ enum av7110_bootstate
 {
 	BOOTSTATE_BUFFER_EMPTY	= 0,
 	BOOTSTATE_BUFFER_FULL	= 1,
-	BOOTSTATE_BOOT_COMPLETE	= 2
+	BOOTSTATE_AV7110_BOOT_COMPLETE	= 2
 };
 
 enum av7110_type_rec_play_format
@@ -295,11 +295,11 @@ enum av7110_command_type {
 #define	DPRAM_BASE 0x4000
 
 /* boot protocol area */
-#define BOOT_STATE	(DPRAM_BASE + 0x3F8)
-#define BOOT_SIZE	(DPRAM_BASE + 0x3FA)
-#define BOOT_BASE	(DPRAM_BASE + 0x3FC)
-#define BOOT_BLOCK	(DPRAM_BASE + 0x400)
-#define BOOT_MAX_SIZE	0xc00
+#define AV7110_BOOT_STATE	(DPRAM_BASE + 0x3F8)
+#define AV7110_BOOT_SIZE	(DPRAM_BASE + 0x3FA)
+#define AV7110_BOOT_BASE	(DPRAM_BASE + 0x3FC)
+#define AV7110_BOOT_BLOCK	(DPRAM_BASE + 0x400)
+#define AV7110_BOOT_MAX_SIZE	0xc00
 
 /* firmware command protocol area */
 #define IRQ_STATE	(DPRAM_BASE + 0x0F4)

