Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757565AbWK0Jeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565AbWK0Jeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 04:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757596AbWK0Jeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 04:34:50 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:6034 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1757565AbWK0Jeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 04:34:31 -0500
Date: Mon, 27 Nov 2006 10:35:08 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 3/7] driver core fixes: device_register() retval check in
 platform.c
Message-ID: <20061127103508.36d36539@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check the return value of device_register() in platform_bus_init().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---

 drivers/base/platform.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6-CH.orig/drivers/base/platform.c
+++ linux-2.6-CH/drivers/base/platform.c
@@ -611,8 +611,15 @@ EXPORT_SYMBOL_GPL(platform_bus_type);
 
 int __init platform_bus_init(void)
 {
-	device_register(&platform_bus);
-	return bus_register(&platform_bus_type);
+	int error;
+
+	error = device_register(&platform_bus);
+	if (error)
+		return error;
+	error =  bus_register(&platform_bus_type);
+	if (error)
+		device_unregister(&platform_bus);
+	return error;
 }
 
 #ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
