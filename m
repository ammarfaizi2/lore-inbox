Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWJRAQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWJRAQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 20:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWJRAQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 20:16:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:19795 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751327AbWJRAQV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 20:16:21 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,321,1157353200"; 
   d="scan'208"; a="146608250:sNHT23903313"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ACPI: Processor native C-states using MWAIT
Date: Tue, 17 Oct 2006 17:16:19 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454BE4286@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI: Processor native C-states using MWAIT
Thread-Index: AcbyQrCBUCQXE5n/TXKNZq7sfy7BCAAB84JA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Oct 2006 00:16:20.0645 (UTC) FILETIME=[A3374D50:01C6F24A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Acked

Andrew: Please apply this patch.

Thanks,
Venki 

>-----Original Message-----
>From: Darrick J. Wong [mailto:djwong@us.ibm.com] 
>Sent: Tuesday, October 17, 2006 4:19 PM
>To: Pallipadi, Venkatesh; Linux Kernel Mailing List
>Subject: Re: ACPI: Processor native C-states using MWAIT
>
>This patch breaks C-state discovery on my IBM IntelliStation Z30
>because the return value of acpi_processor_get_power_info_fadt is not
>assigned to "result" in the case that acpi_processor_get_power_info_cst
>returns -ENODEV.  Thus, if ACPI provides C-state data via the FADT and
>not _CST (as is the case on this machine), we incorrectly exit the
>function with -ENODEV after reading the FADT.  The attached patch
>sets the value of result so that we don't exit early.
>
>Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
>
>--
>
>diff --git a/drivers/acpi/processor_idle.c 
>b/drivers/acpi/processor_idle.c
>index 526387d..5c118cb 100644
>--- a/drivers/acpi/processor_idle.c
>+++ b/drivers/acpi/processor_idle.c
>@@ -962,7 +962,7 @@ static int acpi_processor_get_power_info
> 
> 	result = acpi_processor_get_power_info_cst(pr);
> 	if (result == -ENODEV)
>-		acpi_processor_get_power_info_fadt(pr);
>+		result = acpi_processor_get_power_info_fadt(pr);
> 
> 	if (result)
> 		return result;
>
