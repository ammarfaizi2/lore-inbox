Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTLUCWx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 21:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTLUCWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 21:22:52 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26076 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261967AbTLUCWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 21:22:47 -0500
Date: Sun, 21 Dec 2003 03:22:42 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-net@vger.kernel.org, dbrownell@users.sourceforge.net
Cc: jgarzik@pobox.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] let USB_{PEGASUS,USBNET} depend on NET_ETHERNET
Message-ID: <20031221022242.GT12750@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I observed the following small problem in 2.6:

- MII depends on NET_ETHERNET
- USB_PEGASUS and USB_USBNET select MII, but they depend only on NET
 
The patch below lets USB_PEGASUS and USB_USBNET depend on NET_ETHERNET 
instead of NET to fix this issue.

Please apply
Adrian

--- linux-2.6.0-test11-mm1-modular-no-smp/drivers/usb/net/Kconfig.old	2003-12-21 03:18:32.000000000 +0100
+++ linux-2.6.0-test11-mm1-modular-no-smp/drivers/usb/net/Kconfig	2003-12-21 03:18:55.000000000 +0100
@@ -69,7 +69,7 @@
 
 config USB_PEGASUS
 	tristate "USB Pegasus/Pegasus-II based ethernet device support"
-	depends on USB && NET
+	depends on USB && NET_ETHERNET
 	select MII
 	---help---
 	  Say Y here if you know you have Pegasus or Pegasus-II based adapter.
@@ -95,7 +95,7 @@
 
 config USB_USBNET
 	tristate "Multi-purpose USB Networking Framework"
-	depends on USB && NET
+	depends on USB && NET_ETHERNET
 	select CRC32
 	select MII
 	---help---
