Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVAHI3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVAHI3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVAHI20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:28:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:27270 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261938AbVAHFsv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:51 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163267561@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:47 -0800
Message-Id: <11051632672444@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.30, 2004/12/17 11:41:02-08:00, mdharm-usb@one-eyed-alien.net

[PATCH] USB Storage: Increase Genesys delay

This is patch as436 from Alan Stern.

This patch increases the delay used for Genesys devices about 10%.  At
least one user reports that this created a significant improvement in
operation.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/storage/transport.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
--- a/drivers/usb/storage/transport.c	2005-01-07 15:46:51 -08:00
+++ b/drivers/usb/storage/transport.c	2005-01-07 15:46:51 -08:00
@@ -992,9 +992,10 @@
 	/* send/receive data payload, if there is any */
 
 	/* Genesys Logic interface chips need a 100us delay between the
-	 * command phase and the data phase */
+	 * command phase and the data phase.  Some devices need a little
+	 * more than that, probably because of clock rate inaccuracies. */
 	if (us->pusb_dev->descriptor.idVendor == USB_VENDOR_ID_GENESYS)
-		udelay(100);
+		udelay(110);
 
 	if (transfer_length) {
 		unsigned int pipe = srb->sc_data_direction == DMA_FROM_DEVICE ? 

