Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268951AbTCDBT7>; Mon, 3 Mar 2003 20:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268952AbTCDBT6>; Mon, 3 Mar 2003 20:19:58 -0500
Received: from palrel12.hp.com ([156.153.255.237]:13466 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S268951AbTCDBT5>;
	Mon, 3 Mar 2003 20:19:57 -0500
Date: Mon, 3 Mar 2003 17:30:20 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, linux@brodo.de
Subject: [PATCH 2.5] : i82365 & platform_bus_type
Message-ID: <20030304013020.GC11349@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I'm trying to get i82365 to work again, because I need to test
802.11 drivers (hint : most Pcmcia carrier sold alongside 802.11 cards
are 16 bits only).
	Trying to make the driver compile and load in 2.5.63, I've
made the fix bellow. Seeing the obviousness of the bug, it seems that
nobody is using modules anymore ;-)
-------------------------------------------------
diff -u -p linux/drivers/base/platform.c.original linux/drivers/base/platform.c
--- linux/drivers/base/platform.c.original      Mon Mar  3 17:01:17 2003
+++ linux/drivers/base/platform.c       Mon Mar  3 17:02:22 2003
@@ -60,5 +60,6 @@ static int __init platform_bus_init(void
 
 postcore_initcall(platform_bus_init);
 
+EXPORT_SYMBOL(platform_bus_type);
 EXPORT_SYMBOL(platform_device_register);
 EXPORT_SYMBOL(platform_device_unregister);

-------------------------------------------------

	It now loads, but ends up in :
---------------------------------------
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: 
  Vadem VG-469 ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
    host opts [0]: none
    host opts [1]: none
    ISA irqs (scanned) = 4,5 polling interval = 1000 ms
ds: no socket drivers loaded!
---------------------------------------

	<Rant about post-freeze deleted>

	Have fun...

	Jean
