Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbUBTTIY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUBTTIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:08:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:64741 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261279AbUBTTGY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:06:24 -0500
Subject: Re: [PATCH] PCI update for 2.6.3
In-Reply-To: <10773039801571@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Feb 2004 11:06:20 -0800
Message-Id: <10773039802393@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.58.8, 2004/02/18 13:33:13-08:00, greg@kroah.com

PCI: fix pci quirk for P4B533-V, fixes bug 1720

Thanks to stephanrave@gmx.de (Stephan Rave) for the patch.


 drivers/pci/quirks.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Fri Feb 20 10:44:43 2004
+++ b/drivers/pci/quirks.c	Fri Feb 20 10:44:43 2004
@@ -703,9 +703,12 @@
 	    	case 0x8088: /* P4B533 */
 			asus_hides_smbus = 1;
 		}
-	if ((dev->device == PCI_DEVICE_ID_INTEL_82845G_HB) &&
-	    (dev->subsystem_device == 0x80b2)) /* P4PE */
-		asus_hides_smbus = 1;
+	if (dev->device == PCI_DEVICE_ID_INTEL_82845G_HB)
+		switch(dev->subsystem_device) {
+		case 0x80b2: /* P4PE */
+ 		case 0x8093: /* P4B533-V */
+			asus_hides_smbus = 1;
+		}
 	if ((dev->device == PCI_DEVICE_ID_INTEL_82850_HB) &&
 	    (dev->subsystem_device == 0x8030)) /* P4T533 */
 		asus_hides_smbus = 1;

