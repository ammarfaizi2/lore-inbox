Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbUKOCov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUKOCov (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbUKOCoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:44:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23816 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261472AbUKOCkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:40:12 -0500
Date: Mon, 15 Nov 2004 03:26:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI qla1280: some firmware files cleanups
Message-ID: <20041115022640.GX2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following changes to the qla1280 firmware 
files:
- make all this needlessly global code static
- remove the unused firmware_version variables


diffstat output:
 drivers/scsi/ql1040_fw.h  |   10 ++++------
 drivers/scsi/ql12160_fw.h |   22 ++++++++--------------
 drivers/scsi/ql1280_fw.h  |   22 ++++++++--------------
 3 files changed, 20 insertions(+), 34 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/ql1040_fw.h.old	2004-11-13 22:51:55.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/ql1040_fw.h	2004-11-13 23:13:12.000000000 +0100
@@ -28,15 +28,13 @@
  *	Firmware Version 7.65.00 (14:17 Jul 20, 1999)
  */
 
-unsigned short risc_code_version = 7*1024+65;
-
-unsigned char firmware_version[] = {7,65,0};
+static unsigned char firmware_version[] = {7,65,0};
 
 #define FW_VERSION_STRING "7.65.0"
 
-unsigned short risc_code_addr01 = 0x1000 ;
+static unsigned short risc_code_addr01 = 0x1000 ;
 
-unsigned short risc_code01[] = { 
+static unsigned short risc_code01[] = { 
 	0x0078, 0x103a, 0x0000, 0x4057, 0x0000, 0x2043, 0x4f50, 0x5952,
 	0x4947, 0x4854, 0x2031, 0x3939, 0x3520, 0x514c, 0x4f47, 0x4943,
 	0x2043, 0x4f52, 0x504f, 0x5241, 0x5449, 0x4f4e, 0x2049, 0x5350,
@@ -2097,5 +2095,5 @@
 	0x0014, 0x878e, 0x0016, 0xa21c, 0x1035, 0xa8af, 0xa210, 0x3807,
 	0x300c, 0x817e, 0x872b, 0x8772, 0xa8a8, 0x0000, 0xdf21
 };
-unsigned short   risc_code_length01 = 0x4057;
+static unsigned short   risc_code_length01 = 0x4057;
 
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/ql1280_fw.h.old	2004-11-13 22:51:43.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/ql1280_fw.h	2004-11-13 23:13:07.000000000 +0100
@@ -27,15 +27,9 @@
  */
 
 #ifdef UNIQUE_FW_NAME
-unsigned short fw1280ei_version = 8*1024+15;
+static unsigned char fw1280ei_version_str[] = {8,15,0};
 #else
-unsigned short risc_code_version = 8*1024+15;
-#endif
-
-#ifdef UNIQUE_FW_NAME
-unsigned char fw1280ei_version_str[] = {8,15,0};
-#else
-unsigned char firmware_version[] = {8,15,0};
+static unsigned char firmware_version[] = {8,15,0};
 #endif
 
 #ifdef UNIQUE_FW_NAME
@@ -45,15 +39,15 @@
 #endif
 
 #ifdef UNIQUE_FW_NAME
-unsigned short fw1280ei_addr01 = 0x1000;
+static unsigned short fw1280ei_addr01 = 0x1000;
 #else
-unsigned short risc_code_addr01 = 0x1000;
+static unsigned short risc_code_addr01 = 0x1000;
 #endif
 
 #ifdef UNIQUE_FW_NAME
-unsigned short fw1280ei_code01[] = {
+static unsigned short fw1280ei_code01[] = {
 #else
-unsigned short risc_code01[] = {
+static unsigned short risc_code01[] = {
 #endif
 	0x0078, 0x1041, 0x0000, 0x3d3b, 0x0000, 0x2043, 0x4f50, 0x5952,
 	0x4947, 0x4854, 0x2031, 0x3939, 0x312c, 0x3139, 0x3932, 0x2c31,
@@ -2017,7 +2011,7 @@
 	0x70a2, 0x007c, 0x205b
 };
 #ifdef UNIQUE_FW_NAME
-unsigned short   fw1280ei_length01 = 0x3d3b;
+static unsigned short   fw1280ei_length01 = 0x3d3b;
 #else
-unsigned short   risc_code_length01 = 0x3d3b;
+static unsigned short   risc_code_length01 = 0x3d3b;
 #endif
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/ql12160_fw.h.old	2004-11-13 22:53:26.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/ql12160_fw.h	2004-11-13 23:13:02.000000000 +0100
@@ -26,15 +26,9 @@
  */
 
 #ifdef UNIQUE_FW_NAME
-unsigned short fw12160i_version = 10*1024+4;
+static unsigned char fw12160i_version_str[] = {10,4,32};
 #else
-unsigned short risc_code_version = 10*1024+4;
-#endif
-
-#ifdef UNIQUE_FW_NAME
-unsigned char fw12160i_version_str[] = {10,4,32};
-#else
-unsigned char firmware_version[] = {10,4,32};
+static unsigned char firmware_version[] = {10,4,32};
 #endif
 
 #ifdef UNIQUE_FW_NAME
@@ -44,15 +38,15 @@
 #endif
 
 #ifdef UNIQUE_FW_NAME
-unsigned short fw12160i_addr01 = 0x1000;
+static unsigned short fw12160i_addr01 = 0x1000;
 #else
-unsigned short risc_code_addr01 = 0x1000;
+static unsigned short risc_code_addr01 = 0x1000;
 #endif
 
 #ifdef UNIQUE_FW_NAME
-unsigned short fw12160i_code01[] = {
+static unsigned short fw12160i_code01[] = {
 #else
-unsigned short risc_code01[] = {
+static unsigned short risc_code01[] = {
 #endif
 	0x0804, 0x1041, 0x0000, 0x35e6, 0x0000, 0x2043, 0x4f50, 0x5952,
 	0x4947, 0x4854, 0x2031, 0x3939, 0x312c, 0x3139, 0x3932, 0x2c31,
@@ -1781,7 +1775,7 @@
 	0x681f, 0x000c, 0x70a0, 0x70a2, 0x0005, 0x7c12
 };
 #ifdef UNIQUE_FW_NAME
-unsigned short   fw12160i_length01 = 0x35e6;
+static unsigned short   fw12160i_length01 = 0x35e6;
 #else
-unsigned short   risc_code_length01 = 0x35e6;
+static unsigned short   risc_code_length01 = 0x35e6;
 #endif

