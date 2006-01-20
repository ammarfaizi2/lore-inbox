Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422680AbWATGIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWATGIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 01:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbWATGIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 01:08:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:919 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422680AbWATGIC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 01:08:02 -0500
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] W1: Change the type 'unsigned long' member of 'struct w1_bus_master' to 'void *'.
In-Reply-To: <11377372363603@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 19 Jan 2006 22:07:17 -0800
Message-Id: <11377372373543@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] W1: Change the type 'unsigned long' member of 'struct w1_bus_master' to 'void *'.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit dc66784cd427bffa52cad9c615c409b1a597ed08
tree 7a79f765314178dbf716313537bf8dc6d5ed1940
parent 0f36b018b2e314d45af86449f1a97facb1fbe300
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Tue, 06 Dec 2005 13:38:27 +0300
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 19 Jan 2006 21:53:26 -0800

 drivers/w1/ds_w1_bridge.c |   34 +++++++++++++++++-----------------
 drivers/w1/matrox_w1.c    |   14 +++++++-------
 drivers/w1/w1.c           |    8 ++++----
 drivers/w1/w1.h           |   24 ++++++++++++------------
 4 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/w1/ds_w1_bridge.c b/drivers/w1/ds_w1_bridge.c
index a79d16d..29e01d5 100644
--- a/drivers/w1/ds_w1_bridge.c
+++ b/drivers/w1/ds_w1_bridge.c
@@ -29,10 +29,10 @@
 static struct ds_device *ds_dev;
 static struct w1_bus_master *ds_bus_master;
 
-static u8 ds9490r_touch_bit(unsigned long data, u8 bit)
+static u8 ds9490r_touch_bit(void *data, u8 bit)
 {
 	u8 ret;
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = data;
 
 	if (ds_touch_bit(dev, bit, &ret))
 		return 0;
@@ -40,23 +40,23 @@ static u8 ds9490r_touch_bit(unsigned lon
 	return ret;
 }
 
-static void ds9490r_write_bit(unsigned long data, u8 bit)
+static void ds9490r_write_bit(void *data, u8 bit)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = data;
 
 	ds_write_bit(dev, bit);
 }
 
-static void ds9490r_write_byte(unsigned long data, u8 byte)
+static void ds9490r_write_byte(void *data, u8 byte)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = data;
 
 	ds_write_byte(dev, byte);
 }
 
-static u8 ds9490r_read_bit(unsigned long data)
+static u8 ds9490r_read_bit(void *data)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = data;
 	int err;
 	u8 bit = 0;
 
@@ -70,9 +70,9 @@ static u8 ds9490r_read_bit(unsigned long
 	return bit & 1;
 }
 
-static u8 ds9490r_read_byte(unsigned long data)
+static u8 ds9490r_read_byte(void *data)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = data;
 	int err;
 	u8 byte = 0;
 
@@ -83,16 +83,16 @@ static u8 ds9490r_read_byte(unsigned lon
 	return byte;
 }
 
-static void ds9490r_write_block(unsigned long data, const u8 *buf, int len)
+static void ds9490r_write_block(void *data, const u8 *buf, int len)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = data;
 
 	ds_write_block(dev, (u8 *)buf, len);
 }
 
-static u8 ds9490r_read_block(unsigned long data, u8 *buf, int len)
+static u8 ds9490r_read_block(void *data, u8 *buf, int len)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = data;
 	int err;
 
 	err = ds_read_block(dev, buf, len);
@@ -102,9 +102,9 @@ static u8 ds9490r_read_block(unsigned lo
 	return len;
 }
 
-static u8 ds9490r_reset(unsigned long data)
+static u8 ds9490r_reset(void *data)
 {
-	struct ds_device *dev = (struct ds_device *)data;
+	struct ds_device *dev = data;
 	struct ds_status st;
 	int err;
 
@@ -136,7 +136,7 @@ static int __devinit ds_w1_init(void)
 
 	memset(ds_bus_master, 0, sizeof(*ds_bus_master));
 
-	ds_bus_master->data		= (unsigned long)ds_dev;
+	ds_bus_master->data		= ds_dev;
 	ds_bus_master->touch_bit	= &ds9490r_touch_bit;
 	ds_bus_master->read_bit		= &ds9490r_read_bit;
 	ds_bus_master->write_bit	= &ds9490r_write_bit;
diff --git a/drivers/w1/matrox_w1.c b/drivers/w1/matrox_w1.c
index 0b03f8f..750a1aa 100644
--- a/drivers/w1/matrox_w1.c
+++ b/drivers/w1/matrox_w1.c
@@ -90,8 +90,8 @@ struct matrox_device
 	struct w1_bus_master *bus_master;
 };
 
