Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277333AbRJOIZp>; Mon, 15 Oct 2001 04:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275841AbRJOIZf>; Mon, 15 Oct 2001 04:25:35 -0400
Received: from ns.caldera.de ([212.34.180.1]:32477 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S277333AbRJOIZa>;
	Mon, 15 Oct 2001 04:25:30 -0400
Date: Mon, 15 Oct 2001 10:21:10 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: stelian.pop@fr.alcove.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: PATCH: sonypi wrongly claims ownership of ISA and ACPI bridges 
Message-ID: <20011015102110.A21699@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stelian,

Your sonypi driver claims the ownership of 2 Intel ACPI bridges and 1 ISA 
bridge.

All 3 are used in standard Intel chipsets, not just in Sony VAIOs.

Please do not use them, it confuses the hell out of the autoprobing and
automatic PCI driver registration.

I suggest checking up if this device has PnPBIOS entries and using them,
or using a different method of autoprobing.

Ciao, Marcus

Index: sonypi.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/char/sonypi.c,v
retrieving revision 1.20
diff -u -r1.20 sonypi.c
--- sonypi.c	2001/10/14 19:13:21	1.20
+++ sonypi.c	2001/10/15 08:16:25
@@ -689,8 +689,6 @@
 	{ }
 };
 
-MODULE_DEVICE_TABLE(pci, sonypi_id_tbl);
-
 static struct pci_driver sonypi_driver = {
 	name:		"sonypi",
 	id_table:	sonypi_id_tbl,
