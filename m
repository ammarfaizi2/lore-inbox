Return-Path: <linux-kernel-owner+w=401wt.eu-S937482AbWLKSk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937482AbWLKSk5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937471AbWLKSk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:40:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3928 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1763018AbWLKSku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:40:50 -0500
Date: Mon, 11 Dec 2006 19:40:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Thierry Merle <thierry.merle@free.fr>
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] usbvision: possible cleanups
Message-ID: <20061211184059.GD28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global functions static
- remove the unused EXPORT_SYMBOL's

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/usbvision/usbvision-core.c  |   33 +++++++++-------
 drivers/media/video/usbvision/usbvision-i2c.c   |    5 --
 drivers/media/video/usbvision/usbvision-video.c |    2 
 drivers/media/video/usbvision/usbvision.h       |    2 
 4 files changed, 21 insertions(+), 21 deletions(-)

--- linux-2.6.19-mm1/drivers/media/video/usbvision/usbvision-core.c.old	2006-12-11 18:08:43.000000000 +0100
+++ linux-2.6.19-mm1/drivers/media/video/usbvision/usbvision-core.c	2006-12-11 18:12:56.000000000 +0100
@@ -118,7 +118,7 @@
  * This is used when initializing the contents of the area.
  */
 
-void *usbvision_rvmalloc(unsigned long size)
+static void *usbvision_rvmalloc(unsigned long size)
 {
 	void *mem;
 	unsigned long adr;
@@ -181,7 +181,7 @@
 /********************************
  * scratch ring buffer handling
  ********************************/
-int scratch_len(struct usb_usbvision *usbvision)    /*This returns the amount of data actually in the buffer */
+static int scratch_len(struct usb_usbvision *usbvision)    /*This returns the amount of data actually in the buffer */
 {
 	int len = usbvision->scratch_write_ptr - usbvision->scratch_read_ptr;
 	if (len < 0) {
@@ -194,7 +194,7 @@
 
 
 /* This returns the free space left in the buffer */
-int scratch_free(struct usb_usbvision *usbvision)
+static int scratch_free(struct usb_usbvision *usbvision)
 {
 	int free = usbvision->scratch_read_ptr - usbvision->scratch_write_ptr;
 	if (free <= 0) {
@@ -211,7 +211,8 @@
 
 
 /* This puts data into the buffer */
-int scratch_put(struct usb_usbvision *usbvision, unsigned char *data, int len)
+static int scratch_put(struct usb_usbvision *usbvision, unsigned char *data,
+		       int len)
 {
 	int len_part;
 
@@ -237,7 +238,7 @@
 }
 
 /* This marks the write_ptr as position of new frame header */
-void scratch_mark_header(struct usb_usbvision *usbvision)
+static void scratch_mark_header(struct usb_usbvision *usbvision)
 {
 	PDEBUG(DBG_SCRATCH, "header at write_ptr=%d\n", usbvision->scratch_headermarker_write_ptr);
 
@@ -248,7 +249,8 @@
 }
 
 /* This gets data from the buffer at the given "ptr" position */
-int scratch_get_extra(struct usb_usbvision *usbvision, unsigned char *data, int *ptr, int len)
+static int scratch_get_extra(struct usb_usbvision *usbvision,
+			     unsigned char *data, int *ptr, int len)
 {
 	int len_part;
 	if (*ptr + len < scratch_buf_size) {
@@ -274,7 +276,8 @@
 
 
 /* This sets the scratch extra read pointer */
-void scratch_set_extra_ptr(struct usb_usbvision *usbvision, int *ptr, int len)
+static void scratch_set_extra_ptr(struct usb_usbvision *usbvision, int *ptr,
+				  int len)
 {
 	*ptr = (usbvision->scratch_read_ptr + len)%scratch_buf_size;
 
@@ -283,7 +286,7 @@
 
 
 /*This increments the scratch extra read pointer */
-void scratch_inc_extra_ptr(int *ptr, int len)
+static void scratch_inc_extra_ptr(int *ptr, int len)
 {
 	*ptr = (*ptr + len) % scratch_buf_size;
 
@@ -292,7 +295,8 @@
 
 
 /* This gets data from the buffer */
-int scratch_get(struct usb_usbvision *usbvision, unsigned char *data, int len)
+static int scratch_get(struct usb_usbvision *usbvision, unsigned char *data,
+		       int len)
 {
 	int len_part;
 	if (usbvision->scratch_read_ptr + len < scratch_buf_size) {
@@ -318,7 +322,8 @@
 
 
 /* This sets read pointer to next header and returns it */
-int scratch_get_header(struct usb_usbvision *usbvision,struct usbvision_frame_header *header)
+static int scratch_get_header(struct usb_usbvision *usbvision,
+			      struct usbvision_frame_header *header)
 {
 	int errCode = 0;
 
@@ -346,7 +351,7 @@
 
 
 /*This removes len bytes of old data from the buffer */
-void scratch_rm_old(struct usb_usbvision *usbvision, int len)
+static void scratch_rm_old(struct usb_usbvision *usbvision, int len)
 {
 
 	usbvision->scratch_read_ptr += len;
@@ -356,7 +361,7 @@
 
 
 /*This resets the buffer - kills all data in it too */
-void scratch_reset(struct usb_usbvision *usbvision)
+static void scratch_reset(struct usb_usbvision *usbvision)
 {
 	PDEBUG(DBG_SCRATCH, "\n");
 
@@ -399,8 +404,8 @@
  *		1: Draw a colored grid
  *
  */
-void usbvision_testpattern(struct usb_usbvision *usbvision, int fullframe,
-			int pmode)
+static void usbvision_testpattern(struct usb_usbvision *usbvision,
+				  int fullframe, int pmode)
 {
 	static const char proc[] = "usbvision_testpattern";
 	struct usbvision_frame *frame;
--- linux-2.6.19-mm1/drivers/media/video/usbvision/usbvision.h.old	2006-12-11 18:13:54.000000000 +0100
+++ linux-2.6.19-mm1/drivers/media/video/usbvision/usbvision.h	2006-12-11 18:15:41.000000000 +0100
@@ -489,7 +489,6 @@
 /* i2c-algo-usb declaration                                        */
 /* --------------------------------------------------------------- */
 
-int usbvision_i2c_usb_add_bus(struct i2c_adapter *);
 int usbvision_i2c_usb_del_bus(struct i2c_adapter *);
 
 static inline void *i2c_get_algo_usb_data (struct i2c_algo_usb_data *dev)
@@ -510,7 +509,6 @@
 void call_i2c_clients(struct usb_usbvision *usbvision, unsigned int cmd,void *arg);
 
 /* defined in usbvision-core.c                                      */
-void *usbvision_rvmalloc(unsigned long size);
 void usbvision_rvfree(void *mem, unsigned long size);
 int usbvision_read_reg(struct usb_usbvision *usbvision, unsigned char reg);
 int usbvision_write_reg(struct usb_usbvision *usbvision, unsigned char reg,
--- linux-2.6.19-mm1/drivers/media/video/usbvision/usbvision-i2c.c.old	2006-12-11 18:14:08.000000000 +0100
+++ linux-2.6.19-mm1/drivers/media/video/usbvision/usbvision-i2c.c	2006-12-11 18:14:18.000000000 +0100
@@ -209,7 +209,7 @@
 /*
  * registering functions to load algorithms at runtime
  */
-int usbvision_i2c_usb_add_bus(struct i2c_adapter *adap)
+static int usbvision_i2c_usb_add_bus(struct i2c_adapter *adap)
 {
 	PDEBUG(DBG_I2C, "I2C   debugging is enabled [i2c]");
 	PDEBUG(DBG_ALGO, "ALGO   debugging is enabled [i2c]");
@@ -555,9 +555,6 @@
 	.name		= "usbvision internal",
 };
 
-EXPORT_SYMBOL(usbvision_i2c_usb_add_bus);
-EXPORT_SYMBOL(usbvision_i2c_usb_del_bus);
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * ---------------------------------------------------------------------------
--- linux-2.6.19-mm1/drivers/media/video/usbvision/usbvision-video.c.old	2006-12-11 18:14:33.000000000 +0100
+++ linux-2.6.19-mm1/drivers/media/video/usbvision/usbvision-video.c	2006-12-11 18:14:45.000000000 +0100
@@ -1884,7 +1884,7 @@
  * This procedure preprocesses CustomDevice parameter if any
  *
  */
-void customdevice_process(void)
+static void customdevice_process(void)
 {
 	usbvision_device_data[0]=usbvision_device_data[1];
 	usbvision_table[0]=usbvision_table[1];

