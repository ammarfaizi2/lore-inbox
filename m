Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVCVC2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVCVC2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVCVC2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:28:13 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:63883 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262357AbVCVBgu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:50 -0500
Message-Id: <20050322013457.030560000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:53 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Content-Disposition: inline; filename=dvb-cleanup-makestatic.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 20/48] cleanups, make stuff static
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
o make needlessly global code static
o remove the following EXPORT_SYMBOL'ed but unused function:
  - bt8xx/bt878.c: bt878_find_by_i2c_adap
o remove the following unused global functions:
  - dvb-core/dvb_demux.c: dmx_get_demuxes
  - dvb-core/dvb_demux.c: dvb_set_crc32
o remove the following unneeded EXPORT_SYMBOL's:
  - dvb-core/dvb_demux.c: dvb_dmx_swfilter_packet
  - dvb-core/dvb_demux.c: dvbdmx_connect_frontend
  - dvb-core/dvb_demux.c: dvbdmx_disconnect_frontend
  - dvb-core/dvbdev.c: dvb_class

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 b2c2/b2c2-common.c         |    2 +-
 b2c2/skystar2.c            |    2 +-
 bt8xx/bt878.c              |   15 ---------------
 bt8xx/dst_priv.h           |    1 -
 dibusb/dvb-dibusb-core.c   |    2 +-
 dibusb/dvb-dibusb-fe-i2c.c |    2 +-
 dibusb/dvb-dibusb.h        |    2 --
 dvb-core/demux.h           |    4 ----
 dvb-core/dvb_demux.c       |   36 ++++++------------------------------
 dvb-core/dvb_demux.h       |    4 ----
 dvb-core/dvb_net.c         |    4 ++--
 dvb-core/dvbdev.c          |    3 +--
 frontends/tda10021.c       |    2 +-
 ttpci/budget-av.c          |    4 ++--
 ttpci/budget-patch.c       |    2 +-
 15 files changed, 17 insertions(+), 68 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/b2c2/b2c2-common.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/b2c2/b2c2-common.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/b2c2/b2c2-common.c	2005-03-22 00:16:28.000000000 +0100
@@ -158,7 +158,7 @@ static int samsung_tdtc9251dh0_demod_ini
 	return 0;
 }
 
-int samsung_tdtc9251dh0_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pllbuf)
+static int samsung_tdtc9251dh0_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pllbuf)
 {
 	u32 div;
 	unsigned char bs = 0;
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/b2c2/skystar2.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/b2c2/skystar2.c	2005-03-22 00:16:14.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/b2c2/skystar2.c	2005-03-22 00:16:28.000000000 +0100
@@ -2352,7 +2352,7 @@ static int samsung_tdtc9251dh0_demod_ini
 	return 0;
 }
 
