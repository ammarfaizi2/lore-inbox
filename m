Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVCREC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVCREC0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 23:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCREAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 23:00:49 -0500
Received: from soundwarez.org ([217.160.171.123]:46479 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261337AbVCREAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 23:00:12 -0500
Date: Fri, 18 Mar 2005 05:00:09 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 5/6] kobject/hotplug split - usb cris
Message-ID: <20050318040009.GA545@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_add() and kobject_del() don't emit hotplug events anymore.
We need to do it ourselves now.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/usb/host/hc_crisv10.c 1.7 vs edited =====
--- 1.7/drivers/usb/host/hc_crisv10.c	2004-12-21 02:15:10 +01:00
+++ edited/drivers/usb/host/hc_crisv10.c	2005-03-18 02:17:17 +01:00
@@ -4396,6 +4396,7 @@ static int __init etrax_usb_hc_init(void
         device_initialize(&fake_device);
         kobject_set_name(&fake_device.kobj, "etrax_usb");
         kobject_add(&fake_device.kobj);
+        kobject_hotplug(&fake_device.kobj, KOBJ_ADD);
         hc->bus->controller = &fake_device;
 	usb_register_bus(hc->bus);
 

