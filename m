Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261266AbVCEX7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVCEX7X (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 18:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVCEX5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:57:09 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:44936 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261235AbVCEXk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:40:57 -0500
Date: Sat, 05 Mar 2005 17:40:55 -0600 (CST)
Date-warning: Date header was inserted by vms040.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 13/13] sddr55: Clean up printk()'s in
 drivers/usb/storage/sddr55.c
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305234054.7660.70034.98473@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up printk()s and add KERN_ constants in drivers/usb/storage/sddr55.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/storage/sddr55.c linux-2.6.11-mm1/drivers/usb/storage/sddr55.c
--- linux-2.6.11-mm1-original/drivers/usb/storage/sddr55.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/storage/sddr55.c	2005-03-05 17:49:49.000000000 -0500
@@ -37,6 +37,7 @@
 #include "debug.h"
 #include "sddr55.h"
 
+#define PFX "sddr55: "
 
 #define short_pack(lsb,msb) ( ((u16)(lsb)) | ( ((u16)(msb))<<8 ) )
 #define LSB_of(s) ((s)&0xFF)
@@ -105,7 +106,7 @@ static int sddr55_status(struct us_data 
 	result = sddr55_bulk_transport(us,
 		DMA_TO_DEVICE, command, 8);
 
-	US_DEBUGP("Result for send_command in status %d\n",
+	US_DEBUGP(PFX "Result for send_command in status %d\n",
 		result);
 
 	if (result != USB_STOR_XFER_GOOD) {
@@ -196,7 +197,7 @@ static int sddr55_read_data(struct us_da
 				info->blocksize - page);
 		len = pages << info->pageshift;
 
-		US_DEBUGP("Read %02X pages, from PBA %04X"
+		US_DEBUGP(PFX "Read %02X pages, from PBA %04X"
 			" (LBA %04X) page %02X\n",
 			pages, pba, lba, page);
 
@@ -221,7 +222,7 @@ static int sddr55_read_data(struct us_da
 			result = sddr55_bulk_transport(us,
 				DMA_TO_DEVICE, command, 8);
 
-			US_DEBUGP("Result for send_command in read_data %d\n",
+			US_DEBUGP(PFX "Result for send_command in read_data %d\n",
 				result);
 
 			if (result != USB_STOR_XFER_GOOD) {
@@ -326,7 +327,7 @@ static int sddr55_write_data(struct us_d
 		usb_stor_access_xfer_buf(buffer, len, us->srb,
 				&index, &offset, FROM_XFER_BUF);
 
-		US_DEBUGP("Write %02X pages, to PBA %04X"
+		US_DEBUGP(PFX "Write %02X pages, to PBA %04X"
 			" (LBA %04X) page %02X\n",
 			pages, pba, lba, page);
 			
@@ -342,7 +343,7 @@ static int sddr55_write_data(struct us_d
 			/* set pba to first block in zone lba is in */
 			pba = (lba / 1000) * 1024;
 
-			US_DEBUGP("No PBA for LBA %04X\n",lba);
+			US_DEBUGP(PFX "No PBA for LBA %04X\n",lba);
 
 			if (max_pba > 1024)
 				max_pba = 1024;
@@ -365,14 +366,14 @@ static int sddr55_write_data(struct us_d
 
 			if (pba == -1) {
 				/* oh dear */
-				US_DEBUGP("Couldn't find unallocated block\n");
+				US_DEBUGP(PFX "Couldn't find unallocated block\n");
 
 				set_sense_info (3, 0x31, 0);	/* medium error */
 				result = USB_STOR_TRANSPORT_FAILED;
 				goto leave;
 			}
 
-			US_DEBUGP("Allocating PBA %04X for LBA %04X\n", pba, lba);
+			US_DEBUGP(PFX "Allocating PBA %04X for LBA %04X\n", pba, lba);
 
 			/* set writing to unallocated block flag */
 			command[4] = 0x40;
@@ -397,7 +398,7 @@ static int sddr55_write_data(struct us_d
 			DMA_TO_DEVICE, command, 8);
 
 		if (result != USB_STOR_XFER_GOOD) {
-			US_DEBUGP("Result for send_command in write_data %d\n",
+			US_DEBUGP(PFX "Result for send_command in write_data %d\n",
 			result);
 
 			/* set_sense_info is superfluous here? */
@@ -411,7 +412,7 @@ static int sddr55_write_data(struct us_d
 			DMA_TO_DEVICE, buffer, len);
 
 		if (result != USB_STOR_XFER_GOOD) {
-			US_DEBUGP("Result for send_data in write_data %d\n",
+			US_DEBUGP(PFX "Result for send_data in write_data %d\n",
 				  result);
 
 			/* set_sense_info is superfluous here? */
@@ -424,7 +425,7 @@ static int sddr55_write_data(struct us_d
 		result = sddr55_bulk_transport(us, DMA_FROM_DEVICE, status, 6);
 
 		if (result != USB_STOR_XFER_GOOD) {
-			US_DEBUGP("Result for get_status in write_data %d\n",
+			US_DEBUGP(PFX "Result for get_status in write_data %d\n",
 				  result);
 
 			/* set_sense_info is superfluous here? */
@@ -445,7 +446,7 @@ static int sddr55_write_data(struct us_d
 			goto leave;
 		}
 
-		US_DEBUGP("Updating maps for LBA %04X: old PBA %04X, new PBA %04X\n",
+		US_DEBUGP(PFX "Updating maps for LBA %04X: old PBA %04X, new PBA %04X\n",
 			lba, pba, new_pba);
 
 		/* update the lba<->pba maps, note new_pba might be the same as pba */
@@ -454,7 +455,7 @@ static int sddr55_write_data(struct us_d
 
 		/* check that new_pba wasn't already being used */
 		if (info->pba_to_lba[new_pba] != UNUSED_BLOCK) {
-			printk(KERN_ERR "sddr55 error: new PBA %04X already in use for LBA %04X\n",
+			printk(KERN_ERR PFX "new PBA %04X already in use for LBA %04X\n",
 				new_pba, info->pba_to_lba[new_pba]);
 			info->fatal_error = 1;
 			set_sense_info (3, 0x31, 0);
@@ -489,7 +490,7 @@ static int sddr55_read_deviceID(struct u
 	command[7] = 0x84;
 	result = sddr55_bulk_transport(us, DMA_TO_DEVICE, command, 8);
 
-	US_DEBUGP("Result of send_control for device ID is %d\n",
+	US_DEBUGP(PFX "Result of send_control for device ID is %d\n",
 		result);
 
 	if (result != USB_STOR_XFER_GOOD)
@@ -525,20 +526,20 @@ static unsigned long sddr55_get_capacity
 	int result;
 	struct sddr55_card_info *info = (struct sddr55_card_info *)us->extra;
 
-	US_DEBUGP("Reading capacity...\n");
+	US_DEBUGP(PFX "Reading capacity...\n");
 
 	result = sddr55_read_deviceID(us,
 		&manufacturerID,
 		&deviceID);
 
-	US_DEBUGP("Result of read_deviceID is %d\n",
+	US_DEBUGP(PFX "Result of read_deviceID is %d\n",
 		result);
 
 	if (result != USB_STOR_XFER_GOOD)
 		return 0;
 
-	US_DEBUGP("Device ID = %02X\n", deviceID);
-	US_DEBUGP("Manuf  ID = %02X\n", manufacturerID);
+	US_DEBUGP(PFX "Device ID = %02X\n", deviceID);
+	US_DEBUGP(PFX "Manuf  ID = %02X\n", manufacturerID);
 
 	info->pageshift = 9;
 	info->smallpageshift = 0;
@@ -707,12 +708,12 @@ static int sddr55_read_map(struct us_dat
 		
 		if (info->lba_to_pba[lba + zone * 1000] != NOT_ALLOCATED &&
 		    !info->force_read_only) {
-			printk("sddr55: map inconsistency at LBA %04X\n", lba + zone * 1000);
+			printk(KERN_WARNING PFX "map inconsistency at LBA %04X\n", lba + zone * 1000);
 			info->force_read_only = 1;
 		}
 
 		if (lba<0x10 || (lba>=0x3E0 && lba<0x3EF))
-			US_DEBUGP("LBA %04X <-> PBA %04X\n", lba, i);
+			US_DEBUGP(PFX "LBA %04X <-> PBA %04X\n", lba, i);
 
 		info->lba_to_pba[lba + zone * 1000] = i;
 	}
@@ -770,7 +771,7 @@ int sddr55_transport(struct scsi_cmnd *s
 	info = (struct sddr55_card_info *)(us->extra);
 
 	if (srb->cmnd[0] == REQUEST_SENSE) {
-		US_DEBUGP("SDDR55: request sense %02x/%02x/%02x\n", info->sense_data[2], info->sense_data[12], info->sense_data[13]);
+		US_DEBUGP(PFX "request sense %02x/%02x/%02x\n", info->sense_data[2], info->sense_data[12], info->sense_data[13]);
 
 		memcpy (ptr, info->sense_data, sizeof info->sense_data);
 		ptr[0] = 0x70;
@@ -854,13 +855,11 @@ int sddr55_transport(struct scsi_cmnd *s
 		usb_stor_set_xfer_buf(ptr, sizeof(mode_page_01), srb);
 
 		if ( (srb->cmnd[2] & 0x3F) == 0x01 ) {
-			US_DEBUGP(
-			  "SDDR55: Dummy up request for mode page 1\n");
+			US_DEBUGP(PFX "dummy up request for mode page 1\n");
 			return USB_STOR_TRANSPORT_GOOD;
 
 		} else if ( (srb->cmnd[2] & 0x3F) == 0x3F ) {
-			US_DEBUGP(
-			  "SDDR55: Dummy up request for all mode pages\n");
+			US_DEBUGP(PFX "dummy up request for all mode pages\n");
 			return USB_STOR_TRANSPORT_GOOD;
 		}
 
@@ -870,9 +869,7 @@ int sddr55_transport(struct scsi_cmnd *s
 
 	if (srb->cmnd[0] == ALLOW_MEDIUM_REMOVAL) {
 
-		US_DEBUGP(
-		  "SDDR55: %s medium removal. Not that I can do"
-		  " anything about it...\n",
+		US_DEBUGP(PFX "%s medium removal. Not that I can do anything about it...\n",
 		  (srb->cmnd[4]&0x03) ? "Prevent" : "Allow");
 
 		return USB_STOR_TRANSPORT_GOOD;
@@ -897,7 +894,7 @@ int sddr55_transport(struct scsi_cmnd *s
 
 		if (lba >= info->max_log_blks) {
 
-			US_DEBUGP("Error: Requested LBA %04X exceeds maximum "
+			US_DEBUGP(PFX "Error: Requested LBA %04X exceeds maximum "
 			  "block %04X\n", lba, info->max_log_blks-1);
 
 			set_sense_info (5, 0x24, 0);	/* invalid field in command */
@@ -908,13 +905,13 @@ int sddr55_transport(struct scsi_cmnd *s
 		pba = info->lba_to_pba[lba];
 
 		if (srb->cmnd[0] == WRITE_10) {
-			US_DEBUGP("WRITE_10: write block %04X (LBA %04X) page %01X"
+			US_DEBUGP(PFX "WRITE_10: write block %04X (LBA %04X) page %01X"
 				" pages %d\n",
 				pba, lba, page, pages);
 
 			return sddr55_write_data(us, lba, page, pages);
 		} else {
-			US_DEBUGP("READ_10: read block %04X (LBA %04X) page %01X"
+			US_DEBUGP(PFX "READ_10: read block %04X (LBA %04X) page %01X"
 				" pages %d\n",
 				pba, lba, page, pages);
 
