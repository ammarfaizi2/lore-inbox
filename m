Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935203AbWKZBPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935203AbWKZBPy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 20:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935220AbWKZBPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 20:15:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7695 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S935203AbWKZBPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 20:15:52 -0500
Date: Sun, 26 Nov 2006 02:15:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dsd@gentoo.org, kune@deine-taler.de
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] zd1211rw: possible cleanups
Message-ID: <20061126011556.GD15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global functions static
- #if 0 the following unused global functions:
  - zd_chip.c: zd_ioread16()
  - zd_chip.c: zd_ioread32()
  - zd_chip.c: zd_iowrite16()
  - zd_chip.c: zd_ioread32v()
  - zd_chip.c: zd_read_mac_addr()
  - zd_chip.c: zd_set_beacon_interval()
  - zd_mac.c: zd_dump_rx_status()
  - zd_util.c: zd_hexdump()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/zd1211rw/zd_chip.c |   27 +++++++++++++++++++-----
 drivers/net/wireless/zd1211rw/zd_chip.h |   26 +++++------------------
 drivers/net/wireless/zd1211rw/zd_mac.c  |    4 +--
 drivers/net/wireless/zd1211rw/zd_mac.h  |    6 -----
 drivers/net/wireless/zd1211rw/zd_util.c |    4 +--
 drivers/net/wireless/zd1211rw/zd_util.h |    6 -----
 6 files changed, 32 insertions(+), 41 deletions(-)

--- linux-2.6.19-rc6-mm1/drivers/net/wireless/zd1211rw/zd_chip.h.old	2006-11-26 00:18:00.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/net/wireless/zd1211rw/zd_chip.h	2006-11-26 00:26:41.000000000 +0100
@@ -709,15 +709,6 @@
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
@@ -747,9 +738,6 @@
 	return _zd_iowrite32v_locked(chip, &ioreq, 1);
 }
 
-int zd_iowrite32a_locked(struct zd_chip *chip,
-	                 const struct zd_ioreq32 *ioreqs, unsigned int count);
-
 static inline int zd_rfwrite_locked(struct zd_chip *chip, u32 value, u8 bits)
 {
 	ZD_ASSERT(mutex_is_locked(&chip->mutex));
@@ -766,12 +754,7 @@
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
 
@@ -783,7 +766,6 @@
 u8  zd_chip_get_channel(struct zd_chip *chip);
 int zd_read_regdomain(struct zd_chip *chip, u8 *regdomain);
 void zd_get_e2p_mac_addr(struct zd_chip *chip, u8 *mac_addr);
-int zd_read_mac_addr(struct zd_chip *chip, u8 *mac_addr);
 int zd_write_mac_addr(struct zd_chip *chip, const u8 *mac_addr);
 int zd_chip_switch_radio_on(struct zd_chip *chip);
 int zd_chip_switch_radio_off(struct zd_chip *chip);
@@ -794,20 +776,24 @@
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
 
@@ -827,12 +813,12 @@
 
 int zd_chip_control_leds(struct zd_chip *chip, enum led_status status);
 
-int zd_set_beacon_interval(struct zd_chip *chip, u32 interval);
-
+#if 0
 static inline int zd_get_beacon_interval(struct zd_chip *chip, u32 *interval)
 {
 	return zd_ioread32(chip, CR_BCN_INTERVAL, interval);
 }
+#endif  /*  0  */
 
 struct rx_status;
 
--- linux-2.6.19-rc6-mm1/drivers/net/wireless/zd1211rw/zd_chip.c.old	2006-11-26 00:18:10.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/net/wireless/zd1211rw/zd_chip.c	2006-11-26 00:37:13.000000000 +0100
@@ -87,8 +87,8 @@
 /* Read a variable number of 32-bit values. Parameter count is not allowed to
  * exceed USB_MAX_IOREAD32_COUNT.
  */
-int zd_ioread32v_locked(struct zd_chip *chip, u32 *values, const zd_addr_t *addr,
-		 unsigned int count)
+static int zd_ioread32v_locked(struct zd_chip *chip, u32 *values,
+                               const zd_addr_t *addr, unsigned int count)
 {
 	int r;
 	int i;
@@ -135,6 +135,12 @@
 	return r;
 }
 
+static int zd_ioread32_locked(struct zd_chip *chip, u32 *value,
+			      const zd_addr_t addr)
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
@@ -275,6 +284,8 @@
 	return r;
 }
 
