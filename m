Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbUJZDMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUJZDMC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUJZC4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:56:23 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:60556 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262066AbUJZCu2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:50:28 -0400
Message-ID: <417DBB6B.3030307@rtr.ca>
Date: Mon, 25 Oct 2004 22:50:19 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.9-ac4] delkin_cb: one-liner fix
Content-Type: multipart/mixed;
 boundary="------------000700020604080101010100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000700020604080101010100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan,

Here's a one-liner for delkin_cb in your latest 2.6.9-ac stream.
This ensures that pci_disable_device() is invoked when the
driver exits on failure to load.

Signed-off-by: Mark Lord <mlord@pobox.com>
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")

--------------000700020604080101010100
Content-Type: text/plain;
 name="delkin-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="delkin-fix.patch"

--- linux-2.6.9-ac3-delkin/drivers/ide/pci/delkin_cb.c.orig	2004-10-21 21:44:45.000000000 -0400
+++ linux/drivers/ide/pci/delkin_cb.c	2004-10-25 22:45:32.000000000 -0400
@@ -83,6 +83,7 @@
 	rc = ide_register_hw(&hw, &hwif);
 	if (rc < 0) {
 		printk(KERN_ERR "delkin_cb: ide_register_hw failed (%d)\n", rc);
+		pci_disable_device(dev);
 		return -ENODEV;
 	}
 	pci_set_drvdata(dev, hwif);

--------------000700020604080101010100--
