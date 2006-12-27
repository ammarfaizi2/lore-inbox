Return-Path: <linux-kernel-owner+w=401wt.eu-S933012AbWL0RMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933012AbWL0RMq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933013AbWL0RMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:12:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41488 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933017AbWL0RMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:12:24 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Adrian Bunk <bunk@stusta.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 04/28] V4L/DVB (4959): Usbvision: possible cleanups
Date: Wed, 27 Dec 2006 14:57:27 -0200
Message-id: <20061227165727.PS58432900004@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Adrian Bunk <bunk@stusta.de>

This patch contains the following possible cleanups:
- make needlessly global functions static
- remove the unused EXPORT_SYMBOL's

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/usbvision/usbvision-core.c  |   33 +++++++++++++----------
 drivers/media/video/usbvision/usbvision-i2c.c   |    5 +--
 drivers/media/video/usbvision/usbvision-video.c |    2 +
 drivers/media/video/usbvision/usbvision.h       |    2 -
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/media/video/usbvision/usbvision-core.c b/drivers/media/video/usbvision/usbvision-core.c
index 797b97b..6126873 100644
--- a/drivers/media/video/usbvision/usbvision-core.c
+++ b/drivers/media/video/usbvision/usbvision-core.c
@@ -118,7 +118,7 @@ static int usbvision_measure_bandwidth (
  * This is used when initializing the contents of the area.
  */
 
-void *usbvision_rvmalloc(unsigned long size)
+static void *usbvision_rvmalloc(unsigned long size)
 {
 	void *mem;
 	unsigned long adr;
@@ -181,7 +181,7 @@ #endif
 /********************************
  * scratch ring buffer handling
  ********************************/
-int scratch_len(struct usb_usbvision *usbvision)    /*This returns the amount of data actually in the buffer */
+static int scratch_len(struct usb_usbvision *usbvision)    /*This returns the amount of data actually in the buffer */
 {
 	int len = usbvision->scratch_write_ptr - usbvision->scratch_read_ptr;
 	if (len < 0) {
@@ -194,7 +194,7 @@ int scratch_len(struct usb_usbvision *us
 
 
 /* This returns the free space left in the buffer */
-int scratch_free(struct usb_usbvision *usbvision)
+static int scratch_free(struct usb_usbvision *usbvision)
 {
 	int free = usbvision->scratch_read_ptr - usbvision->scratch_write_ptr;
 	if (free <= 0) {
@@ -211,7 +211,8 @@ int scratch_free(struct usb_usbvision *u
 
 
 /* This puts data into the buffer */
-int scratch_put(struct usb_usbvision *usbvision, unsigned char *data, int len)
+static int scratch_put(struct usb_usbvision *usbvision, unsigned char *data,
+		       int len)
 {
 	int len_part;
 
@@ -237,7 +238,7 @@ int scratch_put(struct usb_usbvision *us
 }
 
 /* This marks the write_ptr as position of new frame header */
-void scratch_mark_header(struct usb_usbvision *usbvision)
+static void scratch_mark_header(struct usb_usbvision *usbvision)
 {
 	PDEBUG(DBG_SCRATCH, "header at write_ptr=%d\n", usbvision->scratch_headermarker_write_ptr);
 
@@ -248,7 +249,8 @@ void scratch_mark_header(struct usb_usbv
 }
 
 /* This gets data from the buffer at the given "ptr" position */
-int scratch_get_extra(struct usb_usbvision *usbvision, unsigned char *data, int *ptr, int len)
+static int scratch_get_extra(struct usb_usbvision *usbvision,
+			     unsigned char *data, int *ptr, int len)
 {
 	int len_part;
 	if (*ptr + len < scratch_buf_size) {
@@ -274,7 +276,8 @@ int scratch_get_extra(struct usb_usbvisi
 
 
 /* This sets the scratch extra read pointer */
-void scratch_set_extra_ptr(struct usb_usbvision *usbvision, int *ptr, int len)
+static void scratch_set_extra_ptr(struct usb_usbvision *usbvision, int *ptr,
+				  int len)
 {
 	*ptr = (usbvision->scratch_read_ptr + len)%scratch_buf_size;
 
@@ -283,7 +286,7 @@ void scratch_set_extra_ptr(struct usb_us
 
 
 /*This increments the scratch extra read pointer */
-void scratch_inc_extra_ptr(int *ptr, int len)
+static void scratch_inc_extra_ptr(int *ptr, int len)
 {
 	*ptr = (*ptr + len) % scratch_buf_size;
 
@@ -292,7 +295,8 @@ void scratch_inc_extra_ptr(int *ptr, int
 
 
 /* This gets data from the buffer */
-int scratch_get(struct usb_usbvision *usbvision, unsigned char *data, int len)
+static int scratch_get(struct usb_usbvision *usbvision, unsigned char *data,
+		       int len)
 {
 	int len_part;
 	if (usbvision->scratch_read_ptr + len < scratch_buf_size) {
@@ -318,7 +322,8 @@ int scratch_get(struct usb_usbvision *us
 
 
 /* This sets read pointer to next header and returns it */
-int scratch_get_header(struct usb_usbvision *usbvision,struct usbvision_frame_header *header)
+static int scratch_get_header(struct usb_usbvision *usbvision,
+			      struct usbvision_frame_header *header)
 {
 	int errCode = 0;
 
@@ -346,7 +351,7 @@ int scratch_get_header(struct usb_usbvis
 
 
 /*This removes len bytes of old data from the buffer */
-void scratch_rm_old(struct usb_usbvision *usbvision, int len)
+static void scratch_rm_old(struct usb_usbvision *usbvision, int len)
 {
 
 	usbvision->scratch_read_ptr += len;
@@ -356,7 +361,7 @@ void scratch_rm_old(struct usb_usbvision
 
 
 /*This resets the buffer - kills all data in it too */
-void scratch_reset(struct usb_usbvision *usbvision)
+static void scratch_reset(struct usb_usbvision *usbvision)
 {
 	PDEBUG(DBG_SCRATCH, "\n");
 
@@ -399,8 +404,8 @@ void usbvision_scratch_free(struct usb_u
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
diff --git a/drivers/media/video/usbvision/usbvision-i2c.c b/drivers/media/video/usbvision/usbvision-i2c.c
index 0f3fba7..9540bd0 100644
--- a/drivers/media/video/usbvision/usbvision-i2c.c
+++ b/drivers/media/video/usbvision/usbvision-i2c.c
@@ -213,7 +213,7 @@ static struct i2c_algorithm i2c_usb_algo
 /*
  * registering functions to load algorithms at runtime
  */
-int usbvision_i2c_usb_add_bus(struct i2c_adapter *adap)
+static int usbvision_i2c_usb_add_bus(struct i2c_adapter *adap)
 {
 	PDEBUG(DBG_I2C, "I2C   debugging is enabled [i2c]");
 	PDEBUG(DBG_ALGO, "ALGO   debugging is enabled [i2c]");
@@ -559,9 +559,6 @@ static struct i2c_client i2c_client_temp
 	.name		= "usbvision internal",
 };
 
-EXPORT_SYMBOL(usbvision_i2c_usb_add_bus);
-EXPORT_SYMBOL(usbvision_i2c_usb_del_bus);
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * ---------------------------------------------------------------------------
diff --git a/drivers/media/video/usbvision/usbvision-video.c b/drivers/media/video/usbvision/usbvision-video.c
index 864446c..b77e25e 100644
--- a/drivers/media/video/usbvision/usbvision-video.c
+++ b/drivers/media/video/usbvision/usbvision-video.c
@@ -1884,7 +1884,7 @@ static struct usb_driver usbvision_drive
  * This procedure preprocesses CustomDevice parameter if any
  *
  */
-void customdevice_process(void)
+static void customdevice_process(void)
 {
 	usbvision_device_data[0]=usbvision_device_data[1];
 	usbvision_table[0]=usbvision_table[1];
diff --git a/drivers/media/video/usbvision/usbvision.h b/drivers/media/video/usbvision/usbvision.h
index 0e7e3d6..5ad07f8 100644
--- a/drivers/media/video/usbvision/usbvision.h
+++ b/drivers/media/video/usbvision/usbvision.h
@@ -489,7 +489,6 @@ struct usb_usbvision {
 /* i2c-algo-usb declaration                                        */
 /* --------------------------------------------------------------- */
 
-int usbvision_i2c_usb_add_bus(struct i2c_adapter *);
 int usbvision_i2c_usb_del_bus(struct i2c_adapter *);
 
 static inline void *i2c_get_algo_usb_data (struct i2c_algo_usb_data *dev)
@@ -510,7 +509,6 @@ int usbvision_init_i2c(struct usb_usbvis
 void call_i2c_clients(struct usb_usbvision *usbvision, unsigned int cmd,void *arg);
 
 /* defined in usbvision-core.c                                      */
-void *usbvision_rvmalloc(unsigned long size);
 void usbvision_rvfree(void *mem, unsigned long size);
 int usbvision_read_reg(struct usb_usbvision *usbvision, unsigned char reg);
 int usbvision_write_reg(struct usb_usbvision *usbvision, unsigned char reg,