+#endif  /*  0  */
+
 int zd_iowrite32(struct zd_chip *chip, zd_addr_t addr, u32 value)
 {
 	int r;
@@ -285,8 +296,9 @@
 	return r;
 }
 
+#if 0
 int zd_ioread32v(struct zd_chip *chip, const zd_addr_t *addresses,
-	          u32 *values, unsigned int count)
+		 u32 *values, unsigned int count)
 {
 	int r;
 
@@ -295,6 +307,7 @@
 	mutex_unlock(&chip->mutex);
 	return r;
 }
+#endif  /*  0  */
 
 int zd_iowrite32a(struct zd_chip *chip, const struct zd_ioreq32 *ioreqs,
 	          unsigned int count)
@@ -399,6 +412,7 @@
 	return _read_mac_addr(chip, mac_addr, (const zd_addr_t *)addr);
 }
 
+#if 0
 int zd_read_mac_addr(struct zd_chip *chip, u8 *mac_addr)
 {
 	int r;
@@ -409,6 +423,7 @@
 	mutex_unlock(&chip->mutex);
 	return r;
 }
+#endif  /*  0  */
 
 int zd_write_mac_addr(struct zd_chip *chip, const u8 *mac_addr)
 {
@@ -950,6 +965,7 @@
 	return set_aw_pt_bi(chip, &s);
 }
 
+#if 0
 int zd_set_beacon_interval(struct zd_chip *chip, u32 interval)
 {
 	int r;
@@ -959,6 +975,7 @@
 	mutex_unlock(&chip->mutex);
 	return r;
 }
+#endif  /*  0  */
 
 static int hw_init(struct zd_chip *chip)
 {
--- linux-2.6.19-rc6-mm1/drivers/net/wireless/zd1211rw/zd_mac.h.old	2006-11-26 00:27:17.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/net/wireless/zd1211rw/zd_mac.h	2006-11-26 00:27:27.000000000 +0100
@@ -189,10 +189,4 @@
 
 struct iw_statistics *zd_mac_get_wireless_stats(struct net_device *ndev);
 
-#ifdef DEBUG
-void zd_dump_rx_status(const struct rx_status *status);
-#else
-#define zd_dump_rx_status(status)
-#endif /* DEBUG */
-
 #endif /* _ZD_MAC_H */
--- linux-2.6.19-rc6-mm1/drivers/net/wireless/zd1211rw/zd_mac.c.old	2006-11-26 00:27:34.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/net/wireless/zd1211rw/zd_mac.c	2006-11-26 00:33:34.000000000 +0100
@@ -1028,7 +1028,7 @@
 	return iw_stats;
 }
 
-#ifdef DEBUG
+#if 0
 static const char* decryption_types[] = {
 	[ZD_RX_NO_WEP] = "none",
 	[ZD_RX_WEP64] = "WEP64",
@@ -1086,7 +1086,7 @@
 				"crc16" : "");
 	}
 }
-#endif /* DEBUG */
+#endif /*  0  */
 
 #define LINK_LED_WORK_DELAY HZ
 
--- linux-2.6.19-rc6-mm1/drivers/net/wireless/zd1211rw/zd_util.h.old	2006-11-26 00:28:23.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/net/wireless/zd1211rw/zd_util.h	2006-11-26 00:28:31.000000000 +0100
@@ -20,10 +20,4 @@
 
 void *zd_tail(const void *buffer, size_t buffer_size, size_t tail_size);
 
-#ifdef DEBUG
-void zd_hexdump(const void *bytes, size_t size);
-#else
-#define zd_hexdump(bytes, size)
-#endif /* DEBUG */
-
 #endif /* _ZD_UTIL_H */
--- linux-2.6.19-rc6-mm1/drivers/net/wireless/zd1211rw/zd_util.c.old	2006-11-26 00:28:38.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/net/wireless/zd1211rw/zd_util.c	2006-11-26 00:28:57.000000000 +0100
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


