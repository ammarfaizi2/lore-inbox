Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbULBIGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbULBIGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbULBIGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:06:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22184 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261398AbULBIF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:05:58 -0500
Message-ID: <41AECCD9.40808@pobox.com>
Date: Thu, 02 Dec 2004 03:05:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@lst.de>
Subject: [PATCH/RFC] deprecate some drivers
Content-Type: multipart/mixed;
 boundary="------------050705020208000308040007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050705020208000308040007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


I'm looking to eliminate some horribly broken/dup drivers.  Since 2.6 is 
an ongoing matter, I want a 'flashing-red warning sign' that drivers 
will soon be disappearing, rather than just killing the driver and 
listening for the screams.

IPhase driver is broken+abandoned, and xirtulip is 
broken+duplicate+abandoned, and are two prime candidates for my prefence 
of handling this matter:  CONFIG_DEPRECATED.

See patch for example.



--------------050705020208000308040007
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/net/Kconfig 1.100 vs edited =====
--- 1.100/drivers/net/Kconfig	2004-11-05 05:37:26 -05:00
+++ edited/drivers/net/Kconfig	2004-12-02 02:57:56 -05:00
@@ -2544,7 +2544,7 @@
 
 config IPHASE5526
 	tristate "Interphase 5526 Tachyon chipset based adapter support"
-	depends on NET_FC && SCSI && PCI && BROKEN
+	depends on NET_FC && SCSI && PCI && BROKEN && DEPRECATED
 	help
 	  Say Y here if you have a Fibre Channel adaptor of this kind.
 
===== drivers/net/tulip/Kconfig 1.12 vs edited =====
--- 1.12/drivers/net/tulip/Kconfig	2004-09-21 22:19:24 -04:00
+++ edited/drivers/net/tulip/Kconfig	2004-12-02 02:58:27 -05:00
@@ -150,7 +150,7 @@
 
 config PCMCIA_XIRTULIP
 	tristate "Xircom Tulip-like CardBus support (old driver)"
-	depends on NET_TULIP && CARDBUS && BROKEN_ON_SMP
+	depends on NET_TULIP && CARDBUS && BROKEN_ON_SMP && DEPRECATED
 	select CRC32
 	---help---
 	  This driver is for the Digital "Tulip" Ethernet CardBus adapters.
===== init/Kconfig 1.57 vs edited =====
--- 1.57/init/Kconfig	2004-10-27 16:16:47 -04:00
+++ edited/init/Kconfig	2004-12-02 02:59:27 -05:00
@@ -40,6 +40,20 @@
 
 	  If unsure, say Y
 
+config IGNORE_DEPRECATED
+	bool "Elide drivers soon to be removed from the kernel"
+	default y
+	help
+	  Select this option to avoid features and drivers
+	  that will soon be removed from the kernel.
+
+	  If unsure, say Y
+
+config DEPRECATED
+	bool
+	depends on !IGNORE_DEPRECATED
+	default y
+
 config BROKEN
 	bool
 	depends on !CLEAN_COMPILE

--------------050705020208000308040007--
