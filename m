Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318935AbSHSQvb>; Mon, 19 Aug 2002 12:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318937AbSHSQvb>; Mon, 19 Aug 2002 12:51:31 -0400
Received: from [209.47.40.2] ([209.47.40.2]:9235 "EHLO mailnet.consensys.com")
	by vger.kernel.org with ESMTP id <S318935AbSHSQva>;
	Mon, 19 Aug 2002 12:51:30 -0400
Message-ID: <030701c247a1$55d19320$4902a8c0@consensys.com>
From: "Jason Zebchuk" <jason@consensys.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] pci_do_scan_bus - 2.5.31
Date: Mon, 19 Aug 2002 12:56:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I've found a small problem in the patch I submitted last week to fix
pci_do_scan_bus.  The pci_dev that was allocated was not properly
initialised and this could cause any number of problems with booting.

    I've fixed that problem, and I also changed the BUG() to a panic() as
per Andi Kleen's suggestion.


Jason Zebchuk
Consensys RAIDZONE


--- linux-2.5.31/drivers/pci/probe.c    Tue Aug  6 12:40:20 2002
+++ linux/drivers/pci/probe.c   Mon Aug 19 09:41:43 2002
@@ -505,8 +505,8 @@
        /* Create a device template */
        dev0 = kmalloc(sizeof(struct pci_dev), GFP_ATOMIC);
        if (dev0 == NULL)
-               BUG();
-       memset(dev0, 0, sizeof(dev0));
+               panic("Unable to allocate pci_dev!");
+       memset(dev0, 0, sizeof(*dev0));
        dev0->bus = bus;
        dev0->sysdata = bus->sysdata;
        dev0->dev.parent = bus->dev;

