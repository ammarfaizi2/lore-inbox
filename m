Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267998AbUJDQPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUJDQPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 12:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268285AbUJDQPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 12:15:55 -0400
Received: from gprs214-40.eurotel.cz ([160.218.214.40]:45953 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267998AbUJDQPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 12:15:50 -0400
Date: Mon, 4 Oct 2004 18:13:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       aeb@cwi.nl
Subject: sddr09: don't hide real errors in debug prints
Message-ID: <20041004161351.GA4757@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

sddr09 hides in debug prints. That seems wrong and this fixes
it. Please apply,
									Pavel

--- tmp/linux/drivers/usb/storage/sddr09.c	2004-10-01 00:30:20.000000000 +0200
+++ linux/drivers/usb/storage/sddr09.c	2004-10-01 00:47:53.000000000 +0200
@@ -370,7 +371,7 @@
 	result = sddr09_send_scsi_command(us, command, 12);
 
 	if (result != USB_STOR_TRANSPORT_GOOD) {
-		US_DEBUGP("Result for send_control in sddr09_read2%d %d\n",
+		printk(KERN_WARNING "Error in send_control in sddr09_read2%d %d\n",
 			  x, result);
 		return result;
 	}
@@ -379,7 +380,7 @@
 				       buf, bulklen, use_sg, NULL);
 
 	if (result != USB_STOR_XFER_GOOD) {
-		US_DEBUGP("Result for bulk_transfer in sddr09_read2%d %d\n",
+		printk(KERN_WARNING "Error in bulk_transfer in sddr09_read2%d %d\n",
 			  x, result);
 		return USB_STOR_TRANSPORT_ERROR;
 	}
@@ -498,7 +499,7 @@
 	result = sddr09_send_scsi_command(us, command, 12);
 
 	if (result != USB_STOR_TRANSPORT_GOOD)
-		US_DEBUGP("Result for send_control in sddr09_erase %d\n",
+		printk(KERN_WARNING "Error in send_control in sddr09_erase %d\n",
 			  result);
 
 	return result;
@@ -556,7 +557,7 @@
 	result = sddr09_send_scsi_command(us, command, 12);
 
 	if (result != USB_STOR_TRANSPORT_GOOD) {
-		US_DEBUGP("Result for send_control in sddr09_writeX %d\n",
+		printk(KERN_WARNING "Error in send_control in sddr09_writeX %d\n",
 			  result);
 		return result;
 	}
@@ -565,7 +566,7 @@
 				       buf, bulklen, use_sg, NULL);
 
 	if (result != USB_STOR_XFER_GOOD) {
-		US_DEBUGP("Result for bulk_transfer in sddr09_writeX %d\n",
+		printk(KERN_WARNING "Error in bulk_transfer in sddr09_writeX %d\n",
 			  result);
 		return USB_STOR_TRANSPORT_ERROR;
 	}
@@ -634,7 +635,7 @@
 	result = sddr09_send_scsi_command(us, command, 4*nsg+3);
 
 	if (result != USB_STOR_TRANSPORT_GOOD) {
-		US_DEBUGP("Result for send_control in sddr09_read_sg %d\n",
+		printk(KERN_WARNING "Error in send_control in sddr09_read_sg %d\n",
 			  result);
 		return result;
 	}
@@ -647,7 +648,7 @@
 				       buf, bulklen, NULL);
 	kfree(buf);
 	if (result != USB_STOR_XFER_GOOD) {
-		US_DEBUGP("Result for bulk_transfer in sddr09_read_sg %d\n",
+		printk(KERN_WARNING "Error in bulk_transfer in sddr09_read_sg %d\n",
 			  result);
 		return USB_STOR_TRANSPORT_ERROR;
 	}
@@ -710,7 +711,7 @@
 	len = min(sectors, (unsigned int) info->blocksize) * info->pagesize;
 	buffer = kmalloc(len, GFP_NOIO);
 	if (buffer == NULL) {
-		printk("sddr09_read_data: Out of memory\n");
+		printk(KERN_ERR "sddr09_read_data: Out of memory\n");
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
