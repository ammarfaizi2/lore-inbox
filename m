Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbVIOBFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbVIOBFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbVIOBFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:05:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030307AbVIOBE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:04:58 -0400
Message-Id: <20050915010412.832148000@localhost.localdomain>
References: <20050915010343.577985000@localhost.localdomain>
Date: Wed, 14 Sep 2005 18:03:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Ian Abbott <abbotti@mev.co.uk>,
       Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 11/11] USB: ftdi_sio: custom baud rate fix
Content-Disposition: inline; filename=usb-ftdi_sio-baud-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

ftdi_sio: I messed up the baud_base for custom baud rate support in
2.6.13.  The attached one-liner patch fixes it.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/usb/serial/ftdi_sio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.13.y/drivers/usb/serial/ftdi_sio.c
===================================================================
--- linux-2.6.13.y.orig/drivers/usb/serial/ftdi_sio.c
+++ linux-2.6.13.y/drivers/usb/serial/ftdi_sio.c
@@ -874,7 +874,7 @@ static void ftdi_determine_type(struct u
 	unsigned interfaces;
 
 	/* Assume it is not the original SIO device for now. */
-	priv->baud_base = 48000000 / 16;
+	priv->baud_base = 48000000 / 2;
 	priv->write_offset = 0;
 
 	version = le16_to_cpu(udev->descriptor.bcdDevice);

--
