Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945934AbWGOAfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945934AbWGOAfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945936AbWGOAfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:35:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27401 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945934AbWGOAfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:35:13 -0400
Date: Sat, 15 Jul 2006 02:35:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/wireless/zd1211rw/: possible cleanups
Message-ID: <20060715003511.GE3633@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global functions static
- #if 0 unused functions

Please review which of these functions do make sense and which do 
conflict with pending patches.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 9 Jul 2006

 drivers/net/wireless/zd1211rw/zd_chip.c |   32 ++++++++++++++++++++----
 drivers/net/wireless/zd1211rw/zd_chip.h |   30 ++++------------------
 drivers/net/wireless/zd1211rw/zd_mac.c  |    4 +--
 drivers/net/wireless/zd1211rw/zd_mac.h  |    6 ----
 drivers/net/wireless/zd1211rw/zd_usb.c  |    4 +--
 drivers/net/wireless/zd1211rw/zd_util.c |    4 +--
 drivers/net/wireless/zd1211rw/zd_util.h |    6 ----
 7 files changed, 39 insertions(+), 47 deletions(-)

--- linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_chip.h.old	2006-07-09 16:51:01.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_chip.h	2006-07-09 19:01:05.000000000 +0200
@@ -690,15 +690,6 @@
 	return zd_usb_ioread16(&chip->usb, value, addr);
 }
 
-int zd_ioread32v_locked(struct zd_chip *chip, u32 *values,
-	                const zd_addr_t *addresses, unsigned int count);
-
-static inline int zd_ioread32_locked(struct zd_chip *chip, u32 *value,
-	                             const zd_addr_t addr)
-{
-	return zd_ioread32v_locked(chip, value, (const zd_addr_t *)&addr, 1);
-}
-
 static inline int zd_iowrite16_locked(struct zd_chip *chip, u16 value,
 	                              zd_addr_t addr)
 {
@@ -728,9 +719,6 @@
 	return _zd_iowrite32v_locked(chip, &ioreq, 1);
 }
 
-int zd_iowrite32a_locked(struct zd_chip *chip,
-	                 const struct zd_ioreq32 *ioreqs, unsigned int count);
-
 static inline int zd_rfwrite_locked(struct zd_chip *chip, u32 value, u8 bits)
 {
 	ZD_ASSERT(mutex_is_locked(&chip->mutex));
@@ -743,12 +731,7 @@
 /* Locking functions for reading and writing registers.
  * The different parameters are intentional.
  */
-int zd_ioread16(struct zd_chip *chip, zd_addr_t addr, u16 *value);
-int zd_iowrite16(struct zd_chip *chip, zd_addr_t addr, u16 value);
-int zd_ioread32(struct zd_chip *chip, zd_addr_t addr, u32 *value);
 int zd_iowrite32(struct zd_chip *chip, zd_addr_t addr, u32 value);
-int zd_ioread32v(struct zd_chip *chip, const zd_addr_t *addresses,
-	          u32 *values, unsigned int count);
 int zd_iowrite32a(struct zd_chip *chip, const struct zd_ioreq32 *ioreqs,
 	           unsigned int count);
 
@@ -760,7 +743,6 @@
 u8  zd_chip_get_channel(struct zd_chip *chip);
 int zd_read_regdomain(struct zd_chip *chip, u8 *regdomain);
 void zd_get_e2p_mac_addr(struct zd_chip *chip, u8 *mac_addr);
-int zd_read_mac_addr(struct zd_chip *chip, u8 *mac_addr);
 int zd_write_mac_addr(struct zd_chip *chip, const u8 *mac_addr);
 int zd_chip_switch_radio_on(struct zd_chip *chip);
 int zd_chip_switch_radio_off(struct zd_chip *chip);
@@ -771,20 +753,24 @@
 int zd_chip_enable_hwint(struct zd_chip *chip);
 int zd_chip_disable_hwint(struct zd_chip *chip);
 
+#if 0
 static inline int zd_get_encryption_type(struct zd_chip *chip, u32 *type)
 {
 	return zd_ioread32(chip, CR_ENCRYPTION_TYPE, type);
 }
+#endif  /*  0  */
 
 static inline int zd_set_encryption_type(struct zd_chip *chip, u32 type)
 {
 	return zd_iowrite32(chip, CR_ENCRYPTION_TYPE, type);
 }
 
+#if 0
 static inline int zd_chip_get_basic_rates(struct zd_chip *chip, u16 *cr_rates)
 {
 	return zd_ioread16(chip, CR_BASIC_RATE_TBL, cr_rates);
 }
+#endif  /*  0  */
 
 int zd_chip_set_basic_rates(struct zd_chip *chip, u16 cr_rates);
 
@@ -803,16 +789,12 @@
 	LED_STATUS = 3,
 };
 
