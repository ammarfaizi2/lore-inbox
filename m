Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbULVWCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbULVWCn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 17:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbULVWCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 17:02:36 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62347 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262061AbULVWC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 17:02:27 -0500
Date: Wed, 22 Dec 2004 14:02:13 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: [PATCH 2/2] USB: fix up warning messages spit out by the keyspan driver.
Message-ID: <20041222220213.GB9864@kroah.com>
References: <20041222220139.GA9864@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222220139.GA9864@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I missed this in the previous usb_kill_urb() cleanup.  Thanks to 
Pat Mochel for reporting this.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
--- a/drivers/usb/serial/keyspan.c	2004-12-22 13:42:54 -08:00
+++ b/drivers/usb/serial/keyspan.c	2004-12-22 13:42:54 -08:00
@@ -1121,7 +1121,7 @@
 {
 	if (urb && urb->status == -EINPROGRESS) {
 		urb->transfer_flags &= ~URB_ASYNC_UNLINK;
-		usb_unlink_urb(urb);
+		usb_kill_urb(urb);
 	}
 }
 
