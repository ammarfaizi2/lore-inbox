Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264845AbTFBSiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264840AbTFBSiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:38:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:26585 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264845AbTFBSiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:38:00 -0400
Date: Mon, 2 Jun 2003 20:51:53 +0200
From: Arne Brutschy <abrutschy@xylon.de>
X-Mailer: The Bat! (v1.62r) Personal
Reply-To: Arne Brutschy <abrutschy@xylon.de>
Organization: Xylon
X-Priority: 3 (Normal)
Message-ID: <515243431.20030602205153@xylon.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ide driver 2.4.21-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the Promise 20276 IDE controller without raid function
doesn't work with 2.4.21*.

If you want to use the IDE controller just as plain controller without
Promise software raid (i.e. if you prefer to trust the linux software
raid), the kernel always reports this:

PDC20276: IDE controller at PCI slot 02:02.0
PDC20276: chipset revision 1
PDC20276: not 100% native mode: will probe irqs later
PDC20276: neither IDE port enabled (BIOS)

Afterwards, the kernel disables the controller. This has been reported
by serveral other users. This small patch solves the problem.

Arne


--- linux-2.4.21-rc6/drivers/ide/setup-pci.c.orig       2003-06-01 11:38:23.000000000 +0200
+++ linux-2.4.21-rc6/drivers/ide/setup-pci.c    2003-06-01 11:40:12.000000000 +0200
@@ -640,7 +640,8 @@
                 */
                if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
                     ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
-                     (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
+                     (d->device == PCI_DEVICE_ID_PROMISE_20265) ||
+                     (d->device == PCI_DEVICE_ID_PROMISE_20276))) &&
                    (secondpdc++==1) && (port==1))
                        goto controller_ok;

