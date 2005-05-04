Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVEDHEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVEDHEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVEDHCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:02:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:59620 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262042AbVEDHCU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:02:20 -0400
Cc: pavel@ucw.cz
Subject: [PATCH] PCI: fix stale PCI pm docs
In-Reply-To: <1115190136453@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:02:16 -0700
Message-Id: <11151901361631@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: fix stale PCI pm docs

This fixes u32 vs. pm_message_t confusion in documentation, and
removes references to no-longer-existing (*save_state), too. With
exception of USB (I hope David will fix/apply my patch), this should
fix last piece of this confusion... famous last words.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 92df516e6264f9caff4be49718926d6884fa50ed
tree 1b09131f91db847c9f3d6de98ed5cc1ebd0e9325
parent a3ea7fbac12fdb2d70c90bb36f81afa3c66e18f4
author Pavel Machek <pavel@ucw.cz> 1112737789 +0200
committer Greg KH <gregkh@suse.de> 1115189114 -0700

Index: Documentation/power/pci.txt
===================================================================
--- be9655df6ea3a0cf2c53a0eb8ff8870962d46871/Documentation/power/pci.txt  (mode:100644 sha1:c85428e7ad9263487bf2ef6816e2bdd1379e2097)
+++ 1b09131f91db847c9f3d6de98ed5cc1ebd0e9325/Documentation/power/pci.txt  (mode:100644 sha1:35b1a7dae34253751ade84ca7f0eda948fac11dd)
@@ -165,40 +165,9 @@
 These functions are intended for use by individual drivers, and are defined in 
 struct pci_driver:
 
-        int  (*save_state) (struct pci_dev *dev, u32 state);
-        int  (*suspend) (struct pci_dev *dev, u32 state);
+        int  (*suspend) (struct pci_dev *dev, pm_message_t state);
         int  (*resume) (struct pci_dev *dev);
-        int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);
-
-
-save_state
-----------
-
-Usage:
-
-if (dev->driver && dev->driver->save_state)
-	dev->driver->save_state(dev,state);
-
-The driver should use this callback to save device state. It should take into
-account the current state of the device and the requested state in order to
-avoid any unnecessary operations.
-
-For example, a video card that supports all 4 states (D0-D3), all controller
-context is preserved when entering D1, but the screen is placed into a low power
-state (blanked). 
-
-The driver can also interpret this function as a notification that it may be
-entering a sleep state in the near future. If it knows that the device cannot
-enter the requested state, either because of lack of support for it, or because
-the device is middle of some critical operation, then it should fail.
-
-This function should not be used to set any state in the device or the driver
-because the device may not actually enter the sleep state (e.g. another driver
-later causes causes a global state transition to fail).
-
-Note that in intermediate low power states, a device's I/O and memory spaces may
-be disabled and may not be available in subsequent transitions to lower power
-states.
+        int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);
 
 
 suspend

