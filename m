Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWIMQlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWIMQlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWIMQlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:41:39 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:58442 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750732AbWIMQiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:38:18 -0400
Date: Wed, 13 Sep 2006 18:38:37 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [02/12] driver core fixes: device_register() retval check in
 platform.c
Message-ID: <20060913183837.5742c8ef@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check the return value of device_register() in platform_bus_init().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 platform.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc6/drivers/base/platform.c	2006-09-12 14:12:10.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/platform.c	2006-09-12 16:25:50.000000000 +0200
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