-int zd_chip_led_status(struct zd_chip *chip, int led, enum led_status status);
-int zd_chip_led_flip(struct zd_chip *chip, int led,
-	             const unsigned int *phases_msecs, unsigned int count);
-
-int zd_set_beacon_interval(struct zd_chip *chip, u32 interval);
-
+#if 0
 static inline int zd_get_beacon_interval(struct zd_chip *chip, u32 *interval)
 {
 	return zd_ioread32(chip, CR_BCN_INTERVAL, interval);
 }
+#endif  /*  0  */
 
 struct rx_status;
 
--- linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_chip.c.old	2006-07-09 16:51:15.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_chip.c	2006-07-09 19:05:19.000000000 +0200
@@ -87,8 +87,8 @@
 /* Read a variable number of 32-bit values. Parameter count is not allowed to
  * exceed USB_MAX_IOREAD32_COUNT.
  */
-int zd_ioread32v_locked(struct zd_chip *chip, u32 *values, const zd_addr_t *addr,
-		 unsigned int count)
+static int zd_ioread32v_locked(struct zd_chip *chip, u32 *values,
+			       const zd_addr_t *addr, unsigned int count)
 {
 	int r;
 	int i;
@@ -135,6 +135,12 @@
 	return r;
 }
 
+static int zd_ioread32_locked(struct zd_chip *chip, u32 *value,
+	                             const zd_addr_t addr)
+{
+	return zd_ioread32v_locked(chip, value, (const zd_addr_t *)&addr, 1);
+}
+
 int _zd_iowrite32v_locked(struct zd_chip *chip, const struct zd_ioreq32 *ioreqs,
 	           unsigned int count)
 {
@@ -215,8 +221,9 @@
  * that in several USB requests. A split can be forced by inserting an IO
  * request with an zero address field.
  */
-int zd_iowrite32a_locked(struct zd_chip *chip,
-	          const struct zd_ioreq32 *ioreqs, unsigned int count)
+static int zd_iowrite32a_locked(struct zd_chip *chip,
+				const struct zd_ioreq32 *ioreqs,
+				unsigned int count)
 {
 	int r;
 	unsigned int i, j, t, max;
@@ -245,6 +252,8 @@
 	return 0;
 }
 
+#if 0
+
 int zd_ioread16(struct zd_chip *chip, zd_addr_t addr, u16 *value)
 {
 	int r;
@@ -278,6 +287,8 @@
 	return r;
 }
 
+#endif  /*  0  */
+
 int zd_iowrite32(struct zd_chip *chip, zd_addr_t addr, u32 value)
 {
 	int r;
@@ -289,6 +300,7 @@
 	return r;
 }
 
+#if 0
 int zd_ioread32v(struct zd_chip *chip, const zd_addr_t *addresses,
 	          u32 *values, unsigned int count)
 {
@@ -300,6 +312,7 @@
 	mutex_unlock(&chip->mutex);
 	return r;
 }
+#endif  /*  0  */
 
 int zd_iowrite32a(struct zd_chip *chip, const struct zd_ioreq32 *ioreqs,
 	          unsigned int count)
@@ -394,6 +407,7 @@
 	return _read_mac_addr(chip, mac_addr, (const zd_addr_t *)addr);
 }
 
+#if 0
 int zd_read_mac_addr(struct zd_chip *chip, u8 *mac_addr)
 {
 	int r;
@@ -404,6 +418,7 @@
 	mutex_unlock(&chip->mutex);
 	return r;
 }
