Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268172AbUHFQdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268172AbUHFQdr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268173AbUHFQdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:33:46 -0400
Received: from [80.190.193.18] ([80.190.193.18]:1432 "EHLO mx.vsadmin.de")
	by vger.kernel.org with ESMTP id S268172AbUHFQdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:33:35 -0400
From: Stefan Meyknecht <sm0407@nurfuerspam.de>
Subject: [PATCH] cdrom: MO-drive open write fix (trivial)
Date: Fri, 6 Aug 2004 18:33:30 +0200
User-Agent: KMail/1.6.2
To: linux-kernel@vger.kernel.org
Cc: axboe@image.dk
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408061833.30751.sm0407@nurfuerspam.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] cdrom: MO-drive open write fix

Allow mounting mo-drives readwrite.

Please apply.

Stefan


--- linux/drivers/cdrom/cdrom.c.orig	2004-08-06 18:04:16.269803330 +0200
+++ linux/drivers/cdrom/cdrom.c	2004-08-06 18:04:33.570828588 +0200
@@ -899,7 +899,7 @@ int cdrom_open(struct cdrom_device_info 
 			ret = -EROFS;
 			if (cdrom_open_write(cdi))
 				goto err;
-			if (!CDROM_CAN(CDC_RAM))
+			if (!CDROM_CAN(CDC_RAM) && !CDROM_CAN(CDC_MO_DRIVE))
 				goto err;
 			ret = 0;
 		}


--
Stefan Meyknecht
stefan at meyknecht dot org
