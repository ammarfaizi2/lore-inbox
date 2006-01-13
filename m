Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161492AbWAMJHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161492AbWAMJHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 04:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWAMJHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 04:07:22 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:3249 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161492AbWAMJHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 04:07:07 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 07/13] USBATM: return correct error code when out of memory
Date: Fri, 13 Jan 2006 10:07:08 +0100
User-Agent: KMail/1.9.1
Cc: usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200601121729.52596.baldrick@free.fr>
In-Reply-To: <200601121729.52596.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_922xDs2qdk3H2rR"
Message-Id: <200601131007.09403.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_922xDs2qdk3H2rR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We weren't always returning -ENOMEM.

Signed-off-by:	Duncan Sands <baldrick@free.fr>

--Boundary-00=_922xDs2qdk3H2rR
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="07-memory"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="07-memory"

Index: Linux/drivers/usb/atm/usbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.c	2006-01-13 08:57:48.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.c	2006-01-13 08:59:16.000000000 +0100
@@ -1081,6 +1081,7 @@
 		urb = usb_alloc_urb(iso_packets, GFP_KERNEL);
 		if (!urb) {
 			dev_err(dev, "%s: no memory for urb %d!\n", __func__, i);
+			error = -ENOMEM;
 			goto fail_unbind;
 		}
 
@@ -1090,6 +1091,7 @@
 		buffer = kzalloc(channel->buf_size, GFP_KERNEL);
 		if (!buffer) {
 			dev_err(dev, "%s: no memory for buffer %d!\n", __func__, i);
+			error = -ENOMEM;
 			goto fail_unbind;
 		}
 

--Boundary-00=_922xDs2qdk3H2rR--