+#endif  /*  0  */
 
 int zd_write_mac_addr(struct zd_chip *chip, const u8 *mac_addr)
 {
@@ -947,6 +962,7 @@
 	return set_aw_pt_bi(chip, &s);
 }
 
+#if 0
 int zd_set_beacon_interval(struct zd_chip *chip, u32 interval)
 {
 	int r;
@@ -956,6 +972,7 @@
 	mutex_unlock(&chip->mutex);
 	return r;
 }
+#endif  /*  0  */
 
 static int hw_init(struct zd_chip *chip)
 {
@@ -1290,6 +1307,8 @@
 	return channel;
 }
 
+#if 0
+
 static u16 led_mask(int led)
 {
 	switch (led) {
@@ -1314,7 +1333,8 @@
 	return zd_iowrite16_locked(chip, status, CR_LED);
 }
 
-int zd_chip_led_status(struct zd_chip *chip, int led, enum led_status status)
+static int zd_chip_led_status(struct zd_chip *chip, int led,
+			      enum led_status status)
 {
 	int r, ret;
 	u16 mask = led_mask(led);
@@ -1376,6 +1396,8 @@
 	return r;
 }
 
+#endif  /*  0  */
+
 int zd_chip_set_basic_rates(struct zd_chip *chip, u16 cr_rates)
 {
 	int r;
--- linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_mac.h.old	2006-07-09 17:01:36.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_mac.h	2006-07-09 17:01:45.000000000 +0200
@@ -181,10 +181,4 @@
 
 struct iw_statistics *zd_mac_get_wireless_stats(struct net_device *ndev);
 
-#ifdef DEBUG
-void zd_dump_rx_status(const struct rx_status *status);
-#else
-#define zd_dump_rx_status(status)
-#endif /* DEBUG */
-
 #endif /* _ZD_MAC_H */
--- linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_mac.c.old	2006-07-09 17:01:52.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_mac.c	2006-07-09 17:02:21.000000000 +0200
@@ -996,7 +996,7 @@
 	return iw_stats;
 }
 
-#ifdef DEBUG
+#if 0
 static const char* decryption_types[] = {
 	[ZD_RX_NO_WEP] = "none",
 	[ZD_RX_WEP64] = "WEP64",
@@ -1054,4 +1054,4 @@
 				"crc16" : "");
 	}
 }
-#endif /* DEBUG */
+#endif /*  0  */
--- linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_usb.c.old	2006-07-09 17:03:20.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_usb.c	2006-07-09 17:03:32.000000000 +0200
@@ -625,7 +625,7 @@
 	usb_submit_urb(urb, GFP_ATOMIC);
 }
 
-struct urb *alloc_urb(struct zd_usb *usb)
+static struct urb *alloc_urb(struct zd_usb *usb)
 {
 	struct usb_device *udev = zd_usb_to_usbdev(usb);
 	struct urb *urb;
@@ -649,7 +649,7 @@
 	return urb;
 }
 
-void free_urb(struct urb *urb)
+static void free_urb(struct urb *urb)
 {
 	if (!urb)
 		return;
--- linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_util.h.old	2006-07-09 17:03:50.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_util.h	2006-07-09 17:04:15.000000000 +0200
@@ -20,10 +20,4 @@
 
 void *zd_tail(const void *buffer, size_t buffer_size, size_t tail_size);
 
-#ifdef DEBUG
-void zd_hexdump(const void *bytes, size_t size);
-#else
-#define zd_hexdump(bytes, size)
-#endif /* DEBUG */
-
 #endif /* _ZD_UTIL_H */
--- linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_util.c.old	2006-07-09 17:04:19.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/net/wireless/zd1211rw/zd_util.c	2006-07-09 17:04:36.000000000 +0200
@@ -20,7 +20,7 @@
 #include "zd_def.h"
 #include "zd_util.h"
 
-#ifdef DEBUG
+#if 0
 static char hex(u8 v)
 {
 	v &= 0xf;
@@ -72,7 +72,7 @@
 		i += 8;
 	} while (i < size);
 }
-#endif /* DEBUG */
+#endif /*  0  */
 
 void *zd_tail(const void *buffer, size_t buffer_size, size_t tail_size)
 {

k
