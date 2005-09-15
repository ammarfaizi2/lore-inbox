Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbVIOPzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbVIOPzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbVIOPzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:55:22 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:8924 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030487AbVIOPzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:55:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=MDEVSVq+XHfztguCrSf1tXCCHSAYi9WdzUYGDKSyFjonm9WwX8nzpFV2pwTbxlZDxQPBifuVMsWavP28iLEro/G9bKbFrxW17x/QneBumb1bYWxZn8t17aMvPNvrfRZtJGCw0AzJlPzJzM/5AURx+rgpq5Oy1HTovw3auOQnu2Y=
Date: Thu, 15 Sep 2005 20:05:37 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jens Axboe <axboe@suse.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cdrom: add endian annotations
Message-ID: <20050915160537.GA11481@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/cdrom/cdrom.c |    6 +++---
 include/linux/cdrom.h |   28 ++++++++++++++--------------
 2 files changed, 17 insertions(+), 17 deletions(-)

--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -705,7 +705,7 @@ static int cdrom_has_defect_mgt(struct c
 {
 	struct packet_command cgc;
 	char buffer[16];
-	__u16 *feature_code;
+	__be16 *feature_code;
 	int ret;
 
 	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
@@ -718,7 +718,7 @@ static int cdrom_has_defect_mgt(struct c
 	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
 		return ret;
 
-	feature_code = (__u16 *) &buffer[sizeof(struct feature_header)];
+	feature_code = (__be16 *) &buffer[sizeof(struct feature_header)];
 	if (be16_to_cpu(*feature_code) == CDF_HWDM)
 		return 0;
 
@@ -2772,7 +2772,7 @@ static int mmc_ioctl(struct cdrom_device
 		   how much data is available for transfer. buffer[1] is
 		   unfortunately ambigious and the only reliable way seem
 		   to be to simply skip over the block descriptor... */
-		offset = 8 + be16_to_cpu(*(unsigned short *)(buffer+6));
+		offset = 8 + be16_to_cpu(*(__be16 *)(buffer+6));
 
 		if (offset + 16 > sizeof(buffer))
 			return -E2BIG;
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -750,7 +750,7 @@ struct request_sense {
 #define MRW_MODE_PC			0x03
 
 struct mrw_feature_desc {
-	__u16 feature_code;
+	__be16 feature_code;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 reserved1		: 2;
 	__u8 feature_version	: 4;
@@ -777,7 +777,7 @@ struct mrw_feature_desc {
 
 /* cf. mmc4r02g.pdf 5.3.10 Random Writable Feature (0020h) pg 197 of 635 */
 struct rwrt_feature_desc {
-	__u16 feature_code;
+	__be16 feature_code;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 reserved1		: 2;
 	__u8 feature_version	: 4;
@@ -804,7 +804,7 @@ struct rwrt_feature_desc {
 };
 
 typedef struct {
-	__u16 disc_information_length;
+	__be16 disc_information_length;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 reserved1			: 3;
         __u8 erasable			: 1;
@@ -850,7 +850,7 @@ typedef struct {
 } disc_information;
 
 typedef struct {
-	__u16 track_information_length;
+	__be16 track_information_length;
 	__u8 track_lsb;
 	__u8 session_lsb;
 	__u8 reserved1;
@@ -881,12 +881,12 @@ typedef struct {
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
@@ -897,12 +897,12 @@ struct feature_header {
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
@@ -1109,7 +1109,7 @@ typedef struct {
 #endif
 	__u8 session_format;
 	__u8 reserved6;
-	__u32 packet_size;
+	__be32 packet_size;
 	__u16 audio_pause;
 	__u8 mcn[16];
 	__u8 isrc[16];
@@ -1154,7 +1154,7 @@ typedef struct {
 } rpc_state_t;
 
 struct event_header {
-	__u16 data_len;
+	__be16 data_len;
 #if defined(__BIG_ENDIAN_BITFIELD)
 	__u8 nea		: 1;
 	__u8 reserved1		: 4;

