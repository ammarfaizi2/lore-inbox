Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbULYVUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbULYVUo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 16:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbULYVUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 16:20:44 -0500
Received: from gprs212-19.eurotel.cz ([160.218.212.19]:26498 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261568AbULYVUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 16:20:33 -0500
Date: Sat, 25 Dec 2004 22:20:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: pm: remove outdated docs
Message-ID: <20041225212021.GA20134@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

pm_access / pm_dev_idle was removed from recent kernels. This should
stop confusion... Please apply,
								Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- linux-cvs/Documentation/pm.txt	2004-10-28 17:21:21.000000000 +0200
+++ linux/Documentation/pm.txt	2004-10-26 12:44:23.000000000 +0200
@@ -91,54 +91,6 @@
 void pm_unregister_all(pm_callback cback);
 
 /*
- * Device idle/use detection
- *
- * In general, drivers for all devices should call "pm_access"
- * before accessing the hardware (ie. before reading or modifying
- * a hardware register).  Request or packet-driven drivers should
- * additionally call "pm_dev_idle" when a device is not being used.
- *
- * Examples:
- * 1) A keyboard driver would call pm_access whenever a key is pressed
- * 2) A network driver would call pm_access before submitting
- *    a packet for transmit or receive and pm_dev_idle when its
- *    transfer and receive queues are empty.
- * 3) A VGA driver would call pm_access before it accesses any
- *    of the video controller registers
- *
- * Ultimately, the PM policy manager uses the access and idle
- * information to decide when to suspend individual devices
- * or when to suspend the entire system
- */
-
-/*
- * Description: Update device access time and wake up device, if necessary
- *
- * Parameters:
- *   dev - PM device previously returned from pm_register
- *
- * Details: If called from an interrupt handler pm_access updates
- *          access time but should never need to wake up the device
- *          (if device is generating interrupts, it should be awake
- *          already)  This is important as we can not wake up
- *          devices from an interrupt handler.
- */
-void pm_access(struct pm_dev *dev);
-
-/*
- * Description: Identify device as currently being idle
- *
- * Parameters:
- *   dev - PM device previously returned from pm_register
- *
- * Details: A call to pm_dev_idle might signal to the policy manager
- *          to put a device to sleep.  If a new device request arrives
- *          between the call to pm_dev_idle and the pm_callback
- *          callback, the driver should fail the pm_callback request.
- */
-void pm_dev_idle(struct pm_dev *dev);
-
-/*
  * Power management request callback
  *
  * Parameters:

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
