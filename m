Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161211AbWALTlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbWALTlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161214AbWALTlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:41:16 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:22688 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP
	id S1161211AbWALTlP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:41:15 -0500
Subject: [PATCH] spi: set kset of master class dev explicitly
From: Imre Deak <imre.deak@nokia.com>
To: david-b@pacbell.net
Cc: Linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Nokia
Date: Thu, 12 Jan 2006 21:18:54 +0200
Message-Id: <1137093534.5226.14.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jan 2006 19:23:00.0909 (UTC) FILETIME=[9A1E35D0:01C617AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order for spi_busnum_to_master to work spi master devices must be
linked into the spi_master_class.subsys.kset list. At the moment the
default class_obj_subsys.kset is used and we can't enumerate the master
devices.

Signed-off-by: Imre Deak <imre.deak@nokia.com>

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6d54112..3cb1ec4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -366,6 +366,7 @@ spi_alloc_master(struct device *dev, uns
 
 	class_device_initialize(&master->cdev);
 	master->cdev.class = &spi_master_class;
+	kobj_set_kset_s(&master->cdev, spi_master_class.subsys);
 	master->cdev.dev = get_device(dev);
 	spi_master_set_devdata(master, &master[1]);
 