-static u8 matrox_w1_read_ddc_bit(unsigned long);
-static void matrox_w1_write_ddc_bit(unsigned long, u8);
+static u8 matrox_w1_read_ddc_bit(void *);
+static void matrox_w1_write_ddc_bit(void *, u8);
 
 /*
  * These functions read and write DDC Data bit.
@@ -122,10 +122,10 @@ static __inline__ void matrox_w1_write_r
 	wmb();
 }
 
-static void matrox_w1_write_ddc_bit(unsigned long data, u8 bit)
+static void matrox_w1_write_ddc_bit(void *data, u8 bit)
 {
 	u8 ret;
-	struct matrox_device *dev = (struct matrox_device *) data;
+	struct matrox_device *dev = data;
 
 	if (bit)
 		bit = 0;
@@ -137,10 +137,10 @@ static void matrox_w1_write_ddc_bit(unsi
 	matrox_w1_write_reg(dev, MATROX_GET_DATA, 0x00);
 }
 
-static u8 matrox_w1_read_ddc_bit(unsigned long data)
+static u8 matrox_w1_read_ddc_bit(void *data)
 {
 	u8 ret;
-	struct matrox_device *dev = (struct matrox_device *) data;
+	struct matrox_device *dev = data;
 
 	ret = matrox_w1_read_reg(dev, MATROX_GET_DATA);
 
@@ -198,7 +198,7 @@ static int __devinit matrox_w1_probe(str
 
 	matrox_w1_hw_init(dev);
 
-	dev->bus_master->data = (unsigned long) dev;
+	dev->bus_master->data = dev;
 	dev->bus_master->read_bit = &matrox_w1_read_ddc_bit;
 	dev->bus_master->write_bit = &matrox_w1_write_ddc_bit;
 
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 024206c..f0b47fe 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -552,7 +552,7 @@ static void w1_slave_detach(struct w1_sl
 	kfree(sl);
 }
 
-static struct w1_master *w1_search_master(unsigned long data)
+static struct w1_master *w1_search_master(void *data)
 {
 	struct w1_master *dev;
 	int found = 0;
@@ -583,7 +583,7 @@ void w1_reconnect_slaves(struct w1_famil
 	spin_unlock_bh(&w1_mlock);
 }
 
-static void w1_slave_found(unsigned long data, u64 rn)
+static void w1_slave_found(void *data, u64 rn)
 {
 	int slave_count;
 	struct w1_slave *sl;
@@ -595,8 +595,8 @@ static void w1_slave_found(unsigned long
 
 	dev = w1_search_master(data);
 	if (!dev) {
-		printk(KERN_ERR "Failed to find w1 master device for data %08lx, it is impossible.\n",
-				data);
+		printk(KERN_ERR "Failed to find w1 master device for data %p, "
+		       "it is impossible.\n", data);
 		return;
 	}
 
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
index d890078..b62e771 100644
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -80,7 +80,7 @@ struct w1_slave
 	struct completion	released;
 };
 
-typedef void (* w1_slave_found_callback)(unsigned long, u64);
+typedef void (* w1_slave_found_callback)(void *, u64);
 
 
 /**
@@ -93,16 +93,16 @@ typedef void (* w1_slave_found_callback)
 struct w1_bus_master
 {
 	/** the first parameter in all the functions below */
-	unsigned long	data;
+	void		*data;
 
 	/**
 	 * Sample the line level
 	 * @return the level read (0 or 1)
 	 */
-	u8		(*read_bit)(unsigned long);
+	u8		(*read_bit)(void *);
 
 	/** Sets the line level */
-	void		(*write_bit)(unsigned long, u8);
+	void		(*write_bit)(void *, u8);
 
 	/**
 	 * touch_bit is the lowest-level function for devices that really
@@ -111,42 +111,42 @@ struct w1_bus_master
 	 * touch_bit(1) = write-1 / read cycle
 	 * @return the bit read (0 or 1)
 	 */
-	u8		(*touch_bit)(unsigned long, u8);
+	u8		(*touch_bit)(void *, u8);
 
 	/**
 	 * Reads a bytes. Same as 8 touch_bit(1) calls.
 	 * @return the byte read
 	 */
-	u8		(*read_byte)(unsigned long);
+	u8		(*read_byte)(void *);
 
 	/**
 	 * Writes a byte. Same as 8 touch_bit(x) calls.
 	 */
-	void		(*write_byte)(unsigned long, u8);
+	void		(*write_byte)(void *, u8);
 
 	/**
 	 * Same as a series of read_byte() calls
 	 * @return the number of bytes read
 	 */
-	u8		(*read_block)(unsigned long, u8 *, int);
+	u8		(*read_block)(void *, u8 *, int);
 
 	/** Same as a series of write_byte() calls */
-	void		(*write_block)(unsigned long, const u8 *, int);
+	void		(*write_block)(void *, const u8 *, int);
 
 	/**
 	 * Combines two reads and a smart write for ROM searches
 	 * @return bit0=Id bit1=comp_id bit2=dir_taken
 	 */
-	u8		(*triplet)(unsigned long, u8);
+	u8		(*triplet)(void *, u8);
 
 	/**
 	 * long write-0 with a read for the presence pulse detection
 	 * @return -1=Error, 0=Device present, 1=No device present
 	 */
-	u8		(*reset_bus)(unsigned long);
+	u8		(*reset_bus)(void *);
 
 	/** Really nice hardware can handles the ROM searches */
-	void		(*search)(unsigned long, w1_slave_found_callback);
+	void		(*search)(void *, w1_slave_found_callback);
 };
 
 #define W1_MASTER_NEED_EXIT		0

