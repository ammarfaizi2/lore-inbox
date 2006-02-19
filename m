Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWBSQoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWBSQoF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 11:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWBSQoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 11:44:05 -0500
Received: from aou170.internetdsl.tpnet.pl ([83.17.128.170]:56239 "HELO
	aou170.internetdsl.tpnet.pl") by vger.kernel.org with SMTP
	id S932099AbWBSQoE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 11:44:04 -0500
From: Tomek Koprowski <tomek@koprowski.org>
Organization: Druciarze Galaktyki
To: Greg KH <gregkh@suse.de>
Subject: Re: [patch] SMBus unhide on HP Compaq nx6110
Date: Sun, 19 Feb 2006 17:45:36 +0100
User-Agent: KMail/1.6.2
References: <200602191143.55507.tomek@koprowski.org> <20060219163212.GA20490@suse.de>
In-Reply-To: <20060219163212.GA20490@suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200602191745.36628.tomek@koprowski.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I attach a trivial patch for 2.6.15.4 that unhides SMBus controller
on an HP Compaq nx6110 notebook.

Regards,
Tomasz Koprowski

Signed-off-by: Tomasz Koprowski <tomek@koprowski.org>

--- linux-2.6.15.4.orig/drivers/pci/quirks.c    2006-02-19 10:02:08.000000000 +0100
+++ linux-2.6.15.4/drivers/pci/quirks.c 2006-02-19 10:35:04.000000000 +0100
@@ -934,6 +934,12 @@
                        case 0x12bd: /* HP D530 */
                                asus_hides_smbus = 1;
                        }
+               if (dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB) {
+                       switch (dev->subsystem_device) {
+                       case 0x099c: /* HP Compaq nx6110 */
+                               asus_hides_smbus = 1;
+                       }
+               }
        } else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_TOSHIBA)) {
                if (dev->device == PCI_DEVICE_ID_INTEL_82855GM_HB)
                        switch(dev->subsystem_device) {

-- 
[ tomek@koprowski.org http://www.koprowski.org ]
[ JabberID: tomek@abakus.kom.pl   gg#: 2348134 ]
[       Life is as bad as you make it be       ]
