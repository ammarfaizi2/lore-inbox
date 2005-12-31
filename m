Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbVLaW2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbVLaW2f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 17:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbVLaW2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 17:28:35 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:64650 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965063AbVLaW2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 17:28:33 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 31 Dec 2005 23:27:59 +0100
In-reply-to: <200512319343.965475189bla@anxur.fi.muni.cz>
Subject: [PATCH 3/4] media-video: Stradis Lindent
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, laredo@gnu.org,
       mchehab@brturbo.com.br, video4linux-list@redhat.com
Message-Id: <20051231222757.7F44F22AEE7@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stradis Lindent
[depends on stradis little changes]

+some handwork

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 213e9a2c513ad1b36ff6b459ca815813318b332b
tree e53fe7b4a4db5d729430157f141966fef44de5ef
parent 6d24424eab688faf0fe3f195f84df783764a6393
author <ku@bellona.(none)> Sat, 31 Dec 2005 23:15:23 +0100
committer <ku@bellona.(none)> Sat, 31 Dec 2005 23:15:23 +0100

 drivers/media/video/stradis.c |  807 ++++++++++++++++++++---------------------
 1 files changed, 391 insertions(+), 416 deletions(-)

diff --git a/drivers/media/video/stradis.c b/drivers/media/video/stradis.c
--- a/drivers/media/video/stradis.c
+++ b/drivers/media/video/stradis.c
@@ -49,9 +49,9 @@
 #include "saa7121.h"
 #include "cs8420.h"
 
-#define DEBUG(x) 		/* debug driver */
-#undef  IDEBUG	 		/* debug irq handler */
-#undef  MDEBUG	 		/* debug memory management */
+#define DEBUG(x)		/* debug driver */
+#undef  IDEBUG			/* debug irq handler */
+#undef  MDEBUG			/* debug memory management */
 
 #define SAA7146_MAX 6
 
@@ -63,7 +63,6 @@ static int video_nr = -1;
 module_param(video_nr, int, 0);
 MODULE_LICENSE("GPL");
 
-
 #define nDebNormal	0x00480000
 #define nDebNoInc	0x00480000
 #define nDebVideo	0xd0480000
@@ -99,7 +98,12 @@ MODULE_LICENSE("GPL");
 
 #ifdef USE_RESCUE_EEPROM_SDM275
 static unsigned char rescue_eeprom[64] = {
-0x00,0x01,0x04,0x13,0x26,0x0f,0x10,0x00,0x00,0x00,0x43,0x63,0x22,0x01,0x29,0x15,0x73,0x00,0x1f, 'd', 'e', 'c', 'x', 'l', 'd', 'v', 'a',0x02,0x00,0x01,0x00,0xcc,0xa4,0x63,0x09,0xe2,0x10,0x00,0x0a,0x00,0x02,0x02, 'd', 'e', 'c', 'x', 'l', 'a',0x00,0x00,0x42,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+	0x00, 0x01, 0x04, 0x13, 0x26, 0x0f, 0x10, 0x00, 0x00, 0x00, 0x43, 0x63,
+	0x22, 0x01, 0x29, 0x15, 0x73, 0x00, 0x1f,  'd',  'e',  'c',  'x',  'l',
+	 'd',  'v',  'a', 0x02, 0x00, 0x01, 0x00, 0xcc, 0xa4, 0x63, 0x09, 0xe2,
+	0x10, 0x00, 0x0a, 0x00, 0x02, 0x02,  'd',  'e',  'c',  'x',  'l',  'a',
+	0x00, 0x00, 0x42, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
 };
 #endif
 
@@ -140,17 +144,18 @@ static int I2CRead(struct saa7146 *saa, 
 
 	if (saaread(SAA7146_I2C_STATUS) & 0x3c)
 		I2CWipe(saa);
-	for (i = 0; i < 1000 &&
-	     (saaread(SAA7146_I2C_STATUS) & SAA7146_I2C_BUSY); i++)
+	for (i = 0;
+		i < 1000 && (saaread(SAA7146_I2C_STATUS) & SAA7146_I2C_BUSY);
+		i++)
 		schedule();
 	if (i == 1000)
 		I2CWipe(saa);
 	if (dosub)
 		saawrite(((addr & 0xfe) << 24) | (((addr | 1) & 0xff) << 8) |
-		  ((subaddr & 0xff) << 16) | 0xed, SAA7146_I2C_TRANSFER);
+			((subaddr & 0xff) << 16) | 0xed, SAA7146_I2C_TRANSFER);
 	else
 		saawrite(((addr & 0xfe) << 24) | (((addr | 1) & 0xff) << 16) |
-			 0xf1, SAA7146_I2C_TRANSFER);
+			0xf1, SAA7146_I2C_TRANSFER);
 	saawrite((SAA7146_MC2_UPLD_I2C << 16) |
 		 SAA7146_MC2_UPLD_I2C, SAA7146_MC2);
 	/* wait for i2c registers to be programmed */
