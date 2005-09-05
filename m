Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVIEVrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVIEVrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVIEVrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:47:16 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:21330 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932654AbVIEVno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:44 -0400
Date: Mon, 05 Sep 2005 18:26:16 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 23/24] V4L: Include saa6588 compiler option and files /
 Fixes comments on tuner.h
Message-ID: <431cb7f8.ifji6StBKz97ZtBQ%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f8.+hkXl/Cs30aAoLu+FSPBC6V+kUv3mKQEMqN8ZIuVqnXcRMXa"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f8.+hkXl/Cs30aAoLu+FSPBC6V+kUv3mKQEMqN8ZIuVqnXcRMXa
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f8.+hkXl/Cs30aAoLu+FSPBC6V+kUv3mKQEMqN8ZIuVqnXcRMXa
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-23-patch.diff"

- Include saa6588 compiler option and files.
- Fix comment on tuner.h
- linux/utsname.h replaced by linux/version.h to compile on vanilla 2.6.13

 linux/drivers/media/video/Kconfig                        |   12
 linux/drivers/media/video/Makefile                       |    2
 linux/drivers/media/video/bttvp.h                        |    2
 linux/drivers/media/video/cx88/cx88.h                    |    2
 linux/drivers/media/video/saa7134/saa7134.h              |    2
 linux/include/media/tuner.h                              |    2
 linux/drivers/media/video/rds.h                          |   48
 linux/drivers/media/video/saa6588.c                      |  534 ++++++++++
 8 files changed, 600 insertions(+), 4 deletions(-)

diff -upr linux/drivers/media/video/bttvp.h /usr/src/linux-v4l/drivers/media/video/bttvp.h
--- linux/drivers/media/video/bttvp.h	2005-09-05 11:42:30.000000000 -0300
+++ /usr/src/linux-v4l/drivers/media/video/bttvp.h	2005-09-05 12:33:12.000000000 -0300
@@ -25,7 +25,7 @@
 #ifndef _BTTVP_H_
 #define _BTTVP_H_
 
-#include <linux/utsname.h>
+#include <linux/version.h>
 #define BTTV_VERSION_CODE KERNEL_VERSION(0,9,16)
 
 #include <linux/types.h>
diff -upr linux/drivers/media/video/Kconfig /usr/src/linux-v4l/drivers/media/video/Kconfig
--- linux/drivers/media/video/Kconfig	2005-08-28 20:41:01.000000000 -0300
+++ /usr/src/linux-v4l/drivers/media/video/Kconfig	2005-09-05 12:25:31.000000000 -0300
@@ -28,6 +28,18 @@ config VIDEO_BT848
 	  To compile this driver as a module, choose M here: the
 	  module will be called bttv.
 
+config VIDEO_SAA6588
+	tristate "SAA6588 Radio Chip RDS decoder support on BT848 cards"
+	depends on VIDEO_DEV && I2C && VIDEO_BT848
+
+	help
+	  Support for  Radio Data System (RDS) decoder. This allows seeing
+	  radio station identification transmitted using this standard.
+	  Currentlly, it works only with bt8x8 chips.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called saa6588.
+
 config VIDEO_PMS
 	tristate "Mediavision Pro Movie Studio Video For Linux"
 	depends on VIDEO_DEV && ISA
diff -upr linux/drivers/media/video/Makefile /usr/src/linux-v4l/drivers/media/video/Makefile
--- linux/drivers/media/video/Makefile	2005-08-28 20:41:01.000000000 -0300
+++ /usr/src/linux-v4l/drivers/media/video/Makefile	2005-09-05 12:35:05.000000000 -0300
@@ -5,6 +5,7 @@
 bttv-objs	:=	bttv-driver.o bttv-cards.o bttv-if.o \
 			bttv-risc.o bttv-vbi.o bttv-i2c.o bttv-gpio.o
 zoran-objs      :=	zr36120.o zr36120_i2c.o zr36120_mem.o
+rds-objs        :=	saa6588.o
 zr36067-objs	:=	zoran_procfs.o zoran_device.o \
 			zoran_driver.o zoran_card.o
 tuner-objs	:=	tuner-core.o tuner-simple.o mt20xx.o tda8290.o tea5767.o
