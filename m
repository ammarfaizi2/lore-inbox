Return-Path: <linux-kernel-owner+w=401wt.eu-S1751097AbXAFC1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbXAFC1s (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbXAFC1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:27:10 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47860 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbXAFC1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:27:06 -0500
Message-Id: <20070106023028.655317000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:02 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       linville@tuxdriver.com
Subject: [patch 09/50] Revert "[PATCH] zd1211rw: Removed unneeded packed attributes"
Content-Disposition: inline; filename=revert-zd1211rw-removed-unneeded-packed-attributes.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: John W. Linville <linville@tuxdriver.com>

This reverts commit 4e1bbd846d00a245dcf78b6b331d8a9afed8e6d7.

Quoth Daniel Drake <dsd@gentoo.org>:

"A user reported that commit 4e1bbd846d00a245dcf78b6b331d8a9afed8e6d7
(Remove unneeded packed attributes) breaks the zd1211rw driver on ARM."

Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/net/wireless/zd1211rw/zd_ieee80211.h |    2 +-
 drivers/net/wireless/zd1211rw/zd_mac.c       |    2 +-
 drivers/net/wireless/zd1211rw/zd_mac.h       |    4 ++--
 drivers/net/wireless/zd1211rw/zd_usb.h       |   14 +++++++-------
 4 files changed, 11 insertions(+), 11 deletions(-)

--- linux-2.6.19.1.orig/drivers/net/wireless/zd1211rw/zd_ieee80211.h
+++ linux-2.6.19.1/drivers/net/wireless/zd1211rw/zd_ieee80211.h
@@ -64,7 +64,7 @@ struct cck_plcp_header {
 	u8 service;
 	__le16 length;
 	__le16 crc16;
-};
+} __attribute__((packed));
 
 static inline u8 zd_cck_plcp_header_rate(const struct cck_plcp_header *header)
 {
--- linux-2.6.19.1.orig/drivers/net/wireless/zd1211rw/zd_mac.c
+++ linux-2.6.19.1/drivers/net/wireless/zd1211rw/zd_mac.c
@@ -721,7 +721,7 @@ struct zd_rt_hdr {
 	u8  rt_rate;
 	u16 rt_channel;
 	u16 rt_chbitmask;
-};
+} __attribute__((packed));
 
 static void fill_rt_header(void *buffer, struct zd_mac *mac,
 	                   const struct ieee80211_rx_stats *stats,
--- linux-2.6.19.1.orig/drivers/net/wireless/zd1211rw/zd_mac.h
+++ linux-2.6.19.1/drivers/net/wireless/zd1211rw/zd_mac.h
@@ -82,7 +82,7 @@ struct zd_ctrlset {
 struct rx_length_info {
 	__le16 length[3];
 	__le16 tag;
-};
+} __attribute__((packed));
 
 #define RX_LENGTH_INFO_TAG		0x697e
 
@@ -93,7 +93,7 @@ struct rx_status {
 	u8 signal_quality_ofdm;
 	u8 decryption_type;
 	u8 frame_status;
-};
+} __attribute__((packed));
 
 /* rx_status field decryption_type */
 #define ZD_RX_NO_WEP	0
--- linux-2.6.19.1.orig/drivers/net/wireless/zd1211rw/zd_usb.h
+++ linux-2.6.19.1/drivers/net/wireless/zd1211rw/zd_usb.h
@@ -74,17 +74,17 @@ enum control_requests {
 struct usb_req_read_regs {
 	__le16 id;
 	__le16 addr[0];
-};
+} __attribute__((packed));
 
 struct reg_data {
 	__le16 addr;
 	__le16 value;
-};
+} __attribute__((packed));
 
 struct usb_req_write_regs {
 	__le16 id;
 	struct reg_data reg_writes[0];
-};
+} __attribute__((packed));
 
 enum {
 	RF_IF_LE = 0x02,
@@ -101,7 +101,7 @@ struct usb_req_rfwrite {
 	/* RF2595: 24 */
 	__le16 bit_values[0];
 	/* (CR203 & ~(RF_IF_LE | RF_CLK | RF_DATA)) | (bit ? RF_DATA : 0) */
-};
+} __attribute__((packed));
 
 /* USB interrupt */
 
@@ -118,12 +118,12 @@ enum usb_int_flags {
 struct usb_int_header {
 	u8 type;	/* must always be 1 */
 	u8 id;
-};
+} __attribute__((packed));
 
 struct usb_int_regs {
 	struct usb_int_header hdr;
 	struct reg_data regs[0];
-};
+} __attribute__((packed));
 
 struct usb_int_retry_fail {
 	struct usb_int_header hdr;
@@ -131,7 +131,7 @@ struct usb_int_retry_fail {
 	u8 _dummy;
 	u8 addr[ETH_ALEN];
 	u8 ibss_wakeup_dest;
-};
+} __attribute__((packed));
 
 struct read_regs_int {
 	struct completion completion;

--
