Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUHSMDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUHSMDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 08:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUHSMDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 08:03:51 -0400
Received: from gprs214-117.eurotel.cz ([160.218.214.117]:29056 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265974AbUHSMDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 08:03:39 -0400
Date: Thu, 19 Aug 2004 14:03:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Mark old power managment as deprecated and clean it up
Message-ID: <20040819120325.GA21988@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch kills unused constants from old pm_send() interface, and
marks it as deprecated. Please apply,
								Pavel

--- linux-mm.middle/include/linux/pm.h	2004-08-15 19:15:05.000000000 +0200
+++ linux-mm/include/linux/pm.h	2004-08-19 13:59:43.000000000 +0200
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
@@ -186,6 +171,8 @@
 
 #endif /* CONFIG_PM */
 
+/* Functions above this comment are list-based old-style power
+ * managment. Please avoid using them.  */
 
 /*
  * Callbacks for platform drivers to implement.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
