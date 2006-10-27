Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946424AbWJ0LhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946424AbWJ0LhF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946438AbWJ0Lgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:36:44 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:62971 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1946423AbWJ0LgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:36:15 -0400
Date: Fri, 27 Oct 2006 13:36:52 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [Patch 3/7] driver core fixes: device_register() retval check in
 platform.c
Message-ID: <20061027133652.2a484482@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
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
 1 file changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6.orig/drivers/base/platform.c
+++ linux-2.6/drivers/base/platform.c
@@ -563,8 +563,15 @@ EXPORT_SYMBOL_GPL(platform_bus_type);
 
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
