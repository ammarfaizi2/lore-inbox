Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWJHXQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWJHXQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 19:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWJHXQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 19:16:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55313 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932106AbWJHXQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 19:16:35 -0400
Date: Mon, 9 Oct 2006 01:16:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paul B Schroeder <pschroeder@uplogix.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: [RFC: 2.6 patch] drivers/usb/serial/mos7840.c: remove dead code
Message-ID: <20061008231630.GP6755@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this dead code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/serial/mos7840.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- linux-2.6/drivers/usb/serial/mos7840.c.old	2006-10-09 00:31:41.000000000 +0200
+++ linux-2.6/drivers/usb/serial/mos7840.c	2006-10-09 00:32:12.000000000 +0200
@@ -1420,7 +1420,6 @@
 	int i;
 	int bytes_sent = 0;
 	int transfer_size;
-	int from_user = 0;
 
 	struct moschip_port *mos7840_port;
 	struct usb_serial *serial;
@@ -1511,15 +1510,7 @@
 	}
 	transfer_size = min(count, URB_TRANSFER_BUFFER_SIZE);
 
-	if (from_user) {
-		if (copy_from_user
-		    (urb->transfer_buffer, current_position, transfer_size)) {
-			bytes_sent = -EFAULT;
-			goto exit;
-		}
-	} else {
-		memcpy(urb->transfer_buffer, current_position, transfer_size);
-	}
+	memcpy(urb->transfer_buffer, current_position, transfer_size);
 
 	/* fill urb with data and submit  */
 	usb_fill_bulk_urb(urb,

