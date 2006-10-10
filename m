Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030607AbWJJWg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030607AbWJJWg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbWJJWg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:36:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49538 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030607AbWJJWg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:36:56 -0400
To: torvalds@osdl.org
Subject: [PATCH 1/16] cdrom: add endianness annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQDX-0008U4-OU@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:36:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Thu, 1 Dec 2005 17:10:40 -0500

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/cdrom/cdrom.c |    6 +++---
 include/linux/cdrom.h |   28 ++++++++++++++--------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 2a0c50d..7ea0f48 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -703,7 +703,7 @@ static int cdrom_has_defect_mgt(struct c
 {
 	struct packet_command cgc;
 	char buffer[16];
-	__u16 *feature_code;
+	__be16 *feature_code;
 	int ret;
 
 	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
@@ -716,7 +716,7 @@ static int cdrom_has_defect_mgt(struct c
 	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
 		return ret;
 
-	feature_code = (__u16 *) &buffer[sizeof(struct feature_header)];
+	feature_code = (__be16 *) &buffer[sizeof(struct feature_header)];
 	if (be16_to_cpu(*feature_code) == CDF_HWDM)
 		return 0;
 
@@ -2963,7 +2963,7 @@ static int mmc_ioctl(struct cdrom_device
 		   how much data is available for transfer. buffer[1] is
 		   unfortunately ambigious and the only reliable way seem
 		   to be to simply skip over the block descriptor... */
-		offset = 8 + be16_to_cpu(*(unsigned short *)(buffer+6));
+		offset = 8 + be16_to_cpu(*(__be16 *)(buffer+6));
 
 		if (offset + 16 > sizeof(buffer))
 			return -E2BIG;
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 3c9b0bc..bbbe7b4 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -749,7 +749,7 @@ #define MRW_MODE_PC_PRE1		0x2c
 #define MRW_MODE_PC			0x03
 
 struct mrw_feature_desc {
-	__u16 feature_code;
+	__be16 feature_code;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 reserved1		: 2;
 	__u8 feature_version	: 4;
@@ -776,7 +776,7 @@ #endif
 
 /* cf. mmc4r02g.pdf 5.3.10 Random Writable Feature (0020h) pg 197 of 635 */
 struct rwrt_feature_desc {
-	__u16 feature_code;
+	__be16 feature_code;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 reserved1		: 2;
 	__u8 feature_version	: 4;
@@ -803,7 +803,7 @@ #endif
 };
 
 typedef struct {
-	__u16 disc_information_length;
+	__be16 disc_information_length;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 reserved1			: 3;
         __u8 erasable			: 1;
@@ -849,7 +849,7 @@ #endif
 } disc_information;
 
 typedef struct {
-	__u16 track_information_length;
+	__be16 track_information_length;
 	__u8 track_lsb;
 	__u8 session_lsb;
 	__u8 reserved1;
@@ -880,12 +880,12 @@ #elif defined(__LITTLE_ENDIAN_BITFIELD)
 	__u8 lra_v			: 1;
 	__u8 reserved3			: 6;
 #endif
-	__u32 track_start;
-	__u32 next_writable;
-	__u32 free_blocks;
-	__u32 fixed_packet_size;
-	__u32 track_size;
-	__u32 last_rec_address;
+	__be32 track_start;
+	__be32 next_writable;
+	__be32 free_blocks;
+	__be32 fixed_packet_size;
+	__be32 track_size;
+	__be32 last_rec_address;
 } track_information;
 
 struct feature_header {
@@ -896,12 +896,12 @@ struct feature_header {
 };
 
 struct mode_page_header {
-	__u16 mode_data_length;
+	__be16 mode_data_length;
 	__u8 medium_type;
 	__u8 reserved1;
 	__u8 reserved2;
 	__u8 reserved3;
-	__u16 desc_length;
+	__be16 desc_length;
 };
 
 #ifdef __KERNEL__
@@ -1106,7 +1106,7 @@ #elif defined(__LITTLE_ENDIAN_BITFIELD)
 #endif
 	__u8 session_format;
 	__u8 reserved6;
-	__u32 packet_size;
+	__be32 packet_size;
 	__u16 audio_pause;
 	__u8 mcn[16];
 	__u8 isrc[16];
@@ -1151,7 +1151,7 @@ #endif
 } rpc_state_t;
 
 struct event_header {
-	__u16 data_len;
+	__be16 data_len;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 nea		: 1;
 	__u8 reserved1		: 4;
-- 
1.4.2.GIT


