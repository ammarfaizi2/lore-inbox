Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUBSNgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 08:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267258AbUBSNgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 08:36:06 -0500
Received: from 81-223-104-78.krugerstrasse.Xdsl-line.inode.at ([81.223.104.78]:30646
	"EHLO mail.sk-tech.net") by vger.kernel.org with ESMTP
	id S267254AbUBSNex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 08:34:53 -0500
Date: Thu, 19 Feb 2004 14:35:59 +0100 (CET)
From: Kianusch Sayah Karadji <kianusch@sk-tech.net>
To: greg@kroah.com
cc: linux-kernel@vger.kernel.org
Subject: PCI-Scan Hangup ...
Message-ID: <Pine.LNX.4.58.0402191426360.27436@kryx.sk-tech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There I have a Soekris bord with some weird PCI Handup while booting
Linux during PCI-Scan .

# lspci

00:00.0 Host bridge: Cyrix Corporation PCI Master
00:12.0 ISA bridge: National Semiconductor Corporation: Unknown device 0510
00:12.1 Bridge: National Semiconductor Corporation: Unknown device 0511
00:12.2 IDE interface: National Semiconductor Corporation SCx200 IDE (rev 01)
00:12.5 Bridge: National Semiconductor Corporation: Unknown device 0515
00:13.0 USB Controller: Compaq Computer Corporation ZFMicro Chipset USB (rev 08)

There was a patch on 2.4.x which worked fine.

Now I tried to patch Kernel 2.6.x - well I'm no programmer
- I had no idea where to put it ... so I started putting some debug
messages into some files ... and suddenly including a printk(".") into
drivers/pci/probe.c fixed the whole PCI-Hangup ??? - That was not what the
2.4.x Patch did.

Hmmm ...

I've no idea why that printk fixes the Problem nor if it's a good idea to
have that printk there ...

Regards
  Kianusch

--- linux-2.6.3/drivers/pci/probe.c     Wed Feb 18 04:58:46 2004
+++ linux-2.6.3_geode/drivers/pci/probe.c       Thu Feb 19 14:00:52 2004
@@ -656,8 +656,11 @@
        DBG("Scanning bus %02x\n", bus->number);

        /* Go find them, Rover! */
-       for (devfn = 0; devfn < 0x100; devfn += 8)
+       for (devfn = 0; devfn < 0x100; devfn += 8) {
                pci_scan_slot(bus, devfn);
+               printk(".");
+        }
+       printk("\n");

        /*
         * After performing arch-dependent fixup of the bus, look behind

