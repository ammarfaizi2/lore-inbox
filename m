Return-Path: <linux-kernel-owner+w=401wt.eu-S965112AbWLMTyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWLMTyv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWLMTyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:54:24 -0500
Received: from ns.suse.de ([195.135.220.2]:45526 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965112AbWLMTyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:54:20 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Scott Wood <scottwood@freescale.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/14] Driver core: Make platform_device_add_data accept a const pointer
Date: Wed, 13 Dec 2006 11:53:04 -0800
Message-Id: <11660396303225-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <11660396273898-git-send-email-greg@kroah.com>
References: <20061213195226.GA6736@kroah.com> <1166039585152-git-send-email-greg@kroah.com> <11660395913232-git-send-email-greg@kroah.com> <11660395951158-git-send-email-greg@kroah.com> <11660395998-git-send-email-greg@kroah.com> <11660396032350-git-send-email-greg@kroah.com> <1166039606191-git-send-email-greg@kroah.com> <11660396091326-git-send-email-greg@kroah.com> <11660396133624-git-send-email-greg@kroah.com> <11660396163757-git-send-email-greg@kroah.com> <11660396202644-git-send-email-greg@kroah.com> <11660396233517-git-send-email-greg@kroah.com> <11660396273898-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <scottwood@freescale.com>

platform_device_add_data() makes a copy of the data that is given to it,
and thus the parameter can be const.  This removes a warning when data
from get_property() on powerpc is handed to platform_device_add_data(),
as get_property() returns a const pointer.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/platform.c         |    2 +-
 include/linux/platform_device.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0338289..f9c903b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -212,7 +212,7 @@ EXPORT_SYMBOL_GPL(platform_device_add_resources);
  *	pointer.  The memory associated with the platform data will be freed
  *	when the platform device is released.
  */
-int platform_device_add_data(struct platform_device *pdev, void *data, size_t size)
+int platform_device_add_data(struct platform_device *pdev, const void *data, size_t size)
 {
 	void *d;
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 20f47b8..8bbd459 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -39,7 +39,7 @@ extern struct platform_device *platform_device_register_simple(char *, unsigned
 
 extern struct platform_device *platform_device_alloc(const char *name, unsigned int id);
 extern int platform_device_add_resources(struct platform_device *pdev, struct resource *res, unsigned int num);
-extern int platform_device_add_data(struct platform_device *pdev, void *data, size_t size);
+extern int platform_device_add_data(struct platform_device *pdev, const void *data, size_t size);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
-- 
1.4.4.2

