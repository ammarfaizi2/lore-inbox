Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752339AbWCKDdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbWCKDdo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 22:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbWCKDdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 22:33:44 -0500
Received: from fmr17.intel.com ([134.134.136.16]:60587 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752338AbWCKDdo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 22:33:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: acpi thermal driver leaks in failure path
Date: Fri, 10 Mar 2006 22:32:29 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3006596EDD@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: acpi thermal driver leaks in failure path
Thread-Index: AcZDJ84RcoSx+nx0SduKtlG/OsPGGQBlJfpQ
From: "Brown, Len" <len.brown@intel.com>
To: "Dave Jones" <davej@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Mar 2006 03:32:31.0299 (UTC) FILETIME=[6DC7D130:01C644BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied.

thanks,
-Len 

>-----Original Message-----
>From: Dave Jones [mailto:davej@redhat.com] 
>Sent: Wednesday, March 08, 2006 10:12 PM
>To: Linux Kernel
>Cc: Brown, Len
>Subject: acpi thermal driver leaks in failure path
>
>Leaking memory in failure path.
>
>Coverity: #601
>Signed-off-by: Dave Jones <davej@redhat.com>
>
>--- linux-2.6/drivers/acpi/thermal.c~	2006-03-08 
>22:09:51.000000000 -0500
>+++ linux-2.6/drivers/acpi/thermal.c	2006-03-08 
>22:11:05.000000000 -0500
>@@ -942,8 +942,10 @@ acpi_thermal_write_trip_points(struct fi
> 	memset(limit_string, 0, ACPI_THERMAL_MAX_LIMIT_STR_LEN);
> 
> 	active = kmalloc(ACPI_THERMAL_MAX_ACTIVE * sizeof(int), 
>GFP_KERNEL);
>-	if (!active)
>+	if (!active) {
>+		kfree(limit_string);
> 		return_VALUE(-ENOMEM);
>+	}
> 
> 	if (!tz || (count > ACPI_THERMAL_MAX_LIMIT_STR_LEN - 1)) {
> 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument\n"));
>-- 
>http://www.codemonkey.org.uk
>
