Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVCOGex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVCOGex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 01:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVCOGex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 01:34:53 -0500
Received: from waste.org ([216.27.176.166]:33957 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262287AbVCOGej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 01:34:39 -0500
Date: Mon, 14 Mar 2005 22:34:36 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] reduce __deprecated spew
Message-ID: <20050315063436.GN32638@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes a couple of the noisier deprecations to only warn
on the primary entrypoint (in these cases, the _register functions).
This approach makes it obvious that an interface is going away while
only warning once per user. I suggest we adopt this approach for
future deprecation campaigns.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: bk/include/linux/pm.h
===================================================================
--- bk.orig/include/linux/pm.h	2005-03-14 22:14:59.000000000 -0800
+++ bk/include/linux/pm.h	2005-03-14 22:17:48.000000000 -0800
@@ -108,17 +108,17 @@ struct pm_dev __deprecated *pm_register(
 /*
  * Unregister a device with power management
  */
-void __deprecated pm_unregister(struct pm_dev *dev);
+void /*deprecated*/ pm_unregister(struct pm_dev *dev);
 
 /*
  * Unregister all devices with matching callback
  */
-void __deprecated pm_unregister_all(pm_callback callback);
+void /*deprecated*/ pm_unregister_all(pm_callback callback);
 
 /*
  * Send a request to all devices
  */
-int __deprecated pm_send_all(pm_request_t rqst, void *data);
+int /*deprecated*/ pm_send_all(pm_request_t rqst, void *data);
 
 #else /* CONFIG_PM */
 
Index: bk/include/linux/module.h
===================================================================
--- bk.orig/include/linux/module.h	2005-03-14 22:14:59.000000000 -0800
+++ bk/include/linux/module.h	2005-03-14 22:17:50.000000000 -0800
@@ -562,9 +562,9 @@ __MODULE_PARM_TYPE(var, type);
 #define HAVE_INTER_MODULE
 extern void __deprecated inter_module_register(const char *,
 		struct module *, const void *);
-extern void __deprecated inter_module_unregister(const char *);
-extern const void * __deprecated inter_module_get_request(const char *,
+extern void /*deprecated*/ inter_module_unregister(const char *);
+extern const void * /*deprecated*/ inter_module_get_request(const char *,
 		const char *);
-extern void __deprecated inter_module_put(const char *);
+extern void /*deprecated*/ inter_module_put(const char *);
 
 #endif /* _LINUX_MODULE_H */


-- 
Mathematics is the supreme nostalgia of our time.
