Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUFHKL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUFHKL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 06:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbUFHKL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 06:11:29 -0400
Received: from may.priocom.com ([213.156.65.50]:2197 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S264946AbUFHKLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 06:11:22 -0400
Subject: [PATCH] 2.6.6 invalid usage of GFP_DMA in drivers/scsi/pluto.c
From: Yury Umanets <torque@ukrpost.net>
To: akpm@osdl.org
Cc: jj@sunsite.mff.cuni.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086689511.2818.15.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 08 Jun 2004 13:11:51 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew, guys,

Found this, what seems to be an invalid usage of GFP_DMA flag. Is this
patch okay?

Thanks.

 ./linux-2.6.6-modified/drivers/scsi/pluto.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Signed-off-by: Yury Umanets <torque@ukrpost.net>

--- ./linux-2.6.6/drivers/scsi/pluto.c	Mon May 10 05:32:27 2004
+++ ./linux-2.6.6-modified/drivers/scsi/pluto.c	Tue Jun  8 11:26:07 2004
@@ -117,7 +117,8 @@ int __init pluto_detect(Scsi_Host_Templa
 #endif
 			return 0;
 	}
-	fcs = (struct ctrl_inquiry *) kmalloc (sizeof (struct ctrl_inquiry) *
fcscount, GFP_DMA);
+	fcs = (struct ctrl_inquiry *) kmalloc (sizeof (struct ctrl_inquiry) *
fcscount, 
+			GFP_KERNEL | GFP_DMA);
 	if (!fcs) {
 		printk ("PLUTO: Not enough memory to probe\n");
 		return 0;

-- 
umka

