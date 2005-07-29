Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVG2UGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVG2UGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVG2TTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:19:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:3759 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262755AbVG2TQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:16:26 -0400
Date: Fri, 29 Jul 2005 12:15:46 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, d.gaffuri@reply.it
Subject: [patch 13/29] PCI: Hidden SMBus bridge on Toshiba Tecra M2
Message-ID: <20050729191546.GO5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniele Gaffuri" <d.gaffuri@reply.it>

Patch against 2.6.12 to unhide SMBus on Toshiba Centrino laptops using
Intel 82855PM chipset.  Tested on Toshiba Tecra M2.

Signed-off-by: Daniele Gaffuri <d.gaffuri@reply.it>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/quirks.c |    5 +++++
 1 files changed, 5 insertions(+)

--- gregkh-2.6.orig/drivers/pci/quirks.c	2005-07-29 11:29:50.000000000 -0700
+++ gregkh-2.6/drivers/pci/quirks.c	2005-07-29 11:36:21.000000000 -0700
@@ -820,6 +820,11 @@
 			case 0x0001: /* Toshiba Satellite A40 */
 				asus_hides_smbus = 1;
 			}
+		if (dev->device == PCI_DEVICE_ID_INTEL_82855PM_HB)
+			switch(dev->subsystem_device) {
+			case 0x0001: /* Toshiba Tecra M2 */
+				asus_hides_smbus = 1;
+			}
        } else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG)) {
                if (dev->device ==  PCI_DEVICE_ID_INTEL_82855PM_HB)
                        switch(dev->subsystem_device) {

--
