Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVDEVzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVDEVzX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVDEVwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:52:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2438 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262025AbVDEVuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:50:12 -0400
Date: Tue, 5 Apr 2005 23:49:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: fix stale PCI pm docs
Message-ID: <20050405214949.GA1881@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes u32 vs. pm_message_t confusion in documentation, and
removes references to no-longer-existing (*save_state), too. With
exception of USB (I hope David will fix/apply my patch), this should
fix last piece of this confusion... famous last words.

Please apply,

                                                                Pavel
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-mm/Documentation/power/pci.txt	2004-12-25 13:34:57.000000000 +0100
+++ linux-mm/Documentation/power/pci.txt	2005-04-05 12:13:16.000000000 +0200
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

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
