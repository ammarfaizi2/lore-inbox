Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVBKQe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVBKQe5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 11:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVBKQe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 11:34:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12810 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261175AbVBKQel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 11:34:41 -0500
Date: Fri, 11 Feb 2005 17:34:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] DVB: possible cleanups
Message-ID: <20050211163436.GB2958@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before I'm getting flamed to death:
This patch contains possible cleanups. If parts of this patch conflict 
with pending changes these parts of my patch have to be dropped.

This patch contains the following possible cleanups:
- make needlessly global code static
- remove the following EXPORT_SYMBOL'ed but unused function:
  - bt8xx/bt878.c: bt878_find_by_i2c_adap
- remove the following unused global functions:
  - dvb-core/dvb_demux.c: dmx_get_demuxes
  - dvb-core/dvb_demux.c: dvb_set_crc32
- remove the following unneeded EXPORT_SYMBOL's:
  - dvb-core/dvb_demux.c: dvb_dmx_swfilter_packet
  - dvb-core/dvb_demux.c: dvbdmx_connect_frontend
  - dvb-core/dvb_demux.c: dvbdmx_disconnect_frontend
  - dvb-core/dvbdev.c: dvb_class

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/b2c2/b2c2-common.c.old	2005-02-11 00:37:31.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/b2c2/b2c2-common.c	2005-02-11 00:37:45.000000000 +0100
@@ -158,7 +158,7 @@
 	return 0;
 }
 
-int samsung_tdtc9251dh0_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pllbuf)
+static int samsung_tdtc9251dh0_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pllbuf)
 {
 	u32 div;
 	unsigned char bs = 0;
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/b2c2/skystar2.c.old	2005-02-11 00:37:55.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/b2c2/skystar2.c	2005-02-11 00:37:59.000000000 +0100
@@ -2356,7 +2356,7 @@
 	return 0;
 }
 
-int samsung_tdtc9251dh0_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pllbuf)
+static int samsung_tdtc9251dh0_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pllbuf)
 {
 	u32 div;
 	unsigned char bs = 0;
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/bt8xx/dst_priv.h.old	2005-02-11 00:39:13.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/bt8xx/dst_priv.h	2005-02-11 00:39:21.000000000 +0100
@@ -34,4 +34,3 @@
 
 int bt878_device_control(struct bt878 *bt, unsigned int cmd, union dst_gpio_packet *mp);
 
-struct bt878 *bt878_find_by_i2c_adap(struct i2c_adapter *adap);
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/bt8xx/bt878.c.old	2005-02-11 00:39:29.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/bt8xx/bt878.c	2005-02-11 00:39:37.000000000 +0100
@@ -381,21 +381,6 @@
 
 EXPORT_SYMBOL(bt878_device_control);
 
-struct bt878 *bt878_find_by_i2c_adap(struct i2c_adapter *adapter)
-{
-	unsigned int card_nr;
-	
-	printk("bt878 find by dvb adap: checking \"%s\"\n",adapter->name);
-	for (card_nr = 0; card_nr < bt878_num; card_nr++) {
-		if (bt878[card_nr].adapter == adapter)
-			return &bt878[card_nr];
-	}
-	printk("bt878 find by dvb adap: NOT found \"%s\"\n",adapter->name);
-	return NULL;
-}
-
-EXPORT_SYMBOL(bt878_find_by_i2c_adap);
-
 /***********************/
 /* PCI device handling */
 /***********************/
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dibusb/dvb-dibusb-core.c.old	2005-02-11 00:39:53.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-02-11 00:40:00.000000000 +0100
@@ -446,7 +446,7 @@
 }
 
 /* usb specific object needed to register this driver with the usb subsystem */
