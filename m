Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272219AbTHIAjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272162AbTHIAhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:37:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:57535 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272158AbTHIAcT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:32:19 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10603869402949@kroah.com>
Subject: Re: [PATCH] More i2c driver changes 2.6.0-test2
In-Reply-To: <10603869391598@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 8 Aug 2003 16:55:40 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1127, 2003/08/08 16:36:42-07:00, seanlkml@rogers.com

[PATCH] I2C: Additional P4B subsystem id for hidden asus smbus

  This patch adds another P4B motherboard subsystem identifier to the recent
asus sensor patch for the 2.6 kernel.


 drivers/pci/quirks.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Fri Aug  8 16:47:06 2003
+++ b/drivers/pci/quirks.c	Fri Aug  8 16:47:06 2003
@@ -681,9 +681,12 @@
 	if (likely(dev->subsystem_vendor != PCI_VENDOR_ID_ASUSTEK))
 		return;
 
-	if ((dev->device == PCI_DEVICE_ID_INTEL_82845_HB) && 
-	    (dev->subsystem_device == 0x8088)) /* P4B533 */
-		asus_hides_smbus = 1;
+	if (dev->device == PCI_DEVICE_ID_INTEL_82845_HB)
+		switch(dev->subsystem_device) {
+		case 0x8070: /* P4B */
+	    	case 0x8088: /* P4B533 */
+			asus_hides_smbus = 1;
+		}
 	if ((dev->device == PCI_DEVICE_ID_INTEL_82845G_HB) &&
 	    (dev->subsystem_device == 0x80b2)) /* P4PE */
 		asus_hides_smbus = 1;

