Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbUKVQa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUKVQa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUKVQaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:30:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14864 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262107AbUKVPw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:52:26 -0500
Date: Mon, 22 Nov 2004 16:52:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/w1/dscore: fix the inline mess
Message-ID: <20041122155223.GF19419@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
  CC      drivers/w1/ds_w1_bridge.o
drivers/w1/ds_w1_bridge.c: In function `ds9490r_touch_bit':
drivers/w1/dscore.h:154: sorry, unimplemented: inlining failed in call 
to 'ds_touch_bit': function body not available
drivers/w1/ds_w1_bridge.c:37: sorry, unimplemented: called from here
make[2]: *** [drivers/w1/ds_w1_bridge.o] Error 1

<--  snip  -->


The patch below removes inline's in the following cases:
- inline at the function prototype but not at the actual function
- EXPORT_SYMBOL'ed inline functions


diffstat output:
 drivers/w1/dscore.c |   40 ++++++++++++++++++++--------------------
 drivers/w1/dscore.h |   34 +++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 37 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.h.old	2004-11-22 15:04:42.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.h	2004-11-22 15:08:14.000000000 +0100
@@ -151,23 +151,23 @@
 
 };
 
-inline int ds_touch_bit(struct ds_device *, u8, u8 *);
-inline int ds_read_byte(struct ds_device *, u8 *);
-inline int ds_read_bit(struct ds_device *, u8 *);
-inline int ds_write_byte(struct ds_device *, u8);
-inline int ds_write_bit(struct ds_device *, u8);
-inline int ds_start_pulse(struct ds_device *, int);
-inline int ds_set_speed(struct ds_device *, int);
-inline int ds_reset(struct ds_device *, struct ds_status *);
-inline int ds_detect(struct ds_device *, struct ds_status *);
-inline int ds_stop_pulse(struct ds_device *, int);
-inline int ds_send_data(struct ds_device *, unsigned char *, int);
-inline int ds_recv_data(struct ds_device *, unsigned char *, int);
-inline int ds_recv_status(struct ds_device *, struct ds_status *);
-inline struct ds_device * ds_get_device(void);
-inline void ds_put_device(struct ds_device *);
-inline int ds_write_block(struct ds_device *, u8 *, int);
-inline int ds_read_block(struct ds_device *, u8 *, int);
+int ds_touch_bit(struct ds_device *, u8, u8 *);
+int ds_read_byte(struct ds_device *, u8 *);
+int ds_read_bit(struct ds_device *, u8 *);
+int ds_write_byte(struct ds_device *, u8);
+int ds_write_bit(struct ds_device *, u8);
+int ds_start_pulse(struct ds_device *, int);
+int ds_set_speed(struct ds_device *, int);
+int ds_reset(struct ds_device *, struct ds_status *);
+int ds_detect(struct ds_device *, struct ds_status *);
+int ds_stop_pulse(struct ds_device *, int);
+int ds_send_data(struct ds_device *, unsigned char *, int);
+int ds_recv_data(struct ds_device *, unsigned char *, int);
+int ds_recv_status(struct ds_device *, struct ds_status *);
+struct ds_device * ds_get_device(void);
+void ds_put_device(struct ds_device *);
+int ds_write_block(struct ds_device *, u8 *, int);
+int ds_read_block(struct ds_device *, u8 *, int);
 
 #endif /* __DSCORE_H */
 
--- linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.c.old	2004-11-22 15:05:19.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/dscore.c	2004-11-22 15:07:50.000000000 +0100
@@ -35,26 +35,26 @@
 int ds_probe(struct usb_interface *, const struct usb_device_id *);
 void ds_disconnect(struct usb_interface *);
 
-inline int ds_touch_bit(struct ds_device *, u8, u8 *);
-inline int ds_read_byte(struct ds_device *, u8 *);
-inline int ds_read_bit(struct ds_device *, u8 *);
-inline int ds_write_byte(struct ds_device *, u8);
-inline int ds_write_bit(struct ds_device *, u8);
-inline int ds_start_pulse(struct ds_device *, int);
-inline int ds_set_speed(struct ds_device *, int);
-inline int ds_reset(struct ds_device *, struct ds_status *);
-inline int ds_detect(struct ds_device *, struct ds_status *);
-inline int ds_stop_pulse(struct ds_device *, int);
-inline int ds_send_data(struct ds_device *, unsigned char *, int);
-inline int ds_recv_data(struct ds_device *, unsigned char *, int);
-inline int ds_recv_status(struct ds_device *, struct ds_status *);
-inline struct ds_device * ds_get_device(void);
-inline void ds_put_device(struct ds_device *);
+int ds_touch_bit(struct ds_device *, u8, u8 *);
+int ds_read_byte(struct ds_device *, u8 *);
+int ds_read_bit(struct ds_device *, u8 *);
+int ds_write_byte(struct ds_device *, u8);
+int ds_write_bit(struct ds_device *, u8);
+int ds_start_pulse(struct ds_device *, int);
+int ds_set_speed(struct ds_device *, int);
+int ds_reset(struct ds_device *, struct ds_status *);
+int ds_detect(struct ds_device *, struct ds_status *);
+int ds_stop_pulse(struct ds_device *, int);
+int ds_send_data(struct ds_device *, unsigned char *, int);
+int ds_recv_data(struct ds_device *, unsigned char *, int);
+int ds_recv_status(struct ds_device *, struct ds_status *);
+struct ds_device * ds_get_device(void);
+void ds_put_device(struct ds_device *);
 
 static inline void ds_dump_status(unsigned char *, unsigned char *, int);
-static inline int ds_send_control(struct ds_device *, u16, u16);
-static inline int ds_send_control_mode(struct ds_device *, u16, u16);
-static inline int ds_send_control_cmd(struct ds_device *, u16, u16);
+static int ds_send_control(struct ds_device *, u16, u16);
+static int ds_send_control_mode(struct ds_device *, u16, u16);
+static int ds_send_control_cmd(struct ds_device *, u16, u16);
 
 
 static struct usb_driver ds_driver = {
@@ -503,7 +503,7 @@
 	return 0;
 }
 
-inline int ds_read_block(struct ds_device *dev, u8 *buf, int len)
+int ds_read_block(struct ds_device *dev, u8 *buf, int len)
 {
 	struct ds_status st;
 	int err;
@@ -529,7 +529,7 @@
 	return err;
 }
 
-inline int ds_write_block(struct ds_device *dev, u8 *buf, int len)
+int ds_write_block(struct ds_device *dev, u8 *buf, int len)
 {
 	int err;
 	struct ds_status st;

