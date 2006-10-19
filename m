Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWJSJWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWJSJWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWJSJWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:22:00 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:3032 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1030360AbWJSJV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:21:59 -0400
Message-ID: <453743B2.2040004@atmel.com>
Date: Thu, 19 Oct 2006 11:21:54 +0200
From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Organization: Atmel
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: dbrownell@users.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.6.18] resend of spi set kset of master class dev explicitly
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------010008040004040206010005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010008040004040206010005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

<quote Imre Deak from Thu, 12 Jan 2006 21:18:54 +0200>
In order for spi_busnum_to_master to work spi master devices must be
linked into the spi_master_class.subsys.kset list. At the moment the
default class_obj_subsys.kset is used and we can't enumerate the master
devices.
</quote>

Patch is updated to match the 2.6.18 kernel.

Signed-off-by: Hans-Christian Egtvedt <hcegtvedt@atmel.com>

-- 
With kind regards,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab

--------------010008040004040206010005
Content-Type: text/x-patch;
 name="spi-set-kset-of-master-class-dev-explicitly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spi-set-kset-of-master-class-dev-explicitly.patch"

--- a/drivers/spi/spi.c	2006-10-19 11:13:21.000000000 +0200
+++ b/drivers/spi/spi.c	2006-10-19 11:13:04.000000000 +0200
@@ -367,6 +367,7 @@ spi_alloc_master(struct device *dev, uns
 
 	class_device_initialize(&master->cdev);
 	master->cdev.class = &spi_master_class;
+	kobj_set_kset_s(&master->cdev, spi_master_class.subsys);
 	master->cdev.dev = get_device(dev);
 	spi_master_set_devdata(master, &master[1]);
 

--------------010008040004040206010005--
