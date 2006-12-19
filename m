Return-Path: <linux-kernel-owner+w=401wt.eu-S932682AbWLSIqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbWLSIqT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWLSIqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:46:19 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:42765 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682AbWLSIqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:46:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=bvS8dLg/pi3HyiFTf8QDkL4A36IGRflvAeW49dwOMKk3Cw8ENfpA2BJZAxJQDoL0irk0IBEsqgQ8eEY2JcT9Pih3G6zmQFrKY8sUU+QWNFD7SoYC9kAtd60wNk/uHjXmaXGpM/hWdMUsq2XaongPZcPcnCzFD/SOHVuIUnumVxA=
Date: Tue, 19 Dec 2006 17:44:53 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH] pc110pad: return proper error
Message-ID: <20061219084453.GH4049@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vojtech Pavlik <vojtech@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to the comment, "if we find any PCI devices in the machine,
we don't have a PC110" in pc110pad.c, we should return -ENODEV
rather than -ENOENT in this case.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/input/mouse/pc110pad.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-mm/drivers/input/mouse/pc110pad.c
===================================================================
--- 2.6-mm.orig/drivers/input/mouse/pc110pad.c
+++ 2.6-mm/drivers/input/mouse/pc110pad.c
@@ -113,7 +113,7 @@ static int __init pc110pad_init(void)
 	dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
 	if (dev) {
 		pci_dev_put(dev);
-		return -ENOENT;
+		return -ENODEV;
 	}
 
 	if (!request_region(pc110pad_io, 4, "pc110pad")) {
