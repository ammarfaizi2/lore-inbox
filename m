Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWANCJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWANCJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWANCJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:09:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14866 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030382AbWANCJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:09:03 -0500
Date: Sat, 14 Jan 2006 03:09:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Michael Krufky <mkrufky@gmail.com>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/media/dvb/: possible cleanups
Message-ID: <20060114020902.GX29663@stusta.de>
References: <20060107181258.GM3774@stusta.de> <37219a840601071042m157d1bb7k4a18105e038e9fad@mail.gmail.com> <1136848727.6782.75.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1136848727.6782.75.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 09:18:47PM -0200, Mauro Carvalho Chehab wrote:
> Adrian,
> Em Sáb, 2006-01-07 às 13:42 -0500, Michael Krufky escreveu:
> > On 1/7/06, Adrian Bunk <bunk@stusta.de> wrote:
> 
> > Adrian,
> > 
> > At first glance, I already see many collisions with pending
> > patchsets...  Mauro is getting ready to push a whole bunch of patches
> > onto the v4l-dvb git tree.
> >
> > Could you please wait until after those get merged?
> > 
> > Also, I'm not sure about some of the changes here... Hopefully some of
> > the other DVB guys will have some comments.  I think it's better to
> > postphone reviewing this until after we merge our new v4l / dvb stuff.
> > 
> 	Patches applied and already available at 2.6.15-git.

Updated patch below (without the dst parts).

cu
Adrian


<--  snip  -->


This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global functions:
  - b2c2/flexcop-dma.c: flexcop_dma_control_packet_irq()
  - b2c2/flexcop-dma.c: flexcop_dma_config_packet_count()

Please review which of these changes do make sense and which conflict 
with pending patches.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
 drivers/media/dvb/b2c2/flexcop-common.h      |    2 -
 drivers/media/dvb/b2c2/flexcop-dma.c         |    4 ++
 drivers/media/dvb/b2c2/flexcop-misc.c        |    6 ++--
 drivers/media/dvb/b2c2/flexcop-reg.h         |    4 --
 drivers/media/dvb/dvb-usb/cxusb.c            |    8 ++---
 drivers/media/dvb/dvb-usb/dvb-usb-firmware.c |    8 +++--
 drivers/media/dvb/dvb-usb/dvb-usb.h          |    1 
 drivers/media/dvb/dvb-usb/vp702x.c           |    6 ++--
 drivers/media/dvb/dvb-usb/vp702x.h           |    2 -
 drivers/media/dvb/ttpci/av7110.h             |    2 -
 drivers/media/dvb/ttpci/av7110_ir.c          |   26 +++++++++----------
 11 files changed, 33 insertions(+), 36 deletions(-)

--- linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-common.h.old	2006-01-07 16:49:18.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-common.h	2006-01-07 16:49:28.000000000 +0100
@@ -116,11 +116,9 @@
 
 int flexcop_dma_control_timer_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff);
 int flexcop_dma_control_size_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff);
-int flexcop_dma_control_packet_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff);
 int flexcop_dma_config(struct flexcop_device *fc, struct flexcop_dma *dma, flexcop_dma_index_t dma_idx);
 int flexcop_dma_xfer_control(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, flexcop_dma_addr_index_t index, int onoff);
 int flexcop_dma_config_timer(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, u8 cycles);
-int flexcop_dma_config_packet_count(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, u8 packets);
 
 /* from flexcop-eeprom.c */
 /* the PCI part uses this call to get the MAC address, the USB part has its own */
--- linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-dma.c.old	2006-01-07 16:49:37.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-dma.c	2006-01-07 16:50:25.000000000 +0100
@@ -169,6 +169,8 @@
 }
 EXPORT_SYMBOL(flexcop_dma_config_timer);
 
+#if 0
+
 /* packet IRQ does not exist in FCII or FCIIb - according to data book and tests */
 int flexcop_dma_control_packet_irq(struct flexcop_device *fc,
 		flexcop_dma_index_t no,
@@ -204,3 +206,5 @@
 	return 0;
 }
 EXPORT_SYMBOL(flexcop_dma_config_packet_count);
+
+#endif  /*  0  */
--- linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-reg.h.old	2006-01-07 16:51:05.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-reg.h	2006-01-07 16:51:38.000000000 +0100
@@ -16,8 +16,6 @@
 	FLEXCOP_III,
 } flexcop_revision_t;
 