-int samsung_tdtc9251dh0_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pllbuf)
+static int samsung_tdtc9251dh0_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pllbuf)
 {
 	u32 div;
 	unsigned char bs = 0;
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/bt8xx/bt878.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/bt8xx/bt878.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/bt8xx/bt878.c	2005-03-22 00:16:28.000000000 +0100
@@ -381,21 +381,6 @@ bt878_device_control(struct bt878 *bt, u
 
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
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/bt8xx/dst_priv.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/bt8xx/dst_priv.h	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/bt8xx/dst_priv.h	2005-03-22 00:16:28.000000000 +0100
@@ -34,4 +34,3 @@ struct bt878;
 
 int bt878_device_control(struct bt878 *bt, unsigned int cmd, union dst_gpio_packet *mp);
 
-struct bt878 *bt878_find_by_i2c_adap(struct i2c_adapter *adap);
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:16:19.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:16:28.000000000 +0100
@@ -505,7 +505,7 @@ static void dibusb_disconnect(struct usb
 }
 
 /* usb specific object needed to register this driver with the usb subsystem */
-struct usb_driver dibusb_driver = {
+static struct usb_driver dibusb_driver = {
 	.owner		= THIS_MODULE,
 	.name		= DRIVER_DESC,
 	.probe 		= dibusb_probe,
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-03-22 00:14:35.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-03-22 00:16:28.000000000 +0100
@@ -14,7 +14,7 @@
 
 #include <linux/usb.h>
 
-int dibusb_i2c_msg(struct usb_dibusb *dib, u8 addr,
+static int dibusb_i2c_msg(struct usb_dibusb *dib, u8 addr,
 			  u8 *wbuf, u16 wlen, u8 *rbuf, u16 rlen)
 {
 	u8 sndbuf[wlen+4]; /* lead(1) devaddr,direction(1) addr(2) data(wlen) (len(2) (when reading)) */
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-03-22 00:16:19.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-03-22 00:16:28.000000000 +0100
@@ -210,8 +210,6 @@ int dibusb_remote_exit(struct usb_dibusb
 int dibusb_remote_init(struct usb_dibusb *dib);
 
 /* dvb-dibusb-fe-i2c.c */
-int dibusb_i2c_msg(struct usb_dibusb *dib, u8 addr,
-		u8 *wbuf, u16 wlen, u8 *rbuf, u16 rlen);
 int dibusb_fe_init(struct usb_dibusb* dib);
 int dibusb_fe_exit(struct usb_dibusb *dib);
 int dibusb_i2c_init(struct usb_dibusb *dib);
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/demux.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/demux.h	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/demux.h	2005-03-22 00:16:28.000000000 +0100
@@ -298,8 +298,4 @@ struct dmx_demux {
 
 #define DMX_DIR_ENTRY(list) list_entry(list, struct dmx_demux, reg_list)
 
-int dmx_register_demux (struct dmx_demux* demux);
-int dmx_unregister_demux (struct dmx_demux* demux);
-struct list_head* dmx_get_demuxes (void);
-
 #endif /* #ifndef __DEMUX_H */
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_demux.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvb_demux.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_demux.c	2005-03-22 00:16:28.000000000 +0100
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
 
@@ -66,14 +66,6 @@ int dmx_unregister_demux(struct dmx_demu
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
@@ -105,19 +97,6 @@ static inline u8 payload(const u8 *tsp)
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
@@ -424,7 +403,7 @@ static inline void dvb_dmx_swfilter_pack
 	((f)->feed.ts.is_filtering) &&					\
 	(((f)->ts_type & (TS_PACKET|TS_PAYLOAD_ONLY)) == TS_PACKET))
 
-void dvb_dmx_swfilter_packet(struct dvb_demux *demux, const u8 *buf)
+static void dvb_dmx_swfilter_packet(struct dvb_demux *demux, const u8 *buf)
 {
 	struct dvb_demux_feed *feed;
 	struct list_head *pos, *head=&demux->feed_list;
@@ -452,7 +431,6 @@ void dvb_dmx_swfilter_packet(struct dvb_
 			feed->cb.ts(buf, 188, NULL, 0, &feed->feed.ts, DMX_OK);
 	}
 }
-EXPORT_SYMBOL(dvb_dmx_swfilter_packet);
 
 void dvb_dmx_swfilter_packets(struct dvb_demux *demux, const u8 *buf, size_t count)
 {
@@ -1190,7 +1168,7 @@ static struct list_head * dvbdmx_get_fro
 }
 
 
-int dvbdmx_connect_frontend(struct dmx_demux *demux, struct dmx_frontend *frontend)
+static int dvbdmx_connect_frontend(struct dmx_demux *demux, struct dmx_frontend *frontend)
 {
 	struct dvb_demux *dvbdemux = (struct dvb_demux *) demux;
 
@@ -1204,10 +1182,9 @@ int dvbdmx_connect_frontend(struct dmx_d
 	up(&dvbdemux->mutex);
 	return 0;
 }
-EXPORT_SYMBOL(dvbdmx_connect_frontend);
 
 
-int dvbdmx_disconnect_frontend(struct dmx_demux *demux)
+static int dvbdmx_disconnect_frontend(struct dmx_demux *demux)
 {
 	struct dvb_demux *dvbdemux = (struct dvb_demux *) demux;
 
@@ -1218,7 +1195,6 @@ int dvbdmx_disconnect_frontend(struct dm
 	up(&dvbdemux->mutex);
 	return 0;
 }
-EXPORT_SYMBOL(dvbdmx_disconnect_frontend);
 
 
 static int dvbdmx_get_pes_pids(struct dmx_demux *demux, u16 *pids)
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_demux.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvb_demux.h	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_demux.h	2005-03-22 00:16:28.000000000 +0100
@@ -138,12 +138,8 @@ struct dvb_demux {
 
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
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_net.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvb_net.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_net.c	2005-03-22 00:16:28.000000000 +0100
@@ -217,12 +217,12 @@ static unsigned short dvb_net_eth_type_t
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
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvbdev.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvbdev.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvbdev.c	2005-03-22 00:16:28.000000000 +0100
@@ -55,8 +55,7 @@ static const char * const dnames[] = {
 #define nums2minor(num,type,id)  ((num << 6) | (id << 4) | type)
 #define MAX_DVB_MINORS           (DVB_MAX_IDS*64)
 
-struct class_simple *dvb_class;
-EXPORT_SYMBOL(dvb_class);
+static struct class_simple *dvb_class;
 
 static struct dvb_device* dvbdev_find_device (int minor)
 {
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda10021.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/tda10021.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda10021.c	2005-03-22 00:16:28.000000000 +0100
@@ -61,7 +61,7 @@ static int verbose;
 
 #define FIN (XIN >> 4)
 
-int tda10021_inittab_size = 0x40;
+static int tda10021_inittab_size = 0x40;
 static u8 tda10021_inittab[0x40]=
 {
 	0x73, 0x6a, 0x23, 0x0a, 0x02, 0x37, 0x77, 0x1a,
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/budget-av.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/budget-av.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/budget-av.c	2005-03-22 00:16:28.000000000 +0100
@@ -59,7 +59,7 @@ struct budget_av {
 	struct dvb_ca_en50221 ca;
 };
 
-int enable_ci = 0;
+static int enable_ci = 0;
 
 
 /****************************************************************************
@@ -658,7 +658,7 @@ static int philips_tu1216_request_firmwa
 	return request_firmware(fw, name, &budget->dev->pci->dev);
 }
 
-struct tda1004x_config philips_tu1216_config = {
+static struct tda1004x_config philips_tu1216_config = {
 
 	.demod_address = 0x8,
 	.invert = 1,
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/budget-patch.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/budget-patch.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/budget-patch.c	2005-03-22 00:16:28.000000000 +0100
@@ -406,7 +406,7 @@ static int grundig_29504_451_pll_set(str
 	return 0;
 }
 
-struct tda8083_config grundig_29504_451_config = {
+static struct tda8083_config grundig_29504_451_config = {
 	.demod_address = 0x68,
 	.pll_set = grundig_29504_451_pll_set,
 };

--

