Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTHFOFl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTHFOFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:05:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:6032 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263638AbTHFOFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:05:34 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 6 Aug 2003 16:05:30 +0200 (MEST)
Message-Id: <UTC200308061405.h76E5UW14677.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: Kill identify decoding 3/4
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Where did 3/4 go? I only saw 1,2 and 4.

Sorry. Here it is.



Part three of four: delete the identify decoding from isd200.c.

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/usb/storage/isd200.c b/drivers/usb/storage/isd200.c
--- a/drivers/usb/storage/isd200.c	Mon Jul 28 05:39:32 2003
+++ b/drivers/usb/storage/isd200.c	Wed Aug  6 09:47:26 2003
@@ -980,6 +980,12 @@
  * RETURNS:
  *    ISD status code
  */
+
+#ifdef CONFIG_USB_STORAGE_DEBUG
+#define IDE_IDENTIFY_DEBUG
+#include <linux/ide-identify.h>
+#endif
+
 int isd200_get_inquiry_data( struct us_data *us )
 {
 	struct isd200_info *info = (struct isd200_info *)us->extra;
@@ -1012,33 +1018,9 @@
 				__u16 *src, *dest;
 				ide_fix_driveid(&info->drive);
 
-				US_DEBUGP("   Identify Data Structure:\n");
-				US_DEBUGP("      config = 0x%x\n", info->drive.config);
-				US_DEBUGP("      cyls = 0x%x\n", info->drive.cyls);
-				US_DEBUGP("      heads = 0x%x\n", info->drive.heads);
-				US_DEBUGP("      track_bytes = 0x%x\n", info->drive.track_bytes);
-				US_DEBUGP("      sector_bytes = 0x%x\n", info->drive.sector_bytes);
-				US_DEBUGP("      sectors = 0x%x\n", info->drive.sectors);
-				US_DEBUGP("      serial_no[0] = 0x%x\n", info->drive.serial_no[0]);
-				US_DEBUGP("      buf_type = 0x%x\n", info->drive.buf_type);
-				US_DEBUGP("      buf_size = 0x%x\n", info->drive.buf_size);
-				US_DEBUGP("      ecc_bytes = 0x%x\n", info->drive.ecc_bytes);
-				US_DEBUGP("      fw_rev[0] = 0x%x\n", info->drive.fw_rev[0]);
-				US_DEBUGP("      model[0] = 0x%x\n", info->drive.model[0]);
-				US_DEBUGP("      max_multsect = 0x%x\n", info->drive.max_multsect);
-				US_DEBUGP("      dword_io = 0x%x\n", info->drive.dword_io);
-				US_DEBUGP("      capability = 0x%x\n", info->drive.capability);
-				US_DEBUGP("      tPIO = 0x%x\n", info->drive.tPIO);
-				US_DEBUGP("      tDMA = 0x%x\n", info->drive.tDMA);
-				US_DEBUGP("      field_valid = 0x%x\n", info->drive.field_valid);
-				US_DEBUGP("      cur_cyls = 0x%x\n", info->drive.cur_cyls);
-				US_DEBUGP("      cur_heads = 0x%x\n", info->drive.cur_heads);
-				US_DEBUGP("      cur_sectors = 0x%x\n", info->drive.cur_sectors);
-				US_DEBUGP("      cur_capacity = 0x%x\n", (info->drive.cur_capacity1 << 16) + info->drive.cur_capacity0 );
-				US_DEBUGP("      multsect = 0x%x\n", info->drive.multsect);
-				US_DEBUGP("      lba_capacity = 0x%x\n", info->drive.lba_capacity);
-				US_DEBUGP("      command_set_1 = 0x%x\n", info->drive.command_set_1);
-				US_DEBUGP("      command_set_2 = 0x%x\n", info->drive.command_set_2);
+#ifdef CONFIG_USB_STORAGE_DEBUG
+				ide_dump_identify_info(info->drive, "isd200");
+#endif
 
 				memset(&info->InquiryData, 0, sizeof(info->InquiryData));
 

