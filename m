Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbTDQFux (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbTDQFux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:50:53 -0400
Received: from granite.he.net ([216.218.226.66]:48656 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263070AbTDQFuw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:50:52 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10505595051616@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <1050559505328@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:05 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1066, 2003/04/14 21:24:10-07:00, greg@kroah.com

[PATCH] USB: io_edgeport: stop unlinking a urb that we don't need to unlink.


diff -Nru a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
--- a/drivers/usb/serial/io_edgeport.c	Wed Apr 16 10:48:29 2003
+++ b/drivers/usb/serial/io_edgeport.c	Wed Apr 16 10:48:29 2003
@@ -962,9 +962,8 @@
 		kfree(urb->transfer_buffer);
 	}
 
-	// Free the command urb
-	usb_unlink_urb (urb);
-	usb_free_urb   (urb);
+	/* Free the command urb */
+	usb_free_urb (urb);
 
 	if (port_paranoia_check (edge_port->port, __FUNCTION__)) {
 		return;

