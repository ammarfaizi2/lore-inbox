Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUJNUXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUJNUXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUJNSsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:48:21 -0400
Received: from gprs213-115.eurotel.cz ([160.218.213.115]:44416 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264113AbUJNSPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:15:15 -0400
Date: Thu, 14 Oct 2004 20:12:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Mark old list-based power managment as deprecated
Message-ID: <20041014181241.GA2115@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should prevent people from using pm_requests (etc) in new
code. If we have to create typedefs, we may as well use enums in
them. This is against -rc3, I'm not sure if pm_find was not killed
already in -mm.
								Pavel

--- /data/clean//include/linux/pm.h	2004-10-14 20:06:33.000000000 +0200
+++ linux/include/linux/pm.h	2004-10-07 13:12:46.000000000 +0200
@@ -28,33 +28,20 @@
 #include <asm/atomic.h>
 
 /*
- * Power management requests
+ * Power management requests... these are passed to pm_send_all() and friends.
+ *
+ * these functions are old and deprecated, see below.
  */
-enum
+typedef enum pm_request
 {
 	PM_SUSPEND, /* enter D1-D3 */
 	PM_RESUME,  /* enter D0 */
-
-	PM_SAVE_STATE,  /* save device's state */
-
-	/* enable wake-on */
-	PM_SET_WAKEUP,
-
-	/* bus resource management */
-	PM_GET_RESOURCES,
-	PM_SET_RESOURCES,
-
-	/* base station management */
-	PM_EJECT,
-	PM_LOCK,
-};
-
-typedef int pm_request_t;
+} pm_request_t;
 
 /*
- * Device types
+ * Device types... these are passed to pm_register
  */
-enum
+typedef enum pm_dev_type
 {
 	PM_UNKNOWN_DEV = 0, /* generic */
 	PM_SYS_DEV,	    /* system device (fan, KB controller, ...) */
@@ -63,9 +50,7 @@
 	PM_SCSI_DEV,	    /* SCSI device */
 	PM_ISA_DEV,	    /* ISA device */
 	PM_MTD_DEV,	    /* Memory Technology Device */
-};
-
-typedef int pm_dev_t;
+} pm_dev_t;
 
 /*
  * System device hardware ID (PnP) values
@@ -119,37 +104,30 @@
 /*
  * Register a device with power management
  */
-struct pm_dev *pm_register(pm_dev_t type,
-			   unsigned long id,
-			   pm_callback callback);
+struct pm_dev __deprecated *pm_register(pm_dev_t type, unsigned long id, pm_callback callback);
 
 /*
  * Unregister a device with power management
  */
-void pm_unregister(struct pm_dev *dev);
+void __deprecated pm_unregister(struct pm_dev *dev);
 
 /*
  * Unregister all devices with matching callback
  */
-void pm_unregister_all(pm_callback callback);
+void __deprecated pm_unregister_all(pm_callback callback);
 
 /*
  * Send a request to a single device
  */
-int pm_send(struct pm_dev *dev, pm_request_t rqst, void *data);
+int __deprecated pm_send(struct pm_dev *dev, pm_request_t rqst, void *data);
 
 /*
  * Send a request to all devices
  */
-int pm_send_all(pm_request_t rqst, void *data);
+int __deprecated pm_send_all(pm_request_t rqst, void *data);
 
-/*
- * Find a device
- */
-struct pm_dev *pm_find(pm_dev_t type, struct pm_dev *from);
-
-static inline void pm_access(struct pm_dev *dev) {}
-static inline void pm_dev_idle(struct pm_dev *dev) {}
+static inline void __deprecated pm_access(struct pm_dev *dev) {}
+static inline void __deprecated pm_dev_idle(struct pm_dev *dev) {}
 
 #else /* CONFIG_PM */
 
@@ -186,6 +164,8 @@
 
 #endif /* CONFIG_PM */
 
+/* Functions above this comment are list-based old-style power
+ * managment. Please avoid using them.  */
 
 /*
  * Callbacks for platform drivers to implement.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