-extern const char *flexcop_revision_names[];
-
 typedef enum {
 	FC_UNK = 0,
 	FC_AIR_DVB,
@@ -34,8 +32,6 @@
 	FC_PCI,
 } flexcop_bus_t;
 
-extern const char *flexcop_device_names[];
-
 /* FlexCop IBI Registers */
 #if defined(__LITTLE_ENDIAN)
 	#include "flexcop_ibi_value_le.h"
--- linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-misc.c.old	2006-01-07 16:48:00.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-misc.c	2006-01-07 16:51:27.000000000 +0100
@@ -36,14 +36,14 @@
 	/* bus parts have to decide if hw pid filtering is used or not. */
 }
 
-const char *flexcop_revision_names[] = {
+static const char *flexcop_revision_names[] = {
 	"Unkown chip",
 	"FlexCopII",
 	"FlexCopIIb",
 	"FlexCopIII",
 };
 
-const char *flexcop_device_names[] = {
+static const char *flexcop_device_names[] = {
 	"Unkown device",
 	"Air2PC/AirStar 2 DVB-T",
 	"Air2PC/AirStar 2 ATSC 1st generation",
@@ -54,7 +54,7 @@
 	"Air2PC/AirStar 2 ATSC 3rd generation (HD5000)",
 };
 
-const char *flexcop_bus_names[] = {
+static const char *flexcop_bus_names[] = {
 	"USB",
 	"PCI",
 };
--- linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/dvb-usb-firmware.c.old	2006-01-07 16:56:27.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/dvb-usb-firmware.c	2006-01-07 16:57:06.000000000 +0100
@@ -24,6 +24,9 @@
 	{ .id = CYPRESS_FX2,     .name = "Cypress FX2",     .cpu_cs_register = 0xe600 },
 };
 
+static int dvb_usb_get_hexline(const struct firmware *fw, struct hexline *hx,
+			       int *pos);
+
 /*
  * load a firmware packet to the device
  */
@@ -111,7 +114,8 @@
 	return ret;
 }
 
-int dvb_usb_get_hexline(const struct firmware *fw, struct hexline *hx, int *pos)
+static int dvb_usb_get_hexline(const struct firmware *fw, struct hexline *hx,
+			       int *pos)
 {
 	u8 *b = (u8 *) &fw->data[*pos];
 	int data_offs = 4;
@@ -141,5 +145,3 @@
 
 	return *pos;
 }
-EXPORT_SYMBOL(dvb_usb_get_hexline);
-
--- linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/vp702x.h.old	2006-01-07 16:57:23.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/vp702x.h	2006-01-07 16:58:15.000000000 +0100
@@ -102,8 +102,6 @@
 extern struct dvb_frontend * vp702x_fe_attach(struct dvb_usb_device *d);
 
 extern int vp702x_usb_inout_op(struct dvb_usb_device *d, u8 *o, int olen, u8 *i, int ilen, int msec);
-extern int vp702x_usb_inout_cmd(struct dvb_usb_device *d, u8 cmd, u8 *o, int olen, u8 *i, int ilen, int msec);
 extern int vp702x_usb_in_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen);
-extern int vp702x_usb_out_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen);
 
 #endif
--- linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/vp702x.c.old	2006-01-07 16:57:37.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/vp702x.c	2006-01-07 16:58:27.000000000 +0100
@@ -53,7 +53,8 @@
 	return ret;
 }
 
-int vp702x_usb_out_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen)
+static int vp702x_usb_out_op(struct dvb_usb_device *d, u8 req, u16 value,
+			     u16 index, u8 *b, int blen)
 {
 	deb_xfer("out: req. %x, val: %x, ind: %x, buffer: ",req,value,index);
 	debug_dump(b,blen,deb_xfer);
@@ -88,7 +89,8 @@
 	return ret;
 }
 
