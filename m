Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265599AbUE0WgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265599AbUE0WgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 18:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbUE0WgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 18:36:22 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:36795 "EHLO
	biscayne-one-station.mit.edu") by vger.kernel.org with ESMTP
	id S265599AbUE0WgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 18:36:21 -0400
Date: Thu, 27 May 2004 18:36:16 -0400 (EDT)
From: Nickolai Zeldovich <kolya@MIT.EDU>
To: linux-kernel@vger.kernel.org
cc: torvalds@osdl.org
Subject: [PATCH] report which device failed to suspend
Message-ID: <Pine.GSO.4.55L.0405271835210.24218@scrubbing-bubbles.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When your machine stops suspending all of a sudden, a patch such as the
one below is helpful to diagnose which device or driver is misbehaving and
causing the suspend sequence to fail.

-- kolya

--- drivers/base/power/suspend.c	2004/05/27 22:09:47	1.1
+++ drivers/base/power/suspend.c	2004/05/27 22:28:36
@@ -42,6 +42,10 @@
 	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
 		error = dev->bus->suspend(dev,state);

+	if (error)
+		printk(KERN_ERR "Could not suspend device %s: error %d\n",
+			kobject_name(&dev->kobj), error);
+
 	return error;
 }

