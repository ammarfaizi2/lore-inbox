Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757017AbWK0FRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757017AbWK0FRf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757019AbWK0FRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:17:35 -0500
Received: from nz-out-0102.google.com ([64.233.162.195]:4223 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1757005AbWK0FRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:17:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=JD5TX5NubZe9XmAMehp8O4Ujy4T7Z/ybDIr6K52/QqRtYYwshCWIAsBTNPBzUix4N2Woca85iRgoXL5P0ozOXMgahEJi9Ge/etPQmyqVz6oF1imoNeAjan0qOstfoxDrPCev3ijuawvznaLpjDOgbVdwmp49GqWJ/KK5nJTsQ+E=
Date: Mon, 27 Nov 2006 14:10:26 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] synclink_gt: fix init error handling
Message-ID: <20061127051026.GI1231@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialization synclink_gt forgot to unregister pci driver on error path.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 drivers/char/synclink_gt.c |    1 +
 1 file changed, 1 insertion(+)

Index: work-fault-inject/drivers/char/synclink_gt.c
===================================================================
--- work-fault-inject.orig/drivers/char/synclink_gt.c
+++ work-fault-inject/drivers/char/synclink_gt.c
@@ -3522,6 +3522,7 @@ static int __init slgt_init(void)
 
 	if (!slgt_device_list) {
 		printk("%s no devices found\n",driver_name);
+		pci_unregister_driver(&pci_driver);
 		return -ENODEV;
 	}
 
