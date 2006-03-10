Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbWCJRJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWCJRJR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbWCJRJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:09:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13073 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751680AbWCJRJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:09:16 -0500
Date: Fri, 10 Mar 2006 18:09:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/acpi/video.c: fix a NULL pointer dereference
Message-ID: <20060310170915.GP21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this obvious bug in 
acpi_video_device_lcd_query_levels().



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/acpi/video.c.old	2006-03-10 18:04:18.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/acpi/video.c	2006-03-10 18:04:33.000000000 +0100
@@ -321,11 +321,11 @@ acpi_video_device_lcd_query_levels(struc
 
 	status = acpi_evaluate_object(device->handle, "_BCL", NULL, &buffer);
 	if (!ACPI_SUCCESS(status))
 		return_VALUE(status);
 	obj = (union acpi_object *)buffer.pointer;
-	if (!obj && (obj->type != ACPI_TYPE_PACKAGE)) {
+	if (obj && (obj->type != ACPI_TYPE_PACKAGE)) {
 		ACPI_ERROR((AE_INFO, "Invalid _BCL data"));
 		status = -EFAULT;
 		goto err;
 	}
 