-struct usb_driver dibusb_driver = {
+static struct usb_driver dibusb_driver = {
 	.owner		= THIS_MODULE,
 	.name		= DRIVER_DESC,
 	.probe 		= dibusb_probe,
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dibusb/dvb-dibusb.h.old	2005-02-11 00:40:16.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-02-11 00:40:23.000000000 +0100
@@ -206,8 +206,6 @@
 int dibusb_remote_init(struct usb_dibusb *dib);
 
 /* dvb-dibusb-fe-i2c.c */
-int dibusb_i2c_msg(struct usb_dibusb *dib, u8 addr, 
-		u8 *wbuf, u16 wlen, u8 *rbuf, u16 rlen);
 int dibusb_fe_init(struct usb_dibusb* dib);
 int dibusb_fe_exit(struct usb_dibusb *dib);
 int dibusb_i2c_init(struct usb_dibusb *dib);
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c.old	2005-02-11 00:40:33.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-02-11 00:40:52.000000000 +0100
@@ -14,8 +14,8 @@
 
 #include <linux/usb.h>
 
-int dibusb_i2c_msg(struct usb_dibusb *dib, u8 addr, 
-		u8 *wbuf, u16 wlen, u8 *rbuf, u16 rlen)
+static int dibusb_i2c_msg(struct usb_dibusb *dib, u8 addr, 
+			  u8 *wbuf, u16 wlen, u8 *rbuf, u16 rlen)
 {
 	u8 sndbuf[wlen+4]; /* lead(1) devaddr,direction(1) addr(2) data(wlen) (len(2) (when reading)) */
 	/* write only ? */
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dvb-core/demux.h.old	2005-02-11 00:42:06.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dvb-core/demux.h	2005-02-11 00:43:13.000000000 +0100
@@ -298,9 +298,5 @@
 
 #define DMX_DIR_ENTRY(list) list_entry(list, struct dmx_demux, reg_list)
 
-int dmx_register_demux (struct dmx_demux* demux); 
-int dmx_unregister_demux (struct dmx_demux* demux); 
-struct list_head* dmx_get_demuxes (void); 
-
 #endif /* #ifndef __DEMUX_H */
 
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dvb-core/dvb_demux.h.old	2005-02-11 00:44:12.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dvb-core/dvb_demux.h	2005-02-11 00:45:34.000000000 +0100
@@ -138,13 +138,9 @@
 
 int dvb_dmx_init(struct dvb_demux *dvbdemux);
 int dvb_dmx_release(struct dvb_demux *dvbdemux);
-void dvb_dmx_swfilter_packet(struct dvb_demux *dvbdmx, const u8 *buf);
 void dvb_dmx_swfilter_packets(struct dvb_demux *dvbdmx, const u8 *buf, size_t count);
 void dvb_dmx_swfilter(struct dvb_demux *demux, const u8 *buf, size_t count);
 void dvb_dmx_swfilter_204(struct dvb_demux *demux, const u8 *buf, size_t count);
 
-int dvbdmx_connect_frontend(struct dmx_demux *demux, struct dmx_frontend *frontend);
-int dvbdmx_disconnect_frontend(struct dmx_demux *demux);
-
 #endif /* _DVB_DEMUX_H_ */
 
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dvb-core/dvb_demux.c.old	2005-02-11 00:42:20.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dvb-core/dvb_demux.c	2005-02-11 00:45:42.000000000 +0100
@@ -27,7 +27,7 @@
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/string.h>
-	#include <linux/crc32.h>
+#include <linux/crc32.h>
 #include <asm/uaccess.h>
 
 #include "dvb_demux.h"
@@ -39,17 +39,17 @@
 // #define DVB_DEMUX_SECTION_LOSS_LOG
 
 
-LIST_HEAD(dmx_muxs);
+static LIST_HEAD(dmx_muxs);
 
 
-int dmx_register_demux(struct dmx_demux *demux) 
+static int dmx_register_demux(struct dmx_demux *demux) 
 {
 	demux->users = 0;
 	list_add(&demux->reg_list, &dmx_muxs);
 	return 0;
 }
 
-int dmx_unregister_demux(struct dmx_demux* demux)
+static int dmx_unregister_demux(struct dmx_demux* demux)
 {
 	struct list_head *pos, *n, *head=&dmx_muxs;
 
@@ -66,14 +66,6 @@
 }
 
 
-struct list_head *dmx_get_demuxes(void)
-{
-	if (list_empty(&dmx_muxs))
-		return NULL;
-
-	return &dmx_muxs;
-}
-
 /******************************************************************************
  * static inlined helper functions
  ******************************************************************************/
@@ -105,19 +97,6 @@
 }
 
 
-void dvb_set_crc32(u8 *data, int length)
-{
-	u32 crc;
-
-	crc = crc32_be(~0, data, length);
-
-	data[length]   = (crc >> 24) & 0xff;
-	data[length+1] = (crc >> 16) & 0xff;
-	data[length+2] = (crc >>  8) & 0xff;
-	data[length+3] = (crc)       & 0xff;
-}
-
-
 static u32 dvb_dmx_crc32 (struct dvb_demux_feed *f, const u8 *src, size_t len)
 {
 	return (f->feed.sec.crc_val = crc32_be (f->feed.sec.crc_val, src, len));
@@ -424,7 +403,7 @@
 	((f)->feed.ts.is_filtering) &&					\
 	(((f)->ts_type & (TS_PACKET|TS_PAYLOAD_ONLY)) == TS_PACKET))
 
-void dvb_dmx_swfilter_packet(struct dvb_demux *demux, const u8 *buf)
+static void dvb_dmx_swfilter_packet(struct dvb_demux *demux, const u8 *buf)
 {
 	struct dvb_demux_feed *feed;
 	struct list_head *pos, *head=&demux->feed_list;
@@ -452,7 +431,6 @@
 			feed->cb.ts(buf, 188, NULL, 0, &feed->feed.ts, DMX_OK);
 	}
 }
-EXPORT_SYMBOL(dvb_dmx_swfilter_packet);
 
 void dvb_dmx_swfilter_packets(struct dvb_demux *demux, const u8 *buf, size_t count)
 {
@@ -1176,7 +1154,7 @@
 }
 
 
-int dvbdmx_connect_frontend(struct dmx_demux *demux, struct dmx_frontend *frontend)
+static int dvbdmx_connect_frontend(struct dmx_demux *demux, struct dmx_frontend *frontend)
 {
 	struct dvb_demux *dvbdemux=(struct dvb_demux *) demux;
 
@@ -1190,10 +1168,9 @@
 	up(&dvbdemux->mutex);
 	return 0;
 }
-EXPORT_SYMBOL(dvbdmx_connect_frontend);
 
 
-int dvbdmx_disconnect_frontend(struct dmx_demux *demux)
+static int dvbdmx_disconnect_frontend(struct dmx_demux *demux)
 {
 	struct dvb_demux *dvbdemux=(struct dvb_demux *) demux;
 
@@ -1204,7 +1181,6 @@
 	up(&dvbdemux->mutex);
 	return 0;
 }
-EXPORT_SYMBOL(dvbdmx_disconnect_frontend);
 
 
 static int dvbdmx_get_pes_pids(struct dmx_demux *demux, u16 *pids)
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dvb-core/dvb_net.c.old	2005-02-11 00:45:54.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dvb-core/dvb_net.c	2005-02-11 00:46:24.000000000 +0100
@@ -217,12 +217,12 @@
 #define ULE_TEST	0
 #define ULE_BRIDGED	1
 
-int ule_test_sndu( struct dvb_net_priv *p )
+static int ule_test_sndu( struct dvb_net_priv *p )
 {
 	return -1;
 }
 
-int ule_bridged_sndu( struct dvb_net_priv *p )
+static int ule_bridged_sndu( struct dvb_net_priv *p )
 {
 	/* BRIDGE SNDU handling sucks in draft-ietf-ipdvb-ule-03.txt.
 	 * This has to be the last extension header, otherwise it won't work.
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dvb-core/dvbdev.c.old	2005-02-11 00:46:39.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/dvb-core/dvbdev.c	2005-02-11 00:49:21.000000000 +0100
@@ -56,8 +56,7 @@
 #define nums2minor(num,type,id)  ((num << 6) | (id << 4) | type)
 #define MAX_DVB_MINORS           (DVB_MAX_IDS*64)
 
-struct class_simple *dvb_class;
-EXPORT_SYMBOL(dvb_class);
+static struct class_simple *dvb_class;
 
 static struct dvb_device* dvbdev_find_device (int minor)
 {
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/frontends/tda10021.c.old	2005-02-11 00:57:08.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/frontends/tda10021.c	2005-02-11 01:01:37.000000000 +0100
@@ -65,7 +65,7 @@
 
 #define FIN (XIN >> 4)
 
-int tda10021_inittab_size = 0x40;
+static int tda10021_inittab_size = 0x40;
 static u8 tda10021_inittab[0x40]=
 {
 	0x73, 0x6a, 0x23, 0x0a, 0x02, 0x37, 0x77, 0x1a,
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/ttpci/budget-av.c.old	2005-02-11 00:58:32.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/ttpci/budget-av.c	2005-02-11 00:58:56.000000000 +0100
@@ -59,7 +59,7 @@
 	struct dvb_ca_en50221 ca;
 };
 
-int enable_ci = 0;
+static int enable_ci = 0;
 
 
 /****************************************************************************
@@ -662,7 +662,7 @@
 	return request_firmware(fw, name, &budget->dev->pci->dev);
 }
 
-struct tda1004x_config philips_tu1216_config = {
+static struct tda1004x_config philips_tu1216_config = {
 
 	.demod_address = 0x8,
 	.invert = 1,
--- linux-2.6.11-rc3-mm2-full/drivers/media/dvb/ttpci/budget-patch.c.old	2005-02-11 00:59:15.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/dvb/ttpci/budget-patch.c	2005-02-11 00:59:24.000000000 +0100
@@ -406,7 +406,7 @@
 	return 0;
 }
 
-struct tda8083_config grundig_29504_451_config = {
+static struct tda8083_config grundig_29504_451_config = {
 	.demod_address = 0x68,
 	.pll_set = grundig_29504_451_pll_set,
 };

