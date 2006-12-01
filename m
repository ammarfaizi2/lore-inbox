Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759348AbWLASzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759348AbWLASzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759346AbWLASzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:55:31 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:16276 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1759348AbWLASza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:55:30 -0500
Date: Fri, 1 Dec 2006 12:54:47 -0600
From: Scott Wood <scottwood@freescale.com>
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make platform_device_add_data accept a const pointer.
Message-ID: <20061201185447.GA19669@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

platform_device_add_data() makes a copy of the data that is given to it,
and thus the parameter can be const.  This removes a warning when data
from get_property() on powerpc is handed to platform_device_add_data(),
as get_property() returns a const pointer.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/base/platform.c         |    2 +-
 include/linux/platform_device.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 940ce41..9cb2128 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -212,7 +212,7 @@ EXPORT_SYMBOL_GPL(platform_device_add_re
  *	pointer.  The memory associated with the platform data will be freed
  *	when the platform device is released.
  */
-int platform_device_add_data(struct platform_device *pdev, void *data, size_t size)
+int platform_device_add_data(struct platform_device *pdev, const void *data, size_t size)
 {
 	void *d;
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 29cd6de..cc21647 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -39,7 +39,7 @@ extern struct platform_device *platform_
 
 extern struct platform_device *platform_device_alloc(const char *name, unsigned int id);
 extern int platform_device_add_resources(struct platform_device *pdev, struct resource *res, unsigned int num);
-extern int platform_device_add_data(struct platform_device *pdev, void *data, size_t size);
+extern int platform_device_add_data(struct platform_device *pdev, const void *data, size_t size);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
-- 
1.4.2.3
