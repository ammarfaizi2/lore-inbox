Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTJQBgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 21:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTJQBgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 21:36:36 -0400
Received: from [65.248.22.68] ([65.248.22.68]:36300 "EHLO stoneflynetworks.com")
	by vger.kernel.org with ESMTP id S263275AbTJQBg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 21:36:27 -0400
Subject: tg3 driver - trying to get the old v0.99 driver woking on RedHat
	2.4.18-10
From: Piet Delaney <piet@stoneflynetworks.com>
Reply-To: piet@stoneflynetworks.com
To: Linux-Net <linux-net@vger.kernel.org>
Cc: Piet Delaney <piet@www.piet.net>, Piet Delaney <piet@stoneflynetworks.com>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: StoneFLy Networks
Message-Id: <1066354407.2525.40.camel@piet1.stonefly.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 16 Oct 2003 18:33:27 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2003 01:36:26.0606 (UTC) FILETIME=[14A300E0:01C3944F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm curently locked in to using this old RedHat 7.3 with
the old 2.4.18 kernel. I need the see what's going on with
skbuffs in the ethernet driver, in this case the broadcom
bcm5700. When running 2.6 I use the tg3 driver and it's
wonderfull. Getting the Broadcom driver to like without
being a module looked more difficult that just using an
older version of the tg3.c driver. I updated the old 0.99
version (Jun 11, 2002) to know about the Serverworks Card:

	{ PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC1001,
          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
        { PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC1003,
          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
        { PCI_VENDOR_ID_ALTIMA, PCI_DEVICE_ID_ALTIMA_AC9100,
          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },

        { PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_0X14,
							/* Piet */
          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
        { 0, }

and the device is matched ok now. Unfortunately when it does
the probe it fails:
--------------------------------------------------------------------
(gdb) where

#0  pcnet32_probe_pci (pdev=0xc16b3000, ent=0x0) at pcnet32.c:493
#1  0xc028213d in pci_announce_device (drv=<incomplete type>,
dev=0xc16b3000) at
 pci.c:626
#2  0xc02821a2 in pci_register_driver (drv=<incomplete type>) at
pci.c:653
#3  0xc042ffd0 in pcnet32_init_module () at
/home/piet2/src/stonefly/perf/eng/ba
sebuilds/stonefly/kernel/linux-2.4.18-10/include/linux/pci.h:686
#4  0xc041c7a2 in do_initcalls () at init/main.c:427
#5  0xc010503b in init (unused=0x0) at init/main.c:537
(gdb)
------------------------------------------------------------------------
tg3.c:v0.99 (Jun 11, 2002)
tg3: Cannot find proper PCI device base address, aborting.
tg3: Cannot find proper PCI device base address, aborting.
tg3: Cannot find proper PCI device base address, aborting.
PCI: Assigned IRQ 7 for device 02:00.0
tg3: Problem fetching invariants of chip, aborting.
PCI: Assigned IRQ 5 for device 02:00.1
tg3: Problem ", aborting.
PCI: Assigned IRQ 7 for device 03:06.0
tg3: Problem fetching invariants of chip, aborting.
PCI: Assigned IRQ 5 for device 03:06.1
tg3: Problem fetching invariants of chip, aborting.
---------------------------------------------------------------------------

What does "fetching invariants of chip" mean?

I thought one of you guys might have a suggestion.

The tg3 driver looks cleaner than the Brodcom addon.
I could also modify the driver so it doesn't have to
be built as a module.

-piet


-- 