-int vp702x_usb_inout_cmd(struct dvb_usb_device *d, u8 cmd, u8 *o, int olen, u8 *i, int ilen, int msec)
+static int vp702x_usb_inout_cmd(struct dvb_usb_device *d, u8 cmd, u8 *o,
+				int olen, u8 *i, int ilen, int msec)
 {
 	u8 bout[olen+2];
 	u8 bin[ilen+1];
--- linux-2.6.15-mm2-full/drivers/media/dvb/ttpci/av7110.h.old	2006-01-07 16:59:33.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/ttpci/av7110.h	2006-01-07 16:59:39.000000000 +0100
@@ -261,8 +261,6 @@
 extern int ChangePIDs(struct av7110 *av7110, u16 vpid, u16 apid, u16 ttpid,
 		       u16 subpid, u16 pcrpid);
 
-extern int av7110_setup_irc_config (struct av7110 *av7110, u32 ir_config);
-
 extern int av7110_ir_init(struct av7110 *av7110);
 extern void av7110_ir_exit(struct av7110 *av7110);
 
--- linux-2.6.15-mm2-full/drivers/media/dvb/ttpci/av7110_ir.c.old	2006-01-07 16:59:47.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/ttpci/av7110_ir.c	2006-01-07 17:00:21.000000000 +0100
@@ -155,6 +155,19 @@
 }
 
 
+static int av7110_setup_irc_config(struct av7110 *av7110, u32 ir_config)
+{
+	int ret = 0;
+
+	dprintk(4, "%p\n", av7110);
+	if (av7110) {
+		ret = av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, SetIR, 1, ir_config);
+		av7110->ir_config = ir_config;
+	}
+	return ret;
+}
+
+
 static int av7110_ir_write_proc(struct file *file, const char __user *buffer,
 				unsigned long count, void *data)
 {
@@ -187,19 +200,6 @@
 }
 
 
-int av7110_setup_irc_config(struct av7110 *av7110, u32 ir_config)
-{
-	int ret = 0;
-
-	dprintk(4, "%p\n", av7110);
-	if (av7110) {
-		ret = av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, SetIR, 1, ir_config);
-		av7110->ir_config = ir_config;
-	}
-	return ret;
-}
-
-
 static void ir_handler(struct av7110 *av7110, u32 ircom)
 {
 	dprintk(4, "ircommand = %08x\n", ircom);

--- linux-2.6.15-mm3-full/drivers/media/dvb/dvb-usb/dvb-usb.h.old	2006-01-14 01:04:34.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/media/dvb/dvb-usb/dvb-usb.h	2006-01-14 01:04:50.000000000 +0100
@@ -341,7 +341,6 @@
 	u8 data[255];
 	u8 chk;
 };
-extern int dvb_usb_get_hexline(const struct firmware *, struct hexline *, int *);
 extern int usb_cypress_load_firmware(struct usb_device *udev, const struct firmware *fw, int type);
 
 #endif
--- linux-2.6.15-mm3-full/drivers/media/dvb/dvb-usb/cxusb.c.old	2006-01-14 01:02:27.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/media/dvb/dvb-usb/cxusb.c	2006-01-14 01:03:28.000000000 +0100
@@ -184,7 +184,7 @@
 	return 0;
 }
 
-struct dvb_usb_rc_key dvico_mce_rc_keys[] = {
+static struct dvb_usb_rc_key dvico_mce_rc_keys[] = {
 	{ 0xfe, 0x02, KEY_TV },
 	{ 0xfe, 0x0e, KEY_MP3 },
 	{ 0xfe, 0x1a, KEY_DVD },
@@ -253,7 +253,7 @@
 	return 0;
 }
 
-struct cx22702_config cxusb_cx22702_config = {
+static struct cx22702_config cxusb_cx22702_config = {
 	.demod_address = 0x63,
 
 	.output_mode = CX22702_PARALLEL_OUTPUT,
@@ -262,13 +262,13 @@
 	.pll_set  = dvb_usb_pll_set_i2c,
 };
 
-struct lgdt330x_config cxusb_lgdt330x_config = {
+static struct lgdt330x_config cxusb_lgdt330x_config = {
 	.demod_address = 0x0e,
 	.demod_chip    = LGDT3303,
 	.pll_set       = dvb_usb_pll_set_i2c,
 };
 
-struct mt352_config cxusb_dee1601_config = {
+static struct mt352_config cxusb_dee1601_config = {
 	.demod_address = 0x0f,
 	.demod_init    = cxusb_dee1601_demod_init,
 	.pll_set       = dvb_usb_pll_set,