@@ -15,6 +16,7 @@ obj-$(CONFIG_VIDEO_BT848) += bttv.o msp3
 obj-$(CONFIG_SOUND_TVMIXER) += tvmixer.o
 
 obj-$(CONFIG_VIDEO_ZR36120) += zoran.o
+obj-$(CONFIG_VIDEO_SAA6588) += rds.o
 obj-$(CONFIG_VIDEO_SAA5246A) += saa5246a.o
 obj-$(CONFIG_VIDEO_SAA5249) += saa5249.o
 obj-$(CONFIG_VIDEO_CQCAM) += c-qcam.o

diff -upr linux/include/media/tuner.h /usr/src/linux-v4l/include/media/tuner.h
--- linux/include/media/tuner.h	2005-09-05 11:42:57.000000000 -0300
+++ /usr/src/linux-v4l/include/media/tuner.h	2005-09-05 12:28:06.000000000 -0300
@@ -1,4 +1,4 @@
- *
+/*
     tuner.h - definition for different tuners
 
     Copyright (C) 1997 Markus Schroeder (schroedm@uni-duesseldorf.de)
diff -upr linux/drivers/media/video/cx88/cx88.h /usr/src/linux-v4l/drivers/media/video/cx88/cx88.h
--- linux/drivers/media/video/cx88/cx88.h	2005-09-05 11:42:30.000000000 -0300
+++ /usr/src/linux-v4l/drivers/media/video/cx88/cx88.h	2005-09-05 14:25:50.000000000 -0300
@@ -34,7 +34,7 @@
 #include "btcx-risc.h"
 #include "cx88-reg.h"
 
-#include <linux/utsname.h>
+#include <linux/version.h>
 #define CX88_VERSION_CODE KERNEL_VERSION(0,0,5)
 
 #ifndef TRUE

diff -upr linux/drivers/media/video/saa7134/saa7134.h /usr/src/linux-v4l/drivers/media/video/saa7134/saa7134.h
--- linux/drivers/media/video/saa7134/saa7134.h	2005-09-05 11:42:49.000000000 -0300
+++ /usr/src/linux-v4l/drivers/media/video/saa7134/saa7134.h	2005-09-05 14:26:08.000000000 -0300
@@ -19,7 +19,7 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/utsname.h>
+#include <linux/version.h>
 #define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,14)
 
 #include <linux/pci.h>
 linux/drivers/media/video/rds.h     |   48 ++
 linux/drivers/media/video/saa6588.c |  534 ++++++++++++++++++++++++++++
 2 files changed, 582 insertions(+)

diff -u linux-2.6.13/drivers/media/video/rds.h linux/drivers/media/video/rds.h
--- linux-2.6.13/drivers/media/video/rds.h	2005-09-05 06:04:07.849993344 -0300
+++ linux/drivers/media/video/rds.h	2005-09-05 14:37:09.000000000 -0300
@@ -0,0 +1,48 @@
+/*
+
+    Types and defines needed for RDS. This is included by
+    saa6588.c and every driver (e.g. bttv-driver.c) that wants
+    to use the saa6588 module.
+
+    Instead of having a seperate rds.h, I'd prefer to include
+    this stuff in one of the already existing files like tuner.h
+
+    (c) 2005 by Hans J. Koch
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+*/
+
+#ifndef _RDS_H
+#define _RDS_H
+
+struct rds_command {
+	unsigned int  block_count;
+	int           result;
+	unsigned char *buffer;
+	struct file   *instance;
+	poll_table    *event_list;
+};
+
+#define RDS_CMD_OPEN	_IOW('R',1,int)
+#define RDS_CMD_CLOSE	_IOW('R',2,int)
+#define RDS_CMD_READ	_IOR('R',3,int)
+#define RDS_CMD_POLL	_IOR('R',4,int)
+
+#endif
+
+
+
+
diff -u linux-2.6.13/drivers/media/video/saa6588.c linux/drivers/media/video/saa6588.c
--- linux-2.6.13/drivers/media/video/saa6588.c	2005-09-05 06:04:07.849993344 -0300
+++ linux/drivers/media/video/saa6588.c	2005-09-05 14:37:09.000000000 -0300
@@ -0,0 +1,534 @@
+/*
+    Driver for SAA6588 RDS decoder
+
+    (c) 2005 Hans J. Koch
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/types.h>
+#include <linux/videodev.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/wait.h>
+#include <asm/uaccess.h>
+
+#include <media/id.h>
+
+#include "rds.h"
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = {
+	0x20 >> 1,
+	0x22 >> 1,
+	I2C_CLIENT_END,
+};
+
+I2C_CLIENT_INSMOD;
+
+/* insmod options */
+static unsigned int debug = 0;
+static unsigned int xtal = 0;
+static unsigned int rbds = 0;
+static unsigned int plvl = 0;
+static unsigned int bufblocks = 100;
+
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "enable debug messages");
+MODULE_PARM(xtal, "i");
+MODULE_PARM_DESC(xtal, "select oscillator frequency (0..3), default 0");
+MODULE_PARM(rbds, "i");
+MODULE_PARM_DESC(rbds, "select mode, 0=RDS, 1=RBDS, default 0");
+MODULE_PARM(plvl, "i");
+MODULE_PARM_DESC(plvl, "select pause level (0..3), default 0");
+MODULE_PARM(bufblocks, "i");
+MODULE_PARM_DESC(bufblocks, "number of buffered blocks, default 100");
+
+MODULE_DESCRIPTION("v4l2 driver module for SAA6588 RDS decoder");
+MODULE_AUTHOR("Hans J. Koch <koch@hjk-az.de>");
+
+MODULE_LICENSE("GPL");
+
+/* ---------------------------------------------------------------------- */
+
+#define UNSET       (-1U)
+#define PREFIX      "saa6588: "
+#define dprintk     if (debug) printk
+
+struct saa6588 {
+	struct i2c_client client;
+	struct work_struct work;
+	struct timer_list timer;
+	spinlock_t lock;
+	unsigned char *buffer;
+	unsigned int buf_size;
+	unsigned int rd_index;
+	unsigned int wr_index;
+	unsigned int block_count;
+	unsigned char last_blocknum;
+	wait_queue_head_t read_queue;
+	int data_available_for_read;
+};
+
+static struct i2c_driver driver;
+static struct i2c_client client_template;
+
+/* ---------------------------------------------------------------------- */
+
+/*
+ * SAA6588 defines
+ */
+
+/* Initialization and mode control byte (0w) */
+
+/* bit 0+1 (DAC0/DAC1) */
+#define cModeStandard           0x00
+#define cModeFastPI             0x01
+#define cModeReducedRequest     0x02
+#define cModeInvalid            0x03
+
+/* bit 2 (RBDS) */
+#define cProcessingModeRDS      0x00
+#define cProcessingModeRBDS     0x04
+
+/* bit 3+4 (SYM0/SYM1) */
+#define cErrCorrectionNone      0x00
+#define cErrCorrection2Bits     0x08
+#define cErrCorrection5Bits     0x10
+#define cErrCorrectionNoneRBDS  0x18
+
+/* bit 5 (NWSY) */
+#define cSyncNormal             0x00
+#define cSyncRestart            0x20
+
+/* bit 6 (TSQD) */
+#define cSigQualityDetectOFF    0x00
+#define cSigQualityDetectON     0x40
+
+/* bit 7 (SQCM) */
+#define cSigQualityTriggered    0x00
+#define cSigQualityContinous    0x80
+
+/* Pause level and flywheel control byte (1w) */
+
+/* bits 0..5 (FEB0..FEB5) */
+#define cFlywheelMaxBlocksMask  0x3F
+#define cFlywheelDefault        0x20
+
+/* bits 6+7 (PL0/PL1) */
+#define cPauseLevel_11mV	0x00
+#define cPauseLevel_17mV        0x40
+#define cPauseLevel_27mV        0x80
+#define cPauseLevel_43mV        0xC0
+
+/* Pause time/oscillator frequency/quality detector control byte (1w) */
+
+/* bits 0..4 (SQS0..SQS4) */
+#define cQualityDetectSensMask  0x1F
+#define cQualityDetectDefault   0x0F
+
+/* bit 5 (SOSC) */
+#define cSelectOscFreqOFF	0x00
+#define cSelectOscFreqON	0x20
+
+/* bit 6+7 (PTF0/PTF1) */
+#define cOscFreq_4332kHz	0x00
+#define cOscFreq_8664kHz	0x40
+#define cOscFreq_12996kHz	0x80
+#define cOscFreq_17328kHz	0xC0
+
+/* ---------------------------------------------------------------------- */
+
+static int block_to_user_buf(struct saa6588 *s, unsigned char *user_buf)
+{
+	int i;
+
+	if (s->rd_index == s->wr_index) {
+		if (debug > 2)
+			dprintk(PREFIX "Read: buffer empty.\n");
+		return 0;
+	}
+
+	if (debug > 2) {
+		dprintk(PREFIX "Read: ");
+		for (i = s->rd_index; i < s->rd_index + 3; i++)
+			dprintk("0x%02x ", s->buffer[i]);
+	}
+
+	if (copy_to_user(user_buf, &s->buffer[s->rd_index], 3))
+		return -EFAULT;
+
+	s->rd_index += 3;
+	if (s->rd_index >= s->buf_size)
+		s->rd_index = 0;
+	s->block_count--;
+
+	if (debug > 2)
+		dprintk("%d blocks total.\n", s->block_count);
+
+	return 1;
+}
+
+static void read_from_buf(struct saa6588 *s, struct rds_command *a)
+{
+	unsigned long flags;
+
+	unsigned char *buf_ptr = a->buffer;	/* This is a user space buffer! */
+	unsigned int i;
+	unsigned int rd_blocks;
+
+	a->result = 0;
+	if (!a->buffer)
+		return;
+
+	while (!s->data_available_for_read) {
+		int ret = wait_event_interruptible(s->read_queue,
+					     s->data_available_for_read);
+		if (ret == -ERESTARTSYS) {
+			a->result = -EINTR;
+			return;
+		}
+	}
+
+	spin_lock_irqsave(&s->lock, flags);
+	rd_blocks = a->block_count;
+	if (rd_blocks > s->block_count)
+		rd_blocks = s->block_count;
+
+	if (!rd_blocks)
+		return;
+
+	for (i = 0; i < rd_blocks; i++) {
+		if (block_to_user_buf(s, buf_ptr)) {
+			buf_ptr += 3;
+			a->result++;
+		} else
+			break;
+	}
+	a->result *= 3;
+	s->data_available_for_read = (s->block_count > 0);
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static void block_to_buf(struct saa6588 *s, unsigned char *blockbuf)
+{
+	unsigned int i;
+
+	if (debug > 3)
+		dprintk(PREFIX "New block: ");
+
+	for (i = 0; i < 3; ++i) {
+		if (debug > 3)
+			dprintk("0x%02x ", blockbuf[i]);
+		s->buffer[s->wr_index] = blockbuf[i];
+		s->wr_index++;
+	}
+
+	if (s->wr_index >= s->buf_size)
+		s->wr_index = 0;
+
+	if (s->wr_index == s->rd_index) {
+		s->rd_index++;
+		if (s->rd_index >= s->buf_size)
+			s->rd_index = 0;
+	} else
+		s->block_count++;
+
+	if (debug > 3)
+		dprintk("%d blocks total.\n", s->block_count);
+}
+
+static void saa6588_i2c_poll(struct saa6588 *s)
+{
+	unsigned long flags;
+	unsigned char tmpbuf[6];
+	unsigned char blocknum;
+	unsigned char tmp;
+
+	/* Although we only need 3 bytes, we have to read at least 6.
+	   SAA6588 returns garbage otherwise */
+	if (6 != i2c_master_recv(&s->client, &tmpbuf[0], 6)) {
+		if (debug > 1)
+			dprintk(PREFIX "read error!\n");
+		return;
+	}
+
+	blocknum = tmpbuf[0] >> 5;
+	if (blocknum == s->last_blocknum) {
+		if (debug > 3)
+			dprintk("Saw block %d again.\n", blocknum);
+		return;
+	}
+
+	s->last_blocknum = blocknum;
+
+	/*
+	   Byte order according to v4l2 specification:
+
+	   Byte 0: Least Significant Byte of RDS Block
+	   Byte 1: Most Significant Byte of RDS Block
+	   Byte 2 Bit 7: Error bit. Indicates that an uncorrectable error
+	   occurred during reception of this block.
+	   Bit 6: Corrected bit. Indicates that an error was
+	   corrected for this data block.
+	   Bits 5-3: Received Offset. Indicates the offset received
+	   by the sync system.
+	   Bits 2-0: Offset Name. Indicates the offset applied to this data.
+
+	   SAA6588 byte order is Status-MSB-LSB, so we have to swap the
+	   first and the last of the 3 bytes block.
+	 */
+
+	tmp = tmpbuf[2];
+	tmpbuf[2] = tmpbuf[0];
+	tmpbuf[0] = tmp;
+
+	tmp = blocknum;
+	tmp |= blocknum << 3;	/* Received offset == Offset Name (OK ?) */
+	if ((tmpbuf[2] & 0x03) == 0x03)
+		tmp |= 0x80;	/* uncorrectable error */
+	else if ((tmpbuf[2] & 0x03) != 0x00)
+		tmp |= 0x40;	/* corrected error */
+	tmpbuf[2] = tmp;	/* Is this enough ? Should we also check other bits ? */
+
+	spin_lock_irqsave(&s->lock, flags);
+	block_to_buf(s, tmpbuf);
+	spin_unlock_irqrestore(&s->lock, flags);
+	s->data_available_for_read = 1;
+	wake_up_interruptible(&s->read_queue);
+}
+
+static void saa6588_timer(unsigned long data)
+{
+	struct saa6588 *s = (struct saa6588 *)data;
+
+	schedule_work(&s->work);
+}
+
+static void saa6588_work(void *data)
+{
+	struct saa6588 *s = (struct saa6588 *)data;
+
+	saa6588_i2c_poll(s);
+	mod_timer(&s->timer, jiffies + HZ / 50);	/* 20 msec */
+}
+
+static int saa6588_configure(struct saa6588 *s)
+{
+	unsigned char buf[3];
+	int rc;
+
+	buf[0] = cSyncRestart;
+	if (rbds)
+		buf[0] |= cProcessingModeRBDS;
+
+	buf[1] = cFlywheelDefault;
+	switch (plvl) {
+	case 0:
+		buf[1] |= cPauseLevel_11mV;
+		break;
+	case 1:
+		buf[1] |= cPauseLevel_17mV;
+		break;
+	case 2:
+		buf[1] |= cPauseLevel_27mV;
+		break;
+	case 3:
+		buf[1] |= cPauseLevel_43mV;
+		break;
+	default:		/* nothing */
+		break;
+	}
+
+	buf[2] = cQualityDetectDefault | cSelectOscFreqON;
+
+	switch (xtal) {
+	case 0:
+		buf[2] |= cOscFreq_4332kHz;
+		break;
+	case 1:
+		buf[2] |= cOscFreq_8664kHz;
+		break;
+	case 2:
+		buf[2] |= cOscFreq_12996kHz;
+		break;
+	case 3:
+		buf[2] |= cOscFreq_17328kHz;
+		break;
+	default:		/* nothing */
+		break;
+	}
+
+	dprintk(PREFIX "writing: 0w=0x%02x 1w=0x%02x 2w=0x%02x\n",
+		buf[0], buf[1], buf[2]);
+
+	if (3 != (rc = i2c_master_send(&s->client, buf, 3)))
+		printk(PREFIX "i2c i/o error: rc == %d (should be 3)\n", rc);
+
+	return 0;
+}
+
+/* ---------------------------------------------------------------------- */
+
+static int saa6588_attach(struct i2c_adapter *adap, int addr, int kind)
+{
+	struct saa6588 *s;
+	client_template.adapter = adap;
+	client_template.addr = addr;
+
+	printk(PREFIX "chip found @ 0x%x\n", addr << 1);
+
+	if (NULL == (s = kmalloc(sizeof(*s), GFP_KERNEL)))
+		return -ENOMEM;
+
+	s->buf_size = bufblocks * 3;
+
+	if (NULL == (s->buffer = kmalloc(s->buf_size, GFP_KERNEL))) {
+		kfree(s);
+		return -ENOMEM;
+	}
+	s->client = client_template;
+	s->block_count = 0;
+	s->wr_index = 0;
+	s->rd_index = 0;
+	s->last_blocknum = 0xff;
+	init_waitqueue_head(&s->read_queue);
+	s->data_available_for_read = 0;
+	i2c_set_clientdata(&s->client, s);
+	i2c_attach_client(&s->client);
+
+	saa6588_configure(s);
+
+	/* start polling via eventd */
+	INIT_WORK(&s->work, saa6588_work, s);
+	init_timer(&s->timer);
+	s->timer.function = saa6588_timer;
+	s->timer.data = (unsigned long)s;
+	schedule_work(&s->work);
+
+	return 0;
+}
+
+static int saa6588_probe(struct i2c_adapter *adap)
+{
+#ifdef I2C_CLASS_TV_ANALOG
+	if (adap->class & I2C_CLASS_TV_ANALOG)
+		return i2c_probe(adap, &addr_data, saa6588_attach);
+#else
+	switch (adap->id) {
+	case I2C_ALGO_BIT | I2C_HW_B_BT848:
+	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
+	case I2C_ALGO_SAA7134:
+		return i2c_probe(adap, &addr_data, saa6588_attach);
+		break;
+	}
+#endif
+	return 0;
+}
+
+static int saa6588_detach(struct i2c_client *client)
+{
+	struct saa6588 *s = i2c_get_clientdata(client);
+
+	del_timer_sync(&s->timer);
+	flush_scheduled_work();
+
+	i2c_detach_client(client);
+	kfree(s->buffer);
+	kfree(s);
+	return 0;
+}
+
+static int saa6588_command(struct i2c_client *client, unsigned int cmd,
+							void *arg)
+{
+	struct saa6588 *s = i2c_get_clientdata(client);
+	struct rds_command *a = (struct rds_command *)arg;
+
+	switch (cmd) {
+		/* --- open() for /dev/radio --- */
+	case RDS_CMD_OPEN:
+		a->result = 0;	/* return error if chip doesn't work ??? */
+		break;
+		/* --- close() for /dev/radio --- */
+	case RDS_CMD_CLOSE:
+		s->data_available_for_read = 1;
+		wake_up_interruptible(&s->read_queue);
+		a->result = 0;
+		break;
+		/* --- read() for /dev/radio --- */
+	case RDS_CMD_READ:
+		read_from_buf(s, a);
+		break;
+		/* --- poll() for /dev/radio --- */
+	case RDS_CMD_POLL:
+		a->result = 0;
+		if (s->data_available_for_read) {
+			a->result |= POLLIN | POLLRDNORM;
+		}
+		poll_wait(a->instance, &s->read_queue, a->event_list);
+		break;
+
+	default:
+		/* nothing */
+		break;
+	}
+	return 0;
+}
+
+/* ----------------------------------------------------------------------- */
+
+static struct i2c_driver driver = {
+	.owner = THIS_MODULE,
+	.name = "i2c saa6588 driver",
+	.id = -1,		/* FIXME */
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = saa6588_probe,
+	.detach_client = saa6588_detach,
+	.command = saa6588_command,
+};
+
+static struct i2c_client client_template = {
+	I2C_DEVNAME("saa6588"),
+	.flags = I2C_CLIENT_ALLOW_USE,
+	.driver = &driver,
+};
+
+static int __init saa6588_init_module(void)
+{
+	return i2c_add_driver(&driver);
+}
+
+static void __exit saa6588_cleanup_module(void)
+{
+	i2c_del_driver(&driver);
+}
+
+module_init(saa6588_init_module);
+module_exit(saa6588_cleanup_module);
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */

--=_431cb7f8.+hkXl/Cs30aAoLu+FSPBC6V+kUv3mKQEMqN8ZIuVqnXcRMXa--
