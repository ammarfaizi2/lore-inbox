Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVCCXQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVCCXQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVCCXQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:16:49 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:40176 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262683AbVCCXPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:15:44 -0500
Date: Thu, 3 Mar 2005 15:15:43 -0800
From: Todd Poynor <tpoynor@mvista.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/power/disk.c trivial cleanups
Message-ID: <20050303231543.GA28559@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove duplicate include.

* Avoid "mode set to ''" message when error updating /sys/power/disk.

Signed-off-by: Todd Poynor <tpoynor@mvista.com>

--- linux-2.6.11-rc4-orig/kernel/power/disk.c	2005-02-23 09:47:03.000000000 -0800
+++ linux-2.6.11-rc4-pm/kernel/power/disk.c	2005-03-03 05:00:18.609860968 -0800
@@ -16,7 +16,6 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
-#include <linux/device.h>
 #include "power.h"
 
 
@@ -321,8 +320,9 @@
 	} else
 		error = -EINVAL;
 
-	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
-		 pm_disk_modes[mode]);
+	if (mode == pm_disk_mode)
+		pr_debug("PM: suspend-to-disk mode set to '%s'\n",
+			 pm_disk_modes[mode]);
 	up(&pm_sem);
 	return error ? error : n;
 }
