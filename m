Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWCKEB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWCKEB7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 23:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWCKEB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 23:01:59 -0500
Received: from fmr14.intel.com ([192.55.52.68]:39142 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932400AbWCKEB6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 23:01:58 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6 patch] drivers/acpi/video.c: fix a NULL pointer dereference
Date: Fri, 10 Mar 2006 23:00:45 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3006596EE5@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] drivers/acpi/video.c: fix a NULL pointer dereference
Thread-Index: AcZEZYSn9XOpjHvVQ8+UleFCkh0PYQAWrviw
From: "Brown, Len" <len.brown@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Mar 2006 04:00:47.0572 (UTC) FILETIME=[60D68940:01C644C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The Coverity checker spotted this obvious bug in 
>acpi_video_device_lcd_query_levels().
>
>
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>--- linux-2.6.16-rc5-mm3-full/drivers/acpi/video.c.old	
>2006-03-10 18:04:18.000000000 +0100
>+++ linux-2.6.16-rc5-mm3-full/drivers/acpi/video.c	
>2006-03-10 18:04:33.000000000 +0100
>@@ -321,11 +321,11 @@ acpi_video_device_lcd_query_levels(struc
> 
> 	status = acpi_evaluate_object(device->handle, "_BCL", 
>NULL, &buffer);
> 	if (!ACPI_SUCCESS(status))
> 		return_VALUE(status);
> 	obj = (union acpi_object *)buffer.pointer;
>-	if (!obj && (obj->type != ACPI_TYPE_PACKAGE)) {
>+	if (obj && (obj->type != ACPI_TYPE_PACKAGE)) {

how about
+	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {

> 		ACPI_ERROR((AE_INFO, "Invalid _BCL data"));
> 		status = -EFAULT;
> 		goto err;
> 	}
> 
>
