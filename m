Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWHKGag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWHKGag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWHKGaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:30:35 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:38924 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751622AbWHKGaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:30:35 -0400
Date: Fri, 11 Aug 2006 08:30:31 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>
Subject: [PATCH] acpi: Fix a broken kfree in i2c_ec
Message-Id: <20060811083031.69e20658.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an obviously broken kfree() in acpi/i2c_ec device initialization
error path.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
This function would benefit from some improvements (single error path,
kzalloc) but let's fix that obvious bug first. This would preferably go
to Linus before 2.6.18.

 drivers/acpi/i2c_ec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18-rc3.orig/drivers/acpi/i2c_ec.c	2006-07-26 23:03:57.000000000 +0200
+++ linux-2.6.18-rc3/drivers/acpi/i2c_ec.c	2006-08-01 16:22:45.000000000 +0200
@@ -330,7 +330,7 @@
 	status = acpi_evaluate_integer(ec_hc->handle, "_EC", NULL, &val);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Error obtaining _EC\n"));
-		kfree(ec_hc->smbus);
+		kfree(ec_hc);
 		kfree(smbus);
 		return -EIO;
 	}


-- 
Jean Delvare
