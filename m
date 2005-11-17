Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbVKQSEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbVKQSEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVKQSET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:04:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:14754 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932492AbVKQSEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:07 -0500
Date: Thu, 17 Nov 2005 09:47:36 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       lcapitulino@mandriva.com.br
Subject: [patch 13/22] USB: pl2303: updates pl2303_update_line_status()
Message-ID: <20051117174736.GN11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-pl2303-updates-pl2303_update_line_status.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>

Updates pl2303_update_line_status() to handle X75 and SX1 Siemens mobiles

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/serial/pl2303.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- usb-2.6.orig/drivers/usb/serial/pl2303.c
+++ usb-2.6/drivers/usb/serial/pl2303.c
@@ -813,7 +813,9 @@ static void pl2303_update_line_status(st
 	u8 length = UART_STATE;
 
 	if ((le16_to_cpu(port->serial->dev->descriptor.idVendor) == SIEMENS_VENDOR_ID) &&
-	    (le16_to_cpu(port->serial->dev->descriptor.idProduct) == SIEMENS_PRODUCT_ID_X65)) {
+	    (le16_to_cpu(port->serial->dev->descriptor.idProduct) == SIEMENS_PRODUCT_ID_X65 ||
+	     le16_to_cpu(port->serial->dev->descriptor.idProduct) == SIEMENS_PRODUCT_ID_SX1 ||
+	     le16_to_cpu(port->serial->dev->descriptor.idProduct) == SIEMENS_PRODUCT_ID_X75)) {
 		length = 1;
 		status_idx = 0;
 	}

--