@@ -163,7 +168,7 @@ static int I2CRead(struct saa7146 *saa, 
 		schedule();
 	if (saaread(SAA7146_I2C_STATUS) & SAA7146_I2C_ERR)
 		return -1;
-	if (i == 1000) 
+	if (i == 1000)
 		printk("i2c setup read timeout\n");
 	saawrite(0x41, SAA7146_I2C_TRANSFER);
 	saawrite((SAA7146_MC2_UPLD_I2C << 16) |
@@ -178,7 +183,7 @@ static int I2CRead(struct saa7146 *saa, 
 		schedule();
 	if (saaread(SAA7146_I2C_TRANSFER) & SAA7146_I2C_ERR)
 		return -1;
-	if (i == 1000) 
+	if (i == 1000)
 		printk("i2c read timeout\n");
 	return ((saaread(SAA7146_I2C_TRANSFER) >> 24) & 0xff);
 }
@@ -213,20 +218,22 @@ static void attach_inform(struct saa7146
 {
 	int i;
 
-	DEBUG(printk(KERN_DEBUG "stradis%d: i2c: device found=%02x\n", saa->nr, id));
-	if (id == 0xa0)	{ /* we have rev2 or later board, fill in info */
+	DEBUG(printk(KERN_DEBUG "stradis%d: i2c: device found=%02x\n", saa->nr,
+		id));
+	if (id == 0xa0) {	/* we have rev2 or later board, fill in info */
 		for (i = 0; i < 64; i++)
 			saa->boardcfg[i] = I2CRead(saa, 0xa0, i, 1);
 #ifdef USE_RESCUE_EEPROM_SDM275
 		if (saa->boardcfg[0] != 0) {
-			printk("stradis%d: WARNING: EEPROM STORED VALUES HAVE BEEN IGNORED\n", saa->nr);
+			printk("stradis%d: WARNING: EEPROM STORED VALUES HAVE "
+				"BEEN IGNORED\n", saa->nr);
 			for (i = 0; i < 64; i++)
 				saa->boardcfg[i] = rescue_eeprom[i];
 		}
 #endif
 		printk("stradis%d: config =", saa->nr);
 		for (i = 0; i < 51; i++) {
-			printk(" %02x",saa->boardcfg[i]);
+			printk(" %02x", saa->boardcfg[i]);
 		}
 		printk("\n");
 	}
@@ -254,17 +261,19 @@ static int wait_for_debi_done(struct saa
 	for (i = 0; i < 500000 &&
 	     (saaread(SAA7146_PSR) & SAA7146_PSR_DEBI_S); i++)
 		saaread(SAA7146_MC2);
+
 	if (i > debiwait_maxwait)
 		printk("wait-for-debi-done maxwait: %d\n",
 			debiwait_maxwait = i);
-	
+
 	if (i == 500000)
 		return -1;
+
 	return 0;
 }
 
 static int debiwrite(struct saa7146 *saa, u32 config, int addr,
-		      u32 val, int count)
+	u32 val, int count)
 {
 	u32 cmd;
 	if (count <= 0 || count > 32764)
@@ -330,16 +339,15 @@ static void do_irq_send_data(struct saa7
 		return;
 	}
 	/* if at least 1 block audio waiting and audio fifo isn't full */
-	if (audbytes >= 2048 && (debiread(saa, debNormal,
-		IBM_MP2_AUD_FIFO, 2) & 0xff) < 60) {
+	if (audbytes >= 2048 && (debiread(saa, debNormal, IBM_MP2_AUD_FIFO, 2)
+			& 0xff) < 60) {
 		if (saa->audhead > saa->audtail)
 			split = 65536 - saa->audhead;
 		else
 			split = 0;
 		audbytes = 2048;
 		if (split > 0 && split < 2048) {
-			memcpy(saa->dmadebi, saa->audbuf + saa->audhead,
-				split);
+			memcpy(saa->dmadebi, saa->audbuf + saa->audhead, split);
 			saa->audhead = 0;
 			audbytes -= split;
 		} else
@@ -348,20 +356,19 @@ static void do_irq_send_data(struct saa7
 			audbytes);
 		saa->audhead += audbytes;
 		saa->audhead &= 0xffff;
-		debiwrite(saa, debAudio, (NewCard? IBM_MP2_AUD_FIFO :
-			  IBM_MP2_AUD_FIFOW), 0, 2048);
+		debiwrite(saa, debAudio, (NewCard ? IBM_MP2_AUD_FIFO :
+			IBM_MP2_AUD_FIFOW), 0, 2048);
 		wake_up_interruptible(&saa->audq);
-	/* if at least 1 block video waiting and video fifo isn't full */
+		/* if at least 1 block video waiting and video fifo isn't full */
 	} else if (vidbytes >= 30720 && (debiread(saa, debNormal,
-		IBM_MP2_FIFO, 2)) < 16384) {
+						  IBM_MP2_FIFO, 2)) < 16384) {
 		if (saa->vidhead > saa->vidtail)
 			split = 524288 - saa->vidhead;
 		else
 			split = 0;
 		vidbytes = 30720;
 		if (split > 0 && split < 30720) {
-			memcpy(saa->dmadebi, saa->vidbuf + saa->vidhead,
-				split);
+			memcpy(saa->dmadebi, saa->vidbuf + saa->vidhead, split);
 			saa->vidhead = 0;
 			vidbytes -= split;
 		} else
@@ -371,7 +378,7 @@ static void do_irq_send_data(struct saa7
 		saa->vidhead += vidbytes;
 		saa->vidhead &= 0x7ffff;
 		debiwrite(saa, debVideo, (NewCard ? IBM_MP2_FIFO :
-			  IBM_MP2_FIFOW), 0, 30720);
+					  IBM_MP2_FIFOW), 0, 30720);
 		wake_up_interruptible(&saa->vidq);
 	}
 	saawrite(SAA7146_PSR_DEBI_S | SAA7146_PSR_PIN1, SAA7146_IER);
@@ -383,10 +390,10 @@ static void send_osd_data(struct saa7146
 	if (size > 30720)
 		size = 30720;
 	/* ensure some multiple of 8 bytes is transferred */
-	size = 8 * ((size + 8)>>3);
+	size = 8 * ((size + 8) >> 3);
 	if (size) {
 		debiwrite(saa, debNormal, IBM_MP2_OSD_ADDR,
-			  (saa->osdhead>>3), 2);
+			  (saa->osdhead >> 3), 2);
 		memcpy(saa->dmadebi, &saa->osdbuf[saa->osdhead], size);
 		saa->osdhead += size;
 		/* block transfer of next 8 bytes to ~32k bytes */
@@ -400,7 +407,7 @@ static void send_osd_data(struct saa7146
 
 static irqreturn_t saa7146_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
-	struct saa7146 *saa = (struct saa7146 *) dev_id;
+	struct saa7146 *saa = dev_id;
 	u32 stat, astat;
 	int count;
 	int handled = 0;
@@ -449,7 +456,7 @@ static irqreturn_t saa7146_irq(int irq, 
 				saa->vidinfo.v_size = 480;
 #if 0
 				if (saa->endmarkhead != saa->endmarktail) {
-					saa->audhead = 
+					saa->audhead =
 						saa->endmark[saa->endmarkhead];
 					saa->endmarkhead++;
 					if (saa->endmarkhead >= MAX_MARKS)
@@ -459,7 +466,7 @@ static irqreturn_t saa7146_irq(int irq, 
 			}
 			if (istat & 0x4000) {	/* Sequence Error Code */
 				if (saa->endmarkhead != saa->endmarktail) {
-					saa->audhead = 
+					saa->audhead =
 						saa->endmark[saa->endmarkhead];
 					saa->endmarkhead++;
 					if (saa->endmarkhead >= MAX_MARKS)
@@ -578,7 +585,7 @@ static int ibm_send_command(struct saa71
 	int i;
 
 	if (chain)
-		debiwrite(saa, debNormal, IBM_MP2_COMMAND, (command << 1) | 1, 2);
+		debiwrite(saa, debNormal, IBM_MP2_COMMAND, (command << 1)| 1,2);
 	else
 		debiwrite(saa, debNormal, IBM_MP2_COMMAND, command << 1, 2);
 	debiwrite(saa, debNormal, IBM_MP2_CMD_DATA, data, 2);
@@ -628,11 +635,9 @@ static void initialize_cs8420(struct saa
 	else
 		sequence = mode8420con;
 	for (i = 0; i < INIT8420LEN; i++)
-		I2CWrite(saa, 0x20, init8420[i * 2],
-			 init8420[i * 2 + 1], 2);
+		I2CWrite(saa, 0x20, init8420[i * 2], init8420[i * 2 + 1], 2);
 	for (i = 0; i < MODE8420LEN; i++)
-		I2CWrite(saa, 0x20, sequence[i * 2],
-			 sequence[i * 2 + 1], 2);
+		I2CWrite(saa, 0x20, sequence[i * 2], sequence[i * 2 + 1], 2);
 	printk("stradis%d: CS8420 initialized\n", saa->nr);
 }
 
@@ -648,35 +653,36 @@ static void initialize_saa7121(struct sa
 	/* initialize PAL/NTSC video encoder */
 	for (i = 0; i < INIT7121LEN; i++) {
 		if (NewCard) {	/* handle new card encoder differences */
-			if (sequence[i*2] == 0x3a)
+			if (sequence[i * 2] == 0x3a)
 				I2CWrite(saa, 0x88, 0x3a, 0x13, 2);
-			else if (sequence[i*2] == 0x6b)
+			else if (sequence[i * 2] == 0x6b)
 				I2CWrite(saa, 0x88, 0x6b, 0x20, 2);
-			else if (sequence[i*2] == 0x6c)
+			else if (sequence[i * 2] == 0x6c)
 				I2CWrite(saa, 0x88, 0x6c,
 					 dopal ? 0x09 : 0xf5, 2);
-			else if (sequence[i*2] == 0x6d)
+			else if (sequence[i * 2] == 0x6d)
 				I2CWrite(saa, 0x88, 0x6d,
 					 dopal ? 0x20 : 0x00, 2);
-			else if (sequence[i*2] == 0x7a)
+			else if (sequence[i * 2] == 0x7a)
 				I2CWrite(saa, 0x88, 0x7a,
 					 dopal ? (PALFirstActive - 1) :
 					 (NTSCFirstActive - 4), 2);
-			else if (sequence[i*2] == 0x7b)
+			else if (sequence[i * 2] == 0x7b)
 				I2CWrite(saa, 0x88, 0x7b,
 					 dopal ? PALLastActive :
 					 NTSCLastActive, 2);
-			else I2CWrite(saa, 0x88, sequence[i * 2],
-				 sequence[i * 2 + 1], 2);
+			else
+				I2CWrite(saa, 0x88, sequence[i * 2],
+					 sequence[i * 2 + 1], 2);
 		} else {
-			if (sequence[i*2] == 0x6b && mod)
-				I2CWrite(saa, 0x88, 0x6b, 
-					(sequence[i * 2 + 1] ^ 0x09), 2);
-			else if (sequence[i*2] == 0x7a)
+			if (sequence[i * 2] == 0x6b && mod)
+				I2CWrite(saa, 0x88, 0x6b,
+					 (sequence[i * 2 + 1] ^ 0x09), 2);
+			else if (sequence[i * 2] == 0x7a)
 				I2CWrite(saa, 0x88, 0x7a,
 					 dopal ? (PALFirstActive - 1) :
 					 (NTSCFirstActive - 4), 2);
-			else if (sequence[i*2] == 0x7b)
+			else if (sequence[i * 2] == 0x7b)
 				I2CWrite(saa, 0x88, 0x7b,
 					 dopal ? PALLastActive :
 					 NTSCLastActive, 2);
@@ -700,7 +706,8 @@ static void set_genlock_offset(struct sa
 	nCode = noffset + 0x100;
 	if (nCode == 1)
 		nCode = 0x401;
-	else if (nCode < 1) nCode = 0x400 + PixelsPerLine + nCode;
+	else if (nCode < 1)
+		nCode = 0x400 + PixelsPerLine + nCode;
 	debiwrite(saa, debNormal, XILINX_GLDELAY, nCode, 2);
 }
 
@@ -710,33 +717,31 @@ static void set_out_format(struct saa714
 	saa->boardcfg[2] = mode;
 	/* do not adjust analog video parameters here, use saa7121 init */
 	/* you will affect the SDI output on the new card */
-	if (mode == VIDEO_MODE_PAL) {		/* PAL */
+	if (mode == VIDEO_MODE_PAL) {	/* PAL */
 		debiwrite(saa, debNormal, XILINX_CTL0, 0x0808, 2);
 		mdelay(50);
 		saawrite(0x012002c0, SAA7146_NUM_LINE_BYTE1);
 		if (NewCard) {
-			debiwrite(saa, debNormal, IBM_MP2_DISP_MODE,
-				  0xe100, 2);
+			debiwrite(saa, debNormal, IBM_MP2_DISP_MODE, 0xe100, 2);
 			mdelay(50);
 		}
 		debiwrite(saa, debNormal, IBM_MP2_DISP_MODE,
-			  NewCard ? 0xe500: 0x6500, 2);
+			  NewCard ? 0xe500 : 0x6500, 2);
 		debiwrite(saa, debNormal, IBM_MP2_DISP_DLY,
 			  (1 << 8) |
-			  (NewCard ? PALFirstActive : PALFirstActive-6), 2);
+			  (NewCard ? PALFirstActive : PALFirstActive - 6), 2);
 	} else {		/* NTSC */
 		debiwrite(saa, debNormal, XILINX_CTL0, 0x0800, 2);
 		mdelay(50);
 		saawrite(0x00f002c0, SAA7146_NUM_LINE_BYTE1);
 		debiwrite(saa, debNormal, IBM_MP2_DISP_MODE,
-			  NewCard ? 0xe100: 0x6100, 2);
+			  NewCard ? 0xe100 : 0x6100, 2);
 		debiwrite(saa, debNormal, IBM_MP2_DISP_DLY,
 			  (1 << 8) |
-			  (NewCard ? NTSCFirstActive : NTSCFirstActive-6), 2);
+			  (NewCard ? NTSCFirstActive : NTSCFirstActive - 6), 2);
 	}
 }
 
-
 /* Intialize bitmangler to map from a byte value to the mangled word that
  * must be output to program the Xilinx part through the DEBI port.
  * Xilinx Data Bit->DEBI Bit: 0->15 1->7 2->6 3->12 4->11 5->2 6->1 7->0
@@ -764,43 +769,41 @@ static int initialize_fpga(struct video_
 	for (num = 0; num < saa_num; num++) {
 		saa = &saa7146s[num];
 		if (saa->boardcfg[0] > 20)
-				continue;	/* card was programmed */
+			continue;	/* card was programmed */
 		loadtwo = (saa->boardcfg[18] & 0x10);
 		if (!NewCard)	/* we have an old board */
 			for (i = 0; i < 256; i++)
-			    bitmangler[i] = ((i & 0x01) << 15) |
-				((i & 0x02) << 6) | ((i & 0x04) << 4) |
-				((i & 0x08) << 9) | ((i & 0x10) << 7) |
-				((i & 0x20) >> 3) | ((i & 0x40) >> 5) |
-				((i & 0x80) >> 7);
-		else	/* else we have a new board */
+				bitmangler[i] = ((i & 0x01) << 15) |
+					((i & 0x02) << 6) | ((i & 0x04) << 4) |
+					((i & 0x08) << 9) | ((i & 0x10) << 7) |
+					((i & 0x20) >> 3) | ((i & 0x40) >> 5) |
+					((i & 0x80) >> 7);
+		else		/* else we have a new board */
 			for (i = 0; i < 256; i++)
-			    bitmangler[i] = ((i & 0x01) << 7) |
-				((i & 0x02) << 5) | ((i & 0x04) << 3) |
-				((i & 0x08) << 1) | ((i & 0x10) >> 1) |
-				((i & 0x20) >> 3) | ((i & 0x40) >> 5) |
-				((i & 0x80) >> 7);
+				bitmangler[i] = ((i & 0x01) << 7) |
+					((i & 0x02) << 5) | ((i & 0x04) << 3) |
+					((i & 0x08) << 1) | ((i & 0x10) >> 1) |
+					((i & 0x20) >> 3) | ((i & 0x40) >> 5) |
+					((i & 0x80) >> 7);
 
 		dmabuf = (u16 *) saa->dmadebi;
 		newdma = (u8 *) saa->dmadebi;
 		if (NewCard) {	/* SDM2xxx */
 			if (!strncmp(bitdata->loadwhat, "decoder2", 8))
 				continue;	/* fpga not for this card */
-			if (!strncmp(&saa->boardcfg[42],
-				     bitdata->loadwhat, 8)) {
+			if (!strncmp(&saa->boardcfg[42], bitdata->loadwhat, 8))
 				loadfile = 1;
-			} else if (loadtwo && !strncmp(&saa->boardcfg[19],
-				   bitdata->loadwhat, 8)) {
+			else if (loadtwo && !strncmp(&saa->boardcfg[19],
+				       bitdata->loadwhat, 8))
 				loadfile = 2;
-			} else if (!saa->boardcfg[42] &&	/* special */
-				   !strncmp("decxl", bitdata->loadwhat, 8)) {
-				loadfile = 1;
-			} else
+			else if (!saa->boardcfg[42] && !strncmp("decxl",
+					bitdata->loadwhat, 8))
+				loadfile = 1;	/* special */
+			else
 				continue;	/* fpga not for this card */
-			if (loadfile != 1 && loadfile != 2) {
+			if (loadfile != 1 && loadfile != 2)
 				continue;	/* skip to next card */
-			}
-			if (saa->boardcfg[0] && loadfile == 1 )
+			if (saa->boardcfg[0] && loadfile == 1)
 				continue;	/* skip to next card */
 			if (saa->boardcfg[0] != 1 && loadfile == 2)
 				continue;	/* skip to next card */
@@ -835,8 +838,9 @@ static int initialize_fpga(struct video_
 		/* Release Xilinx INIT signal (WS2) */
 		saawrite(0x00000000, SAA7146_GPIO_CTRL);
 		/* Wait for the INIT to go High */
-		for (i = 0; i < 10000 &&
-		     !(saaread(SAA7146_PSR) & SAA7146_PSR_PIN2); i++)
+		for (i = 0;
+			i < 10000 && !(saaread(SAA7146_PSR) & SAA7146_PSR_PIN2);
+			i++)
 			schedule();
 		if (i == 1000) {
 			printk(KERN_INFO "stradis%d: no fpga INIT\n", saa->nr);
@@ -846,17 +850,13 @@ send_fpga_stuff:
 		if (NewCard) {
 			for (i = startindex; i < bitdata->datasize; i++)
 				newdma[i - startindex] =
-					bitmangler[bitdata->data[i]];
+				    bitmangler[bitdata->data[i]];
 			debiwrite(saa, 0x01420000, 0, 0,
 				((bitdata->datasize - startindex) + 5));
-			if (loadtwo) {
-				if (loadfile == 1) {
-					printk("stradis%d: "
-						"awaiting 2nd FPGA bitfile\n",
-						saa->nr);
-					continue;	/* skip to next card */
-				}
-
+			if (loadtwo && loadfile == 1) {
+				printk("stradis%d: awaiting 2nd FPGA bitfile\n",
+				       saa->nr);
+				continue;	/* skip to next card */
 			}
 		} else {
 			for (i = startindex; i < bitdata->datasize; i++)
@@ -865,8 +865,9 @@ send_fpga_stuff:
 			debiwrite(saa, 0x014a0000, 0, 0,
 				((bitdata->datasize - startindex) + 5) * 2);
 		}
-		for (i = 0; i < 1000 &&
-		     !(saaread(SAA7146_PSR) & SAA7146_PSR_PIN2); i++)
+		for (i = 0;
+			i < 1000 && !(saaread(SAA7146_PSR) & SAA7146_PSR_PIN2);
+			i++)
 			schedule();
 		if (i == 1000) {
 			printk(KERN_INFO "stradis%d: FPGA load failed\n",
@@ -890,14 +891,14 @@ send_fpga_stuff:
 			/* mute CS3310 */
 			if (HaveCS3310)
 				debiwrite(saa, debNormal, XILINX_CS3310_CMPLT,
-					  0, 2);
+					0, 2);
 			/* set VXCO to PWM mode, release reset, blank on */
 			debiwrite(saa, debNormal, XILINX_CTL0, 0xffc4, 2);
 			mdelay(10);
 			/* unmute CS3310 */
 			if (HaveCS3310)
 				debiwrite(saa, debNormal, XILINX_CTL0,
-					  0x2020, 2);
+					0x2020, 2);
 		}
 		/* set source Black */
 		debiwrite(saa, debNormal, XILINX_CTL0, 0x1707, 2);
@@ -923,10 +924,10 @@ send_fpga_stuff:
 			/* we must init CS8420 first since rev b pulls i2s */
 			/* master clock low and CS4341 needs i2s master to */
 			/* run the i2c port. */
-			if (HaveCS8420) {
+			if (HaveCS8420)
 				/* 0=consumer, 1=pro */
 				initialize_cs8420(saa, 0);
-			}
+
 			mdelay(5);
 			if (HaveCS4341)
 				initialize_cs4341(saa);
@@ -946,6 +947,7 @@ send_fpga_stuff:
 		debiwrite(saa, debNormal, XILINX_CTL0, 0x8080, 2);
 #endif
 	}
+
 	return failure;
 }
 
@@ -986,10 +988,10 @@ static int do_ibm_reset(struct saa7146 *
 		/* we must init CS8420 first since rev b pulls i2s */
 		/* master clock low and CS4341 needs i2s master to */
 		/* run the i2c port. */
-		if (HaveCS8420) {
+		if (HaveCS8420)
 			/* 0=consumer, 1=pro */
 			initialize_cs8420(saa, 1);
-		}
+
 		mdelay(5);
 		if (HaveCS4341)
 			initialize_cs4341(saa);
@@ -1004,12 +1006,12 @@ static int do_ibm_reset(struct saa7146 *
 	debiwrite(saa, debNormal, IBM_MP2_OSD_SIZE, 0x2000, 2);
 	debiwrite(saa, debNormal, IBM_MP2_AUD_CTL, 0x4552, 2);
 	if (ibm_send_command(saa, IBM_MP2_CONFIG_DECODER,
-		(ChipControl == 0x43 ? 0xe800 : 0xe000), 1)) {
+			(ChipControl == 0x43 ? 0xe800 : 0xe000), 1)) {
 		printk(KERN_ERR "stradis%d: IBM config failed\n", saa->nr);
 	}
 	if (HaveCS3310) {
 		int i = CS3310MaxLvl;
-		debiwrite(saa, debNormal, XILINX_CS3310_CMPLT, ((i<<8)|i), 2);
+		debiwrite(saa, debNormal, XILINX_CS3310_CMPLT, ((i << 8)| i),2);
 	}
 	/* start video decoder */
 	debiwrite(saa, debNormal, IBM_MP2_CHIP_CONTROL, ChipControl, 2);
@@ -1022,6 +1024,7 @@ static int do_ibm_reset(struct saa7146 *
 	/* clear pending interrupts */
 	debiread(saa, debNormal, IBM_MP2_HOST_INT, 2);
 	debiwrite(saa, debNormal, XILINX_CTL0, 0x1711, 2);
+
 	return 0;
 }
 
@@ -1035,8 +1038,8 @@ static int initialize_ibmmpeg2(struct vi
 		saa = &saa7146s[num];
 		/* check that FPGA is loaded */
 		debiwrite(saa, debNormal, IBM_MP2_OSD_SIZE, 0xa55a, 2);
-		if ((i = debiread(saa, debNormal, IBM_MP2_OSD_SIZE, 2)) !=
-		     0xa55a) {
+		i = debiread(saa, debNormal, IBM_MP2_OSD_SIZE, 2);
+		if (i != 0xa55a) {
 			printk(KERN_INFO "stradis%d: %04x != 0xa55a\n",
 				saa->nr, i);
 #if 0
@@ -1047,17 +1050,17 @@ static int initialize_ibmmpeg2(struct vi
 			if (saa->boardcfg[0] > 27)
 				continue;	/* skip to next card */
 			/* load video control store */
-			saa->boardcfg[1] = 0x13;  /* no-sync default */
+			saa->boardcfg[1] = 0x13;	/* no-sync default */
 			debiwrite(saa, debNormal, IBM_MP2_WR_PROT, 1, 2);
 			debiwrite(saa, debNormal, IBM_MP2_PROC_IADDR, 0, 2);
 			for (i = 0; i < microcode->datasize / 2; i++)
 				debiwrite(saa, debNormal, IBM_MP2_PROC_IDATA,
 					(microcode->data[i * 2] << 8) |
-					 microcode->data[i * 2 + 1], 2);
+					microcode->data[i * 2 + 1], 2);
 			debiwrite(saa, debNormal, IBM_MP2_PROC_IADDR, 0, 2);
 			debiwrite(saa, debNormal, IBM_MP2_WR_PROT, 0, 2);
 			debiwrite(saa, debNormal, IBM_MP2_CHIP_CONTROL,
-				  ChipControl, 2);
+				ChipControl, 2);
 			saa->boardcfg[0] = 28;
 		}
 		if (!strncmp(microcode->loadwhat, "decoder.aud", 11)) {
@@ -1074,34 +1077,32 @@ static int initialize_ibmmpeg2(struct vi
 			debiwrite(saa, debNormal, IBM_MP2_OSD_SIZE, 0x2000, 2);
 			debiwrite(saa, debNormal, IBM_MP2_AUD_CTL, 0x4552, 2);
 			if (ibm_send_command(saa, IBM_MP2_CONFIG_DECODER,
-			    0xe000, 1)) {
-				printk(KERN_ERR
-				       "stradis%d: IBM config failed\n",
-				       saa->nr);
+					0xe000, 1)) {
+				printk(KERN_ERR "stradis%d: IBM config "
+					"failed\n", saa->nr);
 				return -1;
 			}
 			/* set PWM to center value */
 			if (NewCard) {
 				debiwrite(saa, debNormal, XILINX_PWM,
-					  saa->boardcfg[14] +
-					  (saa->boardcfg[13]<<8), 2);
+					saa->boardcfg[14] +
+					(saa->boardcfg[13] << 8), 2);
 			} else
-				debiwrite(saa, debNormal, XILINX_PWM,
-					  0x46, 2);
+				debiwrite(saa, debNormal, XILINX_PWM, 0x46, 2);
+
 			if (HaveCS3310) {
 				i = CS3310MaxLvl;
-				debiwrite(saa, debNormal,
-					XILINX_CS3310_CMPLT, ((i<<8)|i), 2);
+				debiwrite(saa, debNormal, XILINX_CS3310_CMPLT,
+					(i << 8) | i, 2);
 			}
-			printk(KERN_INFO
-			       "stradis%d: IBM MPEGCD%d Initialized\n",
-			       saa->nr, 18 + (debiread(saa, debNormal,
-			       IBM_MP2_CHIP_CONTROL, 2) >> 12));
+			printk(KERN_INFO "stradis%d: IBM MPEGCD%d Inited\n",
+				saa->nr, 18 + (debiread(saa, debNormal,
+				IBM_MP2_CHIP_CONTROL, 2) >> 12));
 			/* start video decoder */
 			debiwrite(saa, debNormal, IBM_MP2_CHIP_CONTROL,
 				ChipControl, 2);
-			debiwrite(saa, debNormal, IBM_MP2_RB_THRESHOLD,
-				0x4037, 2);	/* 256k vid, 3520 bytes aud */
+			debiwrite(saa, debNormal, IBM_MP2_RB_THRESHOLD, 0x4037,
+				2);	/* 256k vid, 3520 bytes aud */
 			debiwrite(saa, debNormal, IBM_MP2_AUD_CTL, 0x4573, 2);
 			ibm_send_command(saa, IBM_MP2_PLAY, 0, 0);
 			/* enable buffer threshold irq */
@@ -1114,52 +1115,48 @@ static int initialize_ibmmpeg2(struct vi
 			saa->boardcfg[0] = 37;
 		}
 	}
+
 	return 0;
 }
 
-static u32 palette2fmt[] =
-{				/* some of these YUV translations are wrong */
-  0xffffffff, 0x86000000, 0x87000000, 0x80000000, 0x8100000, 0x82000000,
-  0x83000000, 0x00000000, 0x03000000, 0x03000000, 0x0a00000, 0x03000000,
-  0x06000000, 0x00000000, 0x03000000, 0x0a000000, 0x0300000
+static u32 palette2fmt[] = {	/* some of these YUV translations are wrong */
+	0xffffffff, 0x86000000, 0x87000000, 0x80000000, 0x8100000, 0x82000000,
+	0x83000000, 0x00000000, 0x03000000, 0x03000000, 0x0a00000, 0x03000000,
+	0x06000000, 0x00000000, 0x03000000, 0x0a000000, 0x0300000
 };
-static int bpp2fmt[4] =
-{
+static int bpp2fmt[4] = {
 	VIDEO_PALETTE_HI240, VIDEO_PALETTE_RGB565, VIDEO_PALETTE_RGB24,
 	VIDEO_PALETTE_RGB32
 };
 
 /* I wish I could find a formula to calculate these... */
-static u32 h_prescale[64] =
-{
-  0x10000000, 0x18040202, 0x18080000, 0x380c0606, 0x38100204, 0x38140808,
-  0x38180000, 0x381c0000, 0x3820161c, 0x38242a3b, 0x38281230, 0x382c4460,
-  0x38301040, 0x38340080, 0x38380000, 0x383c0000, 0x3840fefe, 0x3844ee9f,
-  0x3848ee9f, 0x384cee9f, 0x3850ee9f, 0x38542a3b, 0x38581230, 0x385c0000,
-  0x38600000, 0x38640000, 0x38680000, 0x386c0000, 0x38700000, 0x38740000,
-  0x38780000, 0x387c0000, 0x30800000, 0x38840000, 0x38880000, 0x388c0000,
-  0x38900000, 0x38940000, 0x38980000, 0x389c0000, 0x38a00000, 0x38a40000,
-  0x38a80000, 0x38ac0000, 0x38b00000, 0x38b40000, 0x38b80000, 0x38bc0000,
-  0x38c00000, 0x38c40000, 0x38c80000, 0x38cc0000, 0x38d00000, 0x38d40000,
-  0x38d80000, 0x38dc0000, 0x38e00000, 0x38e40000, 0x38e80000, 0x38ec0000,
-  0x38f00000, 0x38f40000, 0x38f80000, 0x38fc0000,
+static u32 h_prescale[64] = {
+	0x10000000, 0x18040202, 0x18080000, 0x380c0606, 0x38100204, 0x38140808,
+	0x38180000, 0x381c0000, 0x3820161c, 0x38242a3b, 0x38281230, 0x382c4460,
+	0x38301040, 0x38340080, 0x38380000, 0x383c0000, 0x3840fefe, 0x3844ee9f,
+	0x3848ee9f, 0x384cee9f, 0x3850ee9f, 0x38542a3b, 0x38581230, 0x385c0000,
+	0x38600000, 0x38640000, 0x38680000, 0x386c0000, 0x38700000, 0x38740000,
+	0x38780000, 0x387c0000, 0x30800000, 0x38840000, 0x38880000, 0x388c0000,
+	0x38900000, 0x38940000, 0x38980000, 0x389c0000, 0x38a00000, 0x38a40000,
+	0x38a80000, 0x38ac0000, 0x38b00000, 0x38b40000, 0x38b80000, 0x38bc0000,
+	0x38c00000, 0x38c40000, 0x38c80000, 0x38cc0000, 0x38d00000, 0x38d40000,
+	0x38d80000, 0x38dc0000, 0x38e00000, 0x38e40000, 0x38e80000, 0x38ec0000,
+	0x38f00000, 0x38f40000, 0x38f80000, 0x38fc0000,
 };
-static u32 v_gain[64] =
-{
-  0x016000ff, 0x016100ff, 0x016100ff, 0x016200ff, 0x016200ff, 0x016200ff,
-  0x016200ff, 0x016300ff, 0x016300ff, 0x016300ff, 0x016300ff, 0x016300ff,
-  0x016300ff, 0x016300ff, 0x016300ff, 0x016400ff, 0x016400ff, 0x016400ff,
-  0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
-  0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
-  0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
-  0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
-  0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
-  0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
-  0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
-  0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
+static u32 v_gain[64] = {
+	0x016000ff, 0x016100ff, 0x016100ff, 0x016200ff, 0x016200ff, 0x016200ff,
+	0x016200ff, 0x016300ff, 0x016300ff, 0x016300ff, 0x016300ff, 0x016300ff,
+	0x016300ff, 0x016300ff, 0x016300ff, 0x016400ff, 0x016400ff, 0x016400ff,
+	0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
+	0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
+	0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
+	0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
+	0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
+	0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
+	0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
+	0x016400ff, 0x016400ff, 0x016400ff, 0x016400ff,
 };
 
-
 static void saa7146_set_winsize(struct saa7146 *saa)
 {
 	u32 format;
@@ -1174,24 +1171,23 @@ static void saa7146_set_winsize(struct s
 	saawrite(saa->win.vidadr + saa->win.bpl * saa->win.sheight,
 		 SAA7146_PROT_ADDR1);
 	saawrite(0, SAA7146_PAGE1);
-	saawrite(format|0x60, SAA7146_CLIP_FORMAT_CTRL);
+	saawrite(format | 0x60, SAA7146_CLIP_FORMAT_CTRL);
 	offset = (704 / (saa->win.width - 1)) & 0x3f;
 	saawrite(h_prescale[offset], SAA7146_HPS_H_PRESCALE);
 	offset = (720896 / saa->win.width) / (offset + 1);
-	saawrite((offset<<12)|0x0c, SAA7146_HPS_H_SCALE);
+	saawrite((offset << 12) | 0x0c, SAA7146_HPS_H_SCALE);
 	if (CurrentMode == VIDEO_MODE_NTSC) {
-		yacl = /*(480 / saa->win.height - 1) & 0x3f*/ 0;
+		yacl = /*(480 / saa->win.height - 1) & 0x3f */ 0;
 		ysci = 1024 - (saa->win.height * 1024 / 480);
 	} else {
-		yacl = /*(576 / saa->win.height - 1) & 0x3f*/ 0;
+		yacl = /*(576 / saa->win.height - 1) & 0x3f */ 0;
 		ysci = 1024 - (saa->win.height * 1024 / 576);
 	}
-	saawrite((1<<31)|(ysci<<21)|(yacl<<15), SAA7146_HPS_V_SCALE);
+	saawrite((1 << 31) | (ysci << 21) | (yacl << 15), SAA7146_HPS_V_SCALE);
 	saawrite(v_gain[yacl], SAA7146_HPS_V_GAIN);
 	saawrite(((SAA7146_MC2_UPLD_DMA1 | SAA7146_MC2_UPLD_HPS_V |
-		   SAA7146_MC2_UPLD_HPS_H) << 16) | (SAA7146_MC2_UPLD_DMA1 |
-		   SAA7146_MC2_UPLD_HPS_V | SAA7146_MC2_UPLD_HPS_H),
-		   SAA7146_MC2);
+		SAA7146_MC2_UPLD_HPS_H) << 16) | (SAA7146_MC2_UPLD_DMA1 |
+		SAA7146_MC2_UPLD_HPS_V | SAA7146_MC2_UPLD_HPS_H), SAA7146_MC2);
 }
 
 /* clip_draw_rectangle(cm,x,y,w,h) -- handle clipping an area
@@ -1226,8 +1222,8 @@ static void clip_draw_rectangle(u32 *cli
 	startword = (x >> 5);
 	endword = ((x + w) >> 5);
 	bitsleft = (0xffffffff >> (x & 31));
-	bitsright = (0xffffffff << (~((x + w) - (endword<<5))));
-	temp = &clipmap[(y<<5) + startword];
+	bitsright = (0xffffffff << (~((x + w) - (endword << 5))));
+	temp = &clipmap[(y << 5) + startword];
 	w = endword - startword;
 	if (!w) {
 		bitsleft |= bitsright;
@@ -1252,13 +1248,13 @@ static void make_clip_tab(struct saa7146
 	u32 *clipmap;
 
 	clipmap = saa->dmavid2;
-	if((width=saa->win.width)>1023)
-		width = 1023;		/* sanity check */
-	if((height=saa->win.height)>640)
-		height = 639;		/* sanity check */
-	if (ncr > 0) {	/* rectangles pased */
+	if ((width = saa->win.width) > 1023)
+		width = 1023;	/* sanity check */
+	if ((height = saa->win.height) > 640)
+		height = 639;	/* sanity check */
+	if (ncr > 0) {		/* rectangles pased */
 		/* convert rectangular clips to a bitmap */
-		memset(clipmap, 0, VIDEO_CLIPMAP_SIZE); /* clear map */
+		memset(clipmap, 0, VIDEO_CLIPMAP_SIZE);	/* clear map */
 		for (i = 0; i < ncr; i++)
 			clip_draw_rectangle(clipmap, cr[i].x, cr[i].y,
 				cr[i].width, cr[i].height);
@@ -1266,14 +1262,15 @@ static void make_clip_tab(struct saa7146
 	/* clip against viewing window AND screen 
 	   so we do not have to rely on the user program
 	 */
-	clip_draw_rectangle(clipmap,(saa->win.x+width>saa->win.swidth) ?
-		(saa->win.swidth-saa->win.x) : width, 0, 1024, 768);
-	clip_draw_rectangle(clipmap,0,(saa->win.y+height>saa->win.sheight) ?
-		(saa->win.sheight-saa->win.y) : height,1024,768);
-	if (saa->win.x<0)
-		clip_draw_rectangle(clipmap, 0, 0, -(saa->win.x), 768);
-	if (saa->win.y<0)
-		clip_draw_rectangle(clipmap, 0, 0, 1024, -(saa->win.y));
+	clip_draw_rectangle(clipmap, (saa->win.x + width > saa->win.swidth) ?
+		(saa->win.swidth - saa->win.x) : width, 0, 1024, 768);
+	clip_draw_rectangle(clipmap, 0,
+		(saa->win.y + height > saa->win.sheight) ?
+		(saa->win.sheight - saa->win.y) : height, 1024, 768);
+	if (saa->win.x < 0)
+		clip_draw_rectangle(clipmap, 0, 0, -saa->win.x, 768);
+	if (saa->win.y < 0)
+		clip_draw_rectangle(clipmap, 0, 0, 1024, -saa->win.y);
 }
 
 static int saa_ioctl(struct inode *inode, struct file *file,
@@ -1287,11 +1284,9 @@ static int saa_ioctl(struct inode *inode
 		{
 			struct video_capability b;
 			strcpy(b.name, saa->video_dev.name);
-			b.type = VID_TYPE_CAPTURE |
-			    VID_TYPE_OVERLAY |
-			    VID_TYPE_CLIPPING |
-			    VID_TYPE_FRAMERAM |
-			    VID_TYPE_SCALES;
+			b.type = VID_TYPE_CAPTURE | VID_TYPE_OVERLAY |
+				VID_TYPE_CLIPPING | VID_TYPE_FRAMERAM |
+				VID_TYPE_SCALES;
 			b.channels = 1;
 			b.audios = 1;
 			b.maxwidth = 768;
@@ -1328,17 +1323,18 @@ static int saa_ioctl(struct inode *inode
 			if (p.palette < sizeof(palette2fmt) / sizeof(u32)) {
 				format = palette2fmt[p.palette];
 				saa->win.color_fmt = format;
-				saawrite(format|0x60, SAA7146_CLIP_FORMAT_CTRL);
+				saawrite(format | 0x60,
+					SAA7146_CLIP_FORMAT_CTRL);
 			}
 			saawrite(((p.brightness & 0xff00) << 16) |
-				 ((p.contrast & 0xfe00) << 7) |
-			     ((p.colour & 0xfe00) >> 9), SAA7146_BCS_CTRL);
+				((p.contrast & 0xfe00) << 7) |
+				((p.colour & 0xfe00) >> 9), SAA7146_BCS_CTRL);
 			saa->picture = p;
 			/* upload changed registers */
 			saawrite(((SAA7146_MC2_UPLD_HPS_H |
-				 SAA7146_MC2_UPLD_HPS_V) << 16) |
-				SAA7146_MC2_UPLD_HPS_H | SAA7146_MC2_UPLD_HPS_V,
-				 SAA7146_MC2);
+				SAA7146_MC2_UPLD_HPS_V) << 16) |
+				SAA7146_MC2_UPLD_HPS_H |
+				SAA7146_MC2_UPLD_HPS_V, SAA7146_MC2);
 			return 0;
 		}
 	case VIDIOCSWIN:
@@ -1349,11 +1345,14 @@ static int saa_ioctl(struct inode *inode
 			if (copy_from_user(&vw, arg, sizeof(vw)))
 				return -EFAULT;
 
-			if (vw.flags || vw.width < 16 || vw.height < 16) {	/* stop capture */
-				saawrite((SAA7146_MC1_TR_E_1 << 16), SAA7146_MC1);
+			/* stop capture */
+			if (vw.flags || vw.width < 16 || vw.height < 16) {	
+				saawrite((SAA7146_MC1_TR_E_1 << 16),
+					SAA7146_MC1);
 				return -EINVAL;
 			}
-			if (saa->win.bpp < 4) {		/* 32-bit align start and adjust width */
+			/* 32-bit align start and adjust width */
+			if (saa->win.bpp < 4) {
 				int i = vw.x;
 				vw.x = (vw.x + 3) & ~3;
 				i = vw.x - i;
@@ -1382,23 +1381,24 @@ static int saa_ioctl(struct inode *inode
 			 */
 			if (vw.clipcount < 0) {
 				if (copy_from_user(saa->dmavid2, vw.clips,
-						   VIDEO_CLIPMAP_SIZE))
+						VIDEO_CLIPMAP_SIZE))
 					return -EFAULT;
-			}
-			else if (vw.clipcount > 16384) {
+			} else if (vw.clipcount > 16384) {
 				return -EINVAL;
 			} else if (vw.clipcount > 0) {
-				if ((vcp = vmalloc(sizeof(struct video_clip) *
-					        (vw.clipcount))) == NULL)
-					 return -ENOMEM;
+				vcp = vmalloc(sizeof(struct video_clip) *
+					vw.clipcount);
+				if (vcp == NULL)
+					return -ENOMEM;
 				if (copy_from_user(vcp, vw.clips,
-					      sizeof(struct video_clip) *
-						   vw.clipcount)) {
+						sizeof(struct video_clip) *
+						vw.clipcount)) {
 					vfree(vcp);
 					return -EFAULT;
 				}
 			} else	/* nothing clipped */
 				memset(saa->dmavid2, 0, VIDEO_CLIPMAP_SIZE);
+
 			make_clip_tab(saa, vcp, vw.clipcount);
 			if (vw.clipcount > 0)
 				vfree(vcp);
@@ -1431,21 +1431,21 @@ static int saa_ioctl(struct inode *inode
 			if (v == 0) {
 				saa->cap &= ~1;
 				saawrite((SAA7146_MC1_TR_E_1 << 16),
-					 SAA7146_MC1);
+					SAA7146_MC1);
 			} else {
 				if (saa->win.vidadr == 0 || saa->win.width == 0
-				    || saa->win.height == 0)
+						|| saa->win.height == 0)
 					return -EINVAL;
 				saa->cap |= 1;
 				saawrite((SAA7146_MC1_TR_E_1 << 16) | 0xffff,
-					 SAA7146_MC1);
+					SAA7146_MC1);
 			}
 			return 0;
 		}
 	case VIDIOCGFBUF:
 		{
 			struct video_buffer v;
-			v.base = (void *) saa->win.vidadr;
+			v.base = (void *)saa->win.vidadr;
 			v.height = saa->win.sheight;
 			v.width = saa->win.swidth;
 			v.depth = saa->win.depth;
@@ -1463,19 +1463,20 @@ static int saa_ioctl(struct inode *inode
 			if (copy_from_user(&v, arg, sizeof(v)))
 				return -EFAULT;
 			if (v.depth != 8 && v.depth != 15 && v.depth != 16 &&
-			v.depth != 24 && v.depth != 32 && v.width > 16 &&
+			    v.depth != 24 && v.depth != 32 && v.width > 16 &&
 			    v.height > 16 && v.bytesperline > 16)
 				return -EINVAL;
 			if (v.base)
-				saa->win.vidadr = (unsigned long) v.base;
+				saa->win.vidadr = (unsigned long)v.base;
 			saa->win.sheight = v.height;
 			saa->win.swidth = v.width;
 			saa->win.bpp = ((v.depth + 7) & 0x38) / 8;
 			saa->win.depth = v.depth;
 			saa->win.bpl = v.bytesperline;
 
-			DEBUG(printk("Display at %p is %d by %d, bytedepth %d, bpl %d\n",
-				     v.base, v.width, v.height, saa->win.bpp, saa->win.bpl));
+			DEBUG(printk("Display at %p is %d by %d, bytedepth %d, "
+					"bpl %d\n", v.base, v.width, v.height,
+					saa->win.bpp, saa->win.bpl));
 			saa7146_set_winsize(saa);
 			return 0;
 		}
@@ -1503,21 +1504,18 @@ static int saa_ioctl(struct inode *inode
 			int i;
 			if (copy_from_user(&v, arg, sizeof(v)))
 				return -EFAULT;
-			i = (~(v.volume>>8))&0xff;
+			i = (~(v.volume >> 8)) & 0xff;
 			if (!HaveCS4341) {
-				if (v.flags & VIDEO_AUDIO_MUTE) {
+				if (v.flags & VIDEO_AUDIO_MUTE)
 					debiwrite(saa, debNormal,
-						IBM_MP2_FRNT_ATTEN,
-						0xffff, 2);
-				}
+						IBM_MP2_FRNT_ATTEN, 0xffff, 2);
 				if (!(v.flags & VIDEO_AUDIO_MUTE))
 					debiwrite(saa, debNormal,
-						IBM_MP2_FRNT_ATTEN,
-						  0x0000, 2);
+						IBM_MP2_FRNT_ATTEN, 0x0000, 2);
 				if (v.flags & VIDEO_AUDIO_VOLUME)
 					debiwrite(saa, debNormal,
 						IBM_MP2_FRNT_ATTEN,
-						(i<<8)|i, 2);
+						(i << 8) | i, 2);
 			} else {
 				if (v.flags & VIDEO_AUDIO_MUTE)
 					cs4341_setlevel(saa, 0xff, 0xff);
@@ -1545,163 +1543,138 @@ static int saa_ioctl(struct inode *inode
 	case VIDIOCSPLAYMODE:
 		{
 			struct video_play_mode pmode;
-			if (copy_from_user((void *) &pmode, arg,
-				sizeof(struct video_play_mode)))
+			if (copy_from_user((void *)&pmode, arg,
+					sizeof(struct video_play_mode)))
 				return -EFAULT;
 			switch (pmode.mode) {
-				case VID_PLAY_VID_OUT_MODE:
-					if (pmode.p1 != VIDEO_MODE_NTSC &&
+			case VID_PLAY_VID_OUT_MODE:
+				if (pmode.p1 != VIDEO_MODE_NTSC &&
 						pmode.p1 != VIDEO_MODE_PAL)
-						return -EINVAL;
-					set_out_format(saa, pmode.p1);
-					return 0;
-				case VID_PLAY_GENLOCK:
-					debiwrite(saa, debNormal,
-						  XILINX_CTL0,
-						  (pmode.p1 ? 0x8000 : 0x8080),
-						  2);
-					if (NewCard)
-						set_genlock_offset(saa,
-							pmode.p2);
-					return 0;
-				case VID_PLAY_NORMAL:
-					debiwrite(saa, debNormal,
-						IBM_MP2_CHIP_CONTROL,
-						ChipControl, 2);
-					ibm_send_command(saa,
-						IBM_MP2_PLAY, 0, 0);
-					saa->playmode = pmode.mode;
-					return 0;
-				case VID_PLAY_PAUSE:
-					/* IBM removed the PAUSE command */
-					/* they say use SINGLE_FRAME now */
-				case VID_PLAY_SINGLE_FRAME:
-					ibm_send_command(saa,
-							IBM_MP2_SINGLE_FRAME,
-							0, 0);
-					if (saa->playmode == pmode.mode) {
-						debiwrite(saa, debNormal,
-							IBM_MP2_CHIP_CONTROL,
-							ChipControl, 2);
-					}
-					saa->playmode = pmode.mode;
-					return 0;
-				case VID_PLAY_FAST_FORWARD:
-					ibm_send_command(saa,
-						IBM_MP2_FAST_FORWARD, 0, 0);
-					saa->playmode = pmode.mode;
-					return 0;
-				case VID_PLAY_SLOW_MOTION:
-					ibm_send_command(saa,
-						IBM_MP2_SLOW_MOTION,
-						pmode.p1, 0);
-					saa->playmode = pmode.mode;
-					return 0;
-				case VID_PLAY_IMMEDIATE_NORMAL:
-					/* ensure transfers resume */
-					debiwrite(saa, debNormal,
-						IBM_MP2_CHIP_CONTROL,
-						ChipControl, 2);
-					ibm_send_command(saa,
-						IBM_MP2_IMED_NORM_PLAY, 0, 0);
-					saa->playmode = VID_PLAY_NORMAL;
-					return 0;
-				case VID_PLAY_SWITCH_CHANNELS:
-					saa->audhead = saa->audtail = 0;
-					saa->vidhead = saa->vidtail = 0;
-					ibm_send_command(saa,
-						IBM_MP2_FREEZE_FRAME, 0, 1);
-					ibm_send_command(saa,
-						IBM_MP2_RESET_AUD_RATE, 0, 1);
-					debiwrite(saa, debNormal,
-						IBM_MP2_CHIP_CONTROL, 0, 2);
-					ibm_send_command(saa,
-						IBM_MP2_CHANNEL_SWITCH, 0, 1);
+					return -EINVAL;
+				set_out_format(saa, pmode.p1);
+				return 0;
+			case VID_PLAY_GENLOCK:
+				debiwrite(saa, debNormal, XILINX_CTL0,
+					pmode.p1 ? 0x8000 : 0x8080, 2);
+				if (NewCard)
+					set_genlock_offset(saa, pmode.p2);
+				return 0;
+			case VID_PLAY_NORMAL:
+				debiwrite(saa, debNormal,
+					IBM_MP2_CHIP_CONTROL, ChipControl, 2);
+				ibm_send_command(saa, IBM_MP2_PLAY, 0, 0);
+				saa->playmode = pmode.mode;
+				return 0;
+			case VID_PLAY_PAUSE:
+				/* IBM removed the PAUSE command */
+				/* they say use SINGLE_FRAME now */
+			case VID_PLAY_SINGLE_FRAME:
+				ibm_send_command(saa, IBM_MP2_SINGLE_FRAME,0,0);
+				if (saa->playmode == pmode.mode) {
 					debiwrite(saa, debNormal,
 						IBM_MP2_CHIP_CONTROL,
 						ChipControl, 2);
-					ibm_send_command(saa,
-						IBM_MP2_PLAY, 0, 0);
-					saa->playmode = VID_PLAY_NORMAL;
-					return 0;
-				case VID_PLAY_FREEZE_FRAME:
-					ibm_send_command(saa,
-						IBM_MP2_FREEZE_FRAME, 0, 0);
-					saa->playmode = pmode.mode;
-					return 0;
-				case VID_PLAY_STILL_MODE:
-					ibm_send_command(saa,
-						IBM_MP2_SET_STILL_MODE, 0, 0);
-					saa->playmode = pmode.mode;
-					return 0;
-				case VID_PLAY_MASTER_MODE:
-					if (pmode.p1 == VID_PLAY_MASTER_NONE)
-						saa->boardcfg[1] = 0x13;
-					else if (pmode.p1 ==
-						VID_PLAY_MASTER_VIDEO)
-						saa->boardcfg[1] = 0x23;
-					else if (pmode.p1 ==
-						VID_PLAY_MASTER_AUDIO)
-						saa->boardcfg[1] = 0x43;
-					else
+				}
+				saa->playmode = pmode.mode;
+				return 0;
+			case VID_PLAY_FAST_FORWARD:
+				ibm_send_command(saa, IBM_MP2_FAST_FORWARD,0,0);
+				saa->playmode = pmode.mode;
+				return 0;
+			case VID_PLAY_SLOW_MOTION:
+				ibm_send_command(saa, IBM_MP2_SLOW_MOTION,
+					pmode.p1, 0);
+				saa->playmode = pmode.mode;
+				return 0;
+			case VID_PLAY_IMMEDIATE_NORMAL:
+				/* ensure transfers resume */
+				debiwrite(saa, debNormal,
+					IBM_MP2_CHIP_CONTROL, ChipControl, 2);
+				ibm_send_command(saa, IBM_MP2_IMED_NORM_PLAY,
+					0, 0);
+				saa->playmode = VID_PLAY_NORMAL;
+				return 0;
+			case VID_PLAY_SWITCH_CHANNELS:
+				saa->audhead = saa->audtail = 0;
+				saa->vidhead = saa->vidtail = 0;
+				ibm_send_command(saa, IBM_MP2_FREEZE_FRAME,0,1);
+				ibm_send_command(saa, IBM_MP2_RESET_AUD_RATE,
+					0, 1);
+				debiwrite(saa, debNormal, IBM_MP2_CHIP_CONTROL,
+					0, 2);
+				ibm_send_command(saa, IBM_MP2_CHANNEL_SWITCH,
+					0, 1);
+				debiwrite(saa, debNormal, IBM_MP2_CHIP_CONTROL,
+					ChipControl, 2);
+				ibm_send_command(saa, IBM_MP2_PLAY, 0, 0);
+				saa->playmode = VID_PLAY_NORMAL;
+				return 0;
+			case VID_PLAY_FREEZE_FRAME:
+				ibm_send_command(saa, IBM_MP2_FREEZE_FRAME,0,0);
+				saa->playmode = pmode.mode;
+				return 0;
+			case VID_PLAY_STILL_MODE:
+				ibm_send_command(saa, IBM_MP2_SET_STILL_MODE,
+					0, 0);
+				saa->playmode = pmode.mode;
+				return 0;
+			case VID_PLAY_MASTER_MODE:
+				if (pmode.p1 == VID_PLAY_MASTER_NONE)
+					saa->boardcfg[1] = 0x13;
+				else if (pmode.p1 == VID_PLAY_MASTER_VIDEO)
+					saa->boardcfg[1] = 0x23;
+				else if (pmode.p1 == VID_PLAY_MASTER_AUDIO)
+					saa->boardcfg[1] = 0x43;
+				else
+					return -EINVAL;
+				debiwrite(saa, debNormal,
+					  IBM_MP2_CHIP_CONTROL, ChipControl, 2);
+				return 0;
+			case VID_PLAY_ACTIVE_SCANLINES:
+				if (CurrentMode == VIDEO_MODE_PAL) {
+					if (pmode.p1 < 1 || pmode.p2 > 625)
 						return -EINVAL;
-					debiwrite(saa, debNormal,
-						IBM_MP2_CHIP_CONTROL,
-						ChipControl, 2);
-					return 0;
-				case VID_PLAY_ACTIVE_SCANLINES:
-					if (CurrentMode == VIDEO_MODE_PAL) {
-						if (pmode.p1 < 1 ||
-							pmode.p2 > 625)
-							return -EINVAL;
-						saa->boardcfg[5] = pmode.p1;
-						saa->boardcfg[55] = (pmode.p1 +
-							(pmode.p2/2) - 1) &	
-							0xff;
-					} else {
-						if (pmode.p1 < 4 ||
-							pmode.p2 > 525)
-							return -EINVAL;
-						saa->boardcfg[4] = pmode.p1;
-						saa->boardcfg[54] = (pmode.p1 +
-							(pmode.p2/2) - 4) &
-							0xff;
-					}
-					set_out_format(saa, CurrentMode);
-				case VID_PLAY_RESET:
-					return do_ibm_reset(saa);
-				case VID_PLAY_END_MARK:
-					if (saa->endmarktail <  
-						saa->endmarkhead) {
-						if (saa->endmarkhead -
+					saa->boardcfg[5] = pmode.p1;
+					saa->boardcfg[55] = (pmode.p1 +
+						(pmode.p2 / 2) - 1) & 0xff;
+				} else {
+					if (pmode.p1 < 4 || pmode.p2 > 525)
+						return -EINVAL;
+					saa->boardcfg[4] = pmode.p1;
+					saa->boardcfg[54] = (pmode.p1 +
+						(pmode.p2 / 2) - 4) & 0xff;
+				}
+				set_out_format(saa, CurrentMode);
+			case VID_PLAY_RESET:
+				return do_ibm_reset(saa);
+			case VID_PLAY_END_MARK:
+				if (saa->endmarktail < saa->endmarkhead) {
+					if (saa->endmarkhead -
 							saa->endmarktail < 2)
-							return -ENOSPC;
-					} else if (saa->endmarkhead <=
-						saa->endmarktail) {
-						if (saa->endmarktail -
-							saa->endmarkhead >
-							(MAX_MARKS - 2))
-							return -ENOSPC;
-					} else
 						return -ENOSPC;
-					saa->endmark[saa->endmarktail] =
-						saa->audtail;
-					saa->endmarktail++;
-					if (saa->endmarktail >= MAX_MARKS)
-						saa->endmarktail = 0;
+				} else if (saa->endmarkhead <=saa->endmarktail){
+					if (saa->endmarktail - saa->endmarkhead
+							> (MAX_MARKS - 2))
+						return -ENOSPC;
+				} else
+					return -ENOSPC;
+				saa->endmark[saa->endmarktail] = saa->audtail;
+				saa->endmarktail++;
+				if (saa->endmarktail >= MAX_MARKS)
+					saa->endmarktail = 0;
 			}
 			return -EINVAL;
 		}
 	case VIDIOCSWRITEMODE:
 		{
 			int mode;
-			if (copy_from_user((void *) &mode, arg, sizeof(int)))
-				 return -EFAULT;
+			if (copy_from_user((void *)&mode, arg, sizeof(int)))
+				return -EFAULT;
 			if (mode == VID_WRITE_MPEG_AUD ||
-			    mode == VID_WRITE_MPEG_VID ||
-			    mode == VID_WRITE_CC ||
-			    mode == VID_WRITE_TTX ||
-			    mode == VID_WRITE_OSD) {
+					mode == VID_WRITE_MPEG_VID ||
+					mode == VID_WRITE_CC ||
+					mode == VID_WRITE_TTX ||
+					mode == VID_WRITE_OSD) {
 				saa->writemode = mode;
 				return 0;
 			}
@@ -1715,7 +1688,7 @@ static int saa_ioctl(struct inode *inode
 			if (copy_from_user(&ucode, arg, sizeof(ucode)))
 				return -EFAULT;
 			if (ucode.datasize > 65536 || ucode.datasize < 1024 ||
-			    strncmp(ucode.loadwhat, "dec", 3))
+					strncmp(ucode.loadwhat, "dec", 3))
 				return -EINVAL;
 			if ((udata = vmalloc(ucode.datasize)) == NULL)
 				return -ENOMEM;
@@ -1724,8 +1697,8 @@ static int saa_ioctl(struct inode *inode
 				return -EFAULT;
 			}
 			ucode.data = udata;
-			if (!strncmp(ucode.loadwhat, "decoder.aud", 11)
-				|| !strncmp(ucode.loadwhat, "decoder.vid", 11))
+			if (!strncmp(ucode.loadwhat, "decoder.aud", 11) ||
+				!strncmp(ucode.loadwhat, "decoder.vid", 11))
 				i = initialize_ibmmpeg2(&ucode);
 			else
 				i = initialize_fpga(&ucode);
@@ -1770,14 +1743,14 @@ static int saa_mmap(struct file *file, s
 	return -EINVAL;
 }
 
-static ssize_t saa_read(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t saa_read(struct file *file, char __user * buf,
+	size_t count, loff_t * ppos)
 {
 	return -EINVAL;
 }
 
-static ssize_t saa_write(struct file *file, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t saa_write(struct file *file, const char __user * buf,
+	size_t count, loff_t * ppos)
 {
 	struct saa7146 *saa = file->private_data;
 	unsigned long todo = count;
@@ -1788,20 +1761,22 @@ static ssize_t saa_write(struct file *fi
 		if (saa->writemode == VID_WRITE_MPEG_AUD) {
 			spin_lock_irqsave(&saa->lock, flags);
 			if (saa->audhead <= saa->audtail)
-				blocksize = 65536-(saa->audtail - saa->audhead);
+				blocksize = 65536 -
+					(saa->audtail - saa->audhead);
 			else
 				blocksize = saa->audhead - saa->audtail;
 			spin_unlock_irqrestore(&saa->lock, flags);
 			if (blocksize < 16384) {
 				saawrite(SAA7146_PSR_DEBI_S |
-					 SAA7146_PSR_PIN1, SAA7146_IER);
+					SAA7146_PSR_PIN1, SAA7146_IER);
 				saawrite(SAA7146_PSR_PIN1, SAA7146_PSR);
 				/* wait for buffer space to open */
 				interruptible_sleep_on(&saa->audq);
 			}
 			spin_lock_irqsave(&saa->lock, flags);
 			if (saa->audhead <= saa->audtail) {
-				blocksize = 65536-(saa->audtail - saa->audhead);
+				blocksize = 65536 -
+					(saa->audtail - saa->audhead);
 				split = 65536 - saa->audtail;
 			} else {
 				blocksize = saa->audhead - saa->audtail;
@@ -1816,7 +1791,7 @@ static ssize_t saa_write(struct file *fi
 				return -ENOSPC;
 			if (split < blocksize) {
 				if (copy_from_user(saa->audbuf +
-					saa->audtail, buf, split)) 
+						saa->audtail, buf, split))
 					return -EFAULT;
 				buf += split;
 				todo -= split;
@@ -1824,7 +1799,7 @@ static ssize_t saa_write(struct file *fi
 				saa->audtail = 0;
 			}
 			if (copy_from_user(saa->audbuf + saa->audtail, buf,
-				blocksize)) 
+					blocksize))
 				return -EFAULT;
 			saa->audtail += blocksize;
 			todo -= blocksize;
@@ -1833,20 +1808,22 @@ static ssize_t saa_write(struct file *fi
 		} else if (saa->writemode == VID_WRITE_MPEG_VID) {
 			spin_lock_irqsave(&saa->lock, flags);
 			if (saa->vidhead <= saa->vidtail)
-				blocksize=524288-(saa->vidtail - saa->vidhead);
+				blocksize = 524288 -
+					(saa->vidtail - saa->vidhead);
 			else
 				blocksize = saa->vidhead - saa->vidtail;
 			spin_unlock_irqrestore(&saa->lock, flags);
 			if (blocksize < 65536) {
 				saawrite(SAA7146_PSR_DEBI_S |
-					 SAA7146_PSR_PIN1, SAA7146_IER);
+					SAA7146_PSR_PIN1, SAA7146_IER);
 				saawrite(SAA7146_PSR_PIN1, SAA7146_PSR);
 				/* wait for buffer space to open */
 				interruptible_sleep_on(&saa->vidq);
 			}
 			spin_lock_irqsave(&saa->lock, flags);
 			if (saa->vidhead <= saa->vidtail) {
-				blocksize=524288-(saa->vidtail - saa->vidhead);
+				blocksize = 524288 -
+					(saa->vidtail - saa->vidhead);
 				split = 524288 - saa->vidtail;
 			} else {
 				blocksize = saa->vidhead - saa->vidtail;
@@ -1861,7 +1838,7 @@ static ssize_t saa_write(struct file *fi
 				return -ENOSPC;
 			if (split < blocksize) {
 				if (copy_from_user(saa->vidbuf +
-					saa->vidtail, buf, split)) 
+						saa->vidtail, buf, split))
 					return -EFAULT;
 				buf += split;
 				todo -= split;
@@ -1869,7 +1846,7 @@ static ssize_t saa_write(struct file *fi
 				saa->vidtail = 0;
 			}
 			if (copy_from_user(saa->vidbuf + saa->vidtail, buf,
-				blocksize)) 
+					blocksize))
 				return -EFAULT;
 			saa->vidtail += blocksize;
 			todo -= blocksize;
@@ -1887,8 +1864,8 @@ static ssize_t saa_write(struct file *fi
 			debiwrite(saa, debNormal, IBM_MP2_OSD_LINK_ADDR, 0, 2);
 			debiwrite(saa, debNormal, IBM_MP2_MASK0, 0xc00d, 2);
 			debiwrite(saa, debNormal, IBM_MP2_DISP_MODE,
-				  debiread(saa, debNormal,
-				  IBM_MP2_DISP_MODE, 2) | 1, 2);
+				debiread(saa, debNormal,
+					IBM_MP2_DISP_MODE, 2) | 1, 2);
 			/* trigger osd data transfer */
 			saawrite(SAA7146_PSR_DEBI_S |
 				 SAA7146_PSR_PIN1, SAA7146_IER);
@@ -1923,34 +1900,32 @@ static int saa_release(struct inode *ino
 	return 0;
 }
 
-static struct file_operations saa_fops =
-{
-	.owner		= THIS_MODULE,
-	.open		= saa_open,
-	.release	= saa_release,
-	.ioctl		= saa_ioctl,
-	.compat_ioctl	= v4l_compat_ioctl32,
-	.read		= saa_read,
-	.llseek		= no_llseek,
-	.write		= saa_write,
-	.mmap		= saa_mmap,
+static struct file_operations saa_fops = {
+	.owner = THIS_MODULE,
+	.open = saa_open,
+	.release = saa_release,
+	.ioctl = saa_ioctl,
+	.compat_ioctl = v4l_compat_ioctl32,
+	.read = saa_read,
+	.llseek = no_llseek,
+	.write = saa_write,
+	.mmap = saa_mmap,
 };
 
 /* template for video_device-structure */
-static struct video_device saa_template =
-{
-	.name		= "SAA7146A",
-	.type		= VID_TYPE_CAPTURE | VID_TYPE_OVERLAY,
-	.hardware	= VID_HARDWARE_SAA7146,
-	.fops		= &saa_fops,
-	.minor		= -1,
+static struct video_device saa_template = {
+	.name = "SAA7146A",
+	.type = VID_TYPE_CAPTURE | VID_TYPE_OVERLAY,
+	.hardware = VID_HARDWARE_SAA7146,
+	.fops = &saa_fops,
+	.minor = -1,
 };
 
 static int __devinit configure_saa7146(struct pci_dev *pdev, int num)
 {
 	int retval;
 	struct saa7146 *saa = pci_get_drvdata(pdev);
-	
+
 	saa->endmarkhead = saa->endmarktail = 0;
 	saa->win.x = saa->win.y = 0;
 	saa->win.width = saa->win.cropwidth = 720;
@@ -1990,7 +1965,7 @@ static int __devinit configure_saa7146(s
 		dev_err(&pdev->dev, "%d: pci_enable_device failed!\n", num);
 		goto err;
 	}
-	
+
 	saa->id = pdev->device;
 	saa->irq = pdev->irq;
 	saa->video_dev.minor = -1;
@@ -2020,7 +1995,7 @@ static int __devinit configure_saa7146(s
 	pci_set_master(pdev);
 	retval = video_register_device(&saa->video_dev, VFL_TYPE_GRABBER,
 		video_nr);
-       	if (retval < 0) {
+	if (retval < 0) {
 		dev_err(&pdev->dev, "%d: error in registering video device!\n",
 			num);
 		goto errio;
@@ -2055,16 +2030,16 @@ static int __devinit init_saa7146(struct
 	saawrite(0x00000000, SAA7146_DD1_STREAM_A);
 	saawrite(0x00000000, SAA7146_BRS_CTRL);
 	saawrite(0x80400040, SAA7146_BCS_CTRL);
-	saawrite(0x0000e000 /*| (1<<29)*/, SAA7146_HPS_CTRL);
+	saawrite(0x0000e000 /*| (1<<29) */ , SAA7146_HPS_CTRL);
 	saawrite(0x00000060, SAA7146_CLIP_FORMAT_CTRL);
 	saawrite(0x00000000, SAA7146_ACON1);
 	saawrite(0x00000000, SAA7146_ACON2);
 	saawrite(0x00000600, SAA7146_I2C_STATUS);
 	saawrite(((SAA7146_MC2_UPLD_D1_B | SAA7146_MC2_UPLD_D1_A |
-		   SAA7146_MC2_UPLD_BRS | SAA7146_MC2_UPLD_HPS_H |
-		   SAA7146_MC2_UPLD_HPS_V | SAA7146_MC2_UPLD_DMA2 |
-	   SAA7146_MC2_UPLD_DMA1 | SAA7146_MC2_UPLD_I2C) << 16) | 0xffff,
-		 SAA7146_MC2);
+		SAA7146_MC2_UPLD_BRS | SAA7146_MC2_UPLD_HPS_H |
+		SAA7146_MC2_UPLD_HPS_V | SAA7146_MC2_UPLD_DMA2 |
+		SAA7146_MC2_UPLD_DMA1 | SAA7146_MC2_UPLD_I2C) << 16) | 0xffff,
+		SAA7146_MC2);
 	/* setup arbitration control registers */
 	saawrite(0x1412121a, SAA7146_PCI_BT_V1);
 
@@ -2102,9 +2077,9 @@ static int __devinit init_saa7146(struct
 	saawrite(virt_to_bus(saa->dmavid2), SAA7146_BASE_EVEN2);
 	saawrite(virt_to_bus(saa->dmavid2) + 128, SAA7146_BASE_ODD2);
 	saawrite(virt_to_bus(saa->dmavid2) + VIDEO_CLIPMAP_SIZE,
-		SAA7146_PROT_ADDR2);
+		 SAA7146_PROT_ADDR2);
 	saawrite(256, SAA7146_PITCH2);
-	saawrite(4, SAA7146_PAGE2); /* dma direction: read, no byteswap */
+	saawrite(4, SAA7146_PAGE2);	/* dma direction: read, no byteswap */
 	saawrite(((SAA7146_MC2_UPLD_DMA2) << 16) | SAA7146_MC2_UPLD_DMA2,
 		 SAA7146_MC2);
 	I2CBusScan(saa);
@@ -2175,7 +2150,7 @@ static int __devinit stradis_probe(struc
 	if (!pdev->subsystem_vendor)
 		dev_info(&pdev->dev, "%d: rev1 decoder\n", saa_num);
 	else
-		dev_info(&pdev->dev, "%d: SDM2xx found\n", saa_num); 
+		dev_info(&pdev->dev, "%d: SDM2xx found\n", saa_num);
 
 	pci_set_drvdata(pdev, &saa7146s[saa_num]);
 
@@ -2209,13 +2184,14 @@ static struct pci_device_id stradis_pci_
 	{ PCI_DEVICE(PCI_VENDOR_ID_PHILIPS, PCI_DEVICE_ID_PHILIPS_SAA7146) },
 	{ 0 }
 };
+
 MODULE_DEVICE_TABLE(pci, stradis_pci_tbl);
 
 static struct pci_driver stradis_driver = {
-	.name		= "stradis",
-	.id_table	= stradis_pci_tbl,
-	.probe		= stradis_probe,
-	.remove		= __devexit_p(stradis_remove)
+	.name = "stradis",
+	.id_table = stradis_pci_tbl,
+	.probe = stradis_probe,
+	.remove = __devexit_p(stradis_remove)
 };
 
 int __init stradis_init(void)
@@ -2223,7 +2199,7 @@ int __init stradis_init(void)
 	int retval;
 
 	saa_num = 0;
-	
+
 	retval = pci_register_driver(&stradis_driver);
 	if (retval)
 		printk(KERN_ERR "stradis: Unable to register pci driver.\n");
@@ -2231,7 +2207,6 @@ int __init stradis_init(void)
 	return retval;
 }
 
-
 void __exit stradis_exit(void)
 {
 	pci_unregister_driver(&stradis_driver);
