Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWJIJEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWJIJEP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 05:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWJIJEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 05:04:15 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:25824 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S932418AbWJIJEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 05:04:15 -0400
Date: Mon, 9 Oct 2006 18:04:30 +0900
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] driver core: kmalloc() failure check
Message-ID: <20061009090430.GA6209@localhost>
Mail-Followup-To: akinobu.mita@gmail.com, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: akinobu.mita@gmail.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

driver_probe_device() is missing kmalloc() failure check.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/base/dd.c |    2 ++
 1 file changed, 2 insertions(+)

Index: work-fault-inject/drivers/base/dd.c
===================================================================
--- work-fault-inject.orig/drivers/base/dd.c	2006-10-09 15:06:35.000000000 +0900
+++ work-fault-inject/drivers/base/dd.c	2006-10-09 15:09:07.000000000 +0900
@@ -171,6 +171,8 @@ int driver_probe_device(struct device_dr
 		 drv->bus->name, dev->bus_id, drv->name);
 
 	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 	data->drv = drv;
 	data->dev = dev;
 
