Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUJGSk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUJGSk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUJGSjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:39:45 -0400
Received: from ms-smtp-01-qfe0.socal.rr.com ([66.75.162.133]:37040 "EHLO
	ms-smtp-01-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S267720AbUJGSiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:38:20 -0400
Subject: Re: 2.6.9-rc3-mm3: `risc_code_addr01' multiple definition
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1097172815.12495.51.camel@praka>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	 <20041007165849.GA4493@stusta.de>  <1097170149.12535.27.camel@praka>
	 <1097171420.1718.332.camel@mulgrave>  <1097172815.12495.51.camel@praka>
Content-Type: multipart/mixed; boundary="=-aypxZFdkn1tdOL4ILWcc"
Organization: QLogic Corporation
Date: Thu, 07 Oct 2004 11:30:32 -0700
Message-Id: <1097173832.12535.58.camel@praka>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aypxZFdkn1tdOL4ILWcc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-10-07 at 11:13 -0700, Andrew Vasquez wrote:
> On Thu, 2004-10-07 at 12:50 -0500, James Bottomley wrote:
> > On Thu, 2004-10-07 at 12:29, Andrew Vasquez wrote:
> > > Hmm, seems the additional 1040 support in qla1280.c is causing name
> > > clashes with the firmware image in qlogicfc_asm.c.  Try out the attached
> > > patch (not tested) which provides the 1040 firmware image unique
> > > variable names.
> > > 
> > > Looks like there would be some name clashes in qlogicfc and qlogicisp.
> > 
> > Is there any reason for these firmware image pointers not to be static? 
> > At least for these drivers which are single files.
> > 
> 
> That certainly seems like a reasonable option for qlogicfc and
> qlogicisp.  Attached is a small patch which will limit the scope of
> qlogicfc_asm variables.
> 
> We could also strip out the !UNIQUE_FW_NAME stuff out of the qla1280.c
> driver.  Firmware updates to those ISPs will likely _not_ happen, so we
> don't need to worry about adding the static modifier at each churn as we
> would with the qla2xxx driver.  I'll forward along a patch in a later
> email.
> 

Here's a second patch for the removal of UNIQUE_FW_NAME in qla1280.c and
its firmware files.

--
Andrew

--=-aypxZFdkn1tdOL4ILWcc
Content-Disposition: attachment; filename=fixup_fw_qla1280.diff
Content-Type: text/plain; name=fixup_fw_qla1280.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.9-rc3-mm3/drivers/scsi/ql1040_fw.h~	2004-10-07 11:17:33.278603328 -0700
+++ linux-2.6.9-rc3-mm3/drivers/scsi/ql1040_fw.h	2004-10-07 11:17:51.717800144 -0700
@@ -28,15 +28,15 @@
  *	Firmware Version 7.65.00 (14:17 Jul 20, 1999)
  */
 
-unsigned short risc_code_version = 7*1024+65;
+static unsigned short risc_code_version = 7*1024+65;
 
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
@@ -2097,5 +2097,5 @@ unsigned short risc_code01[] = { 
 	0x0014, 0x878e, 0x0016, 0xa21c, 0x1035, 0xa8af, 0xa210, 0x3807,
 	0x300c, 0x817e, 0x872b, 0x8772, 0xa8a8, 0x0000, 0xdf21
 };
-unsigned short   risc_code_length01 = 0x4057;
+static unsigned short   risc_code_length01 = 0x4057;
 
--- linux-2.6.9-rc3-mm3/drivers/scsi/ql1280_fw.h~	2004-10-07 11:18:00.995389736 -0700
+++ linux-2.6.9-rc3-mm3/drivers/scsi/ql1280_fw.h	2004-10-07 11:23:27.586740304 -0700
@@ -26,35 +26,15 @@
  *	Firmware Version 8.15.00 (14:35 Aug 22, 2000)
  */
 
-#ifdef UNIQUE_FW_NAME
-unsigned short fw1280ei_version = 8*1024+15;
-#else
-unsigned short risc_code_version = 8*1024+15;
-#endif
+static unsigned short fw1280ei_version = 8*1024+15;
 
-#ifdef UNIQUE_FW_NAME
-unsigned char fw1280ei_version_str[] = {8,15,0};
-#else
-unsigned char firmware_version[] = {8,15,0};
-#endif
+static unsigned char fw1280ei_version_str[] = {8,15,0};
 
-#ifdef UNIQUE_FW_NAME
 #define fw1280ei_VERSION_STRING "8.15.00"
-#else
-#define FW_VERSION_STRING "8.15.00"
-#endif
 
-#ifdef UNIQUE_FW_NAME
-unsigned short fw1280ei_addr01 = 0x1000;
-#else
-unsigned short risc_code_addr01 = 0x1000;
-#endif
+static unsigned short fw1280ei_addr01 = 0x1000;
 
-#ifdef UNIQUE_FW_NAME
-unsigned short fw1280ei_code01[] = {
-#else
-unsigned short risc_code01[] = {
-#endif
+static unsigned short fw1280ei_code01[] = {
 	0x0078, 0x1041, 0x0000, 0x3d3b, 0x0000, 0x2043, 0x4f50, 0x5952,
 	0x4947, 0x4854, 0x2031, 0x3939, 0x312c, 0x3139, 0x3932, 0x2c31,
 	0x3939, 0x332c, 0x3139, 0x3934, 0x2051, 0x4c4f, 0x4749, 0x4320,
@@ -2016,8 +1996,4 @@ unsigned short risc_code01[] = {
 	0x4cee, 0x7804, 0xd08c, 0x0040, 0x4d37, 0x681f, 0x000c, 0x70a0,
 	0x70a2, 0x007c, 0x205b
 };
-#ifdef UNIQUE_FW_NAME
-unsigned short   fw1280ei_length01 = 0x3d3b;
-#else
-unsigned short   risc_code_length01 = 0x3d3b;
-#endif
+static unsigned short   fw1280ei_length01 = 0x3d3b;
--- linux-2.6.9-rc3-mm3/drivers/scsi/ql12160_fw.h~	2004-10-07 11:18:07.033471808 -0700
+++ linux-2.6.9-rc3-mm3/drivers/scsi/ql12160_fw.h	2004-10-07 11:20:06.620291848 -0700
@@ -25,35 +25,15 @@
  *	Firmware Version 10.04.32 (12:03 May 09, 2001)
  */
 
-#ifdef UNIQUE_FW_NAME
-unsigned short fw12160i_version = 10*1024+4;
-#else
-unsigned short risc_code_version = 10*1024+4;
-#endif
+static unsigned short fw12160i_version = 10*1024+4;
 
-#ifdef UNIQUE_FW_NAME
-unsigned char fw12160i_version_str[] = {10,4,32};
-#else
-unsigned char firmware_version[] = {10,4,32};
-#endif
+static unsigned char fw12160i_version_str[] = {10,4,32};
 
-#ifdef UNIQUE_FW_NAME
 #define fw12160i_VERSION_STRING "10.04.32"
-#else
-#define FW_VERSION_STRING "10.04.32"
-#endif
 
-#ifdef UNIQUE_FW_NAME
-unsigned short fw12160i_addr01 = 0x1000;
-#else
-unsigned short risc_code_addr01 = 0x1000;
-#endif
+static unsigned short fw12160i_addr01 = 0x1000;
 
-#ifdef UNIQUE_FW_NAME
-unsigned short fw12160i_code01[] = {
-#else
-unsigned short risc_code01[] = {
-#endif
+static unsigned short fw12160i_code01[] = {
 	0x0804, 0x1041, 0x0000, 0x35e6, 0x0000, 0x2043, 0x4f50, 0x5952,
 	0x4947, 0x4854, 0x2031, 0x3939, 0x312c, 0x3139, 0x3932, 0x2c31,
 	0x3939, 0x332c, 0x3139, 0x3934, 0x2051, 0x4c4f, 0x4749, 0x4320,
@@ -1780,8 +1760,4 @@ unsigned short risc_code01[] = {
 	0xc0fc, 0xd0f4, 0x1108, 0xc0c4, 0x7816, 0x7804, 0xd08c, 0x0110,
 	0x681f, 0x000c, 0x70a0, 0x70a2, 0x0005, 0x7c12
 };
-#ifdef UNIQUE_FW_NAME
-unsigned short   fw12160i_length01 = 0x35e6;
-#else
-unsigned short   risc_code_length01 = 0x35e6;
-#endif
+static unsigned short   fw12160i_length01 = 0x35e6;
--- linux-2.6.9-rc3-mm3/drivers/scsi/qla1280.c~	2004-10-07 11:28:16.790774608 -0700
+++ linux-2.6.9-rc3-mm3/drivers/scsi/qla1280.c	2004-10-07 11:28:27.042216152 -0700
@@ -388,7 +388,6 @@
 #define	MEMORY_MAPPED_IO	1
 #endif
 
-#define UNIQUE_FW_NAME
 #include "qla1280.h"
 #include "ql12160_fw.h"		/* ISP RISC codes */
 #include "ql1280_fw.h"

--=-aypxZFdkn1tdOL4ILWcc--

