Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132935AbRDEUbz>; Thu, 5 Apr 2001 16:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132970AbRDEUbo>; Thu, 5 Apr 2001 16:31:44 -0400
Received: from ns2.cypress.com ([157.95.67.5]:17287 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S132935AbRDEUbe>;
	Thu, 5 Apr 2001 16:31:34 -0400
Message-ID: <3ACCD5B9.866BEB42@cypress.com>
Date: Thu, 05 Apr 2001 15:29:45 -0500
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>
Subject: Re: Contacts within AMD?  AMD-756 USB host-controller blacklisted dueto
In-Reply-To: <E14kxc7-00035S-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------5C319453A1F77DEC8049811B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5C319453A1F77DEC8049811B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> 
> Since we expect to get errata docs very soon Im not that worried. As an
> implementation I'd rather a module option of 'ignore_blacklist' or similar
> so that it is runtime

This seamed to work here.

	-Thomas
--------------5C319453A1F77DEC8049811B
Content-Type: text/plain; charset=us-ascii;
 name="USB.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="USB.patch"

diff -u --new-file --recursive linux-2.4.3-ac2.orig/drivers/usb/usb-ohci.c linux-2.4.3-ac2/drivers/usb/usb-ohci.c
--- linux-2.4.3-ac2.orig/drivers/usb/usb-ohci.c	Wed Apr  4 15:23:15 2001
+++ linux-2.4.3-ac2/drivers/usb/usb-ohci.c	Thu Apr  5 14:02:08 2001
@@ -92,6 +92,10 @@
 static LIST_HEAD (ohci_hcd_list);
 static spinlock_t usb_ed_lock = SPIN_LOCK_UNLOCKED;
 
+static int overrideBlacklist = 0;
+MODULE_PARM(overrideBlacklist, "i");
+MODULE_PARM_DESC(overrideBlacklist, " override blacklisted controlers");
+
 /*-------------------------------------------------------------------------*
  * URB support functions 
  *-------------------------------------------------------------------------*/ 
@@ -2333,12 +2337,13 @@
 	void *mem_base;
 
 	/* blacklisted hardware? */
-	if (id->driver_data) {
-		info ("%s (%s): %s", dev->slot_name,
+	if (overrideBlacklist != 1){
+		if (id->driver_data) {
+			info ("%s (%s): %s", dev->slot_name,
 			dev->name, (char *) id->driver_data);
 		return -ENODEV;
+		}
 	}
-
 	if (pci_enable_device(dev) < 0)
 		return -ENODEV;
 	

--------------5C319453A1F77DEC8049811B--

