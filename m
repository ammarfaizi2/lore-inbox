Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTJUTKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTJUTKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:10:10 -0400
Received: from fmr06.intel.com ([134.134.136.7]:48326 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263235AbTJUTKF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:10:05 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] 1/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Date: Tue, 21 Oct 2003 11:57:58 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6007791F@scsmsx403.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 1/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Thread-Index: AcOX/JK0/uBX8c51R4q2A8Phz9qLRAABSlnw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Ducrot Bruno" <ducrot@poupinou.org>
Cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>
X-OriginalArrivalTime: 21 Oct 2003 18:58:00.0365 (UTC) FILETIME=[3F78DDD0:01C39805]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ducrot Bruno [mailto:ducrot@poupinou.org] 
> Sent: Tuesday, October 21, 2003 10:56 AM
> 
> > It will work any processor 
> > that is ACPI compatible and again there are no specific 
> > checks for Intel here.
> > 
> 
> On a K7 with powernow for example, perf_ctrl and perf_data 
> will be MSR 0
> with your patch, that do not make sence.
> Even if you know the correct MSRs, the values for 'control' 
> and 'status'
> in _PSS packages will be only bit-fields, and they can *not* be
> written nor read directly to the (correct) MSRs (again for K7 
> powernow).
> 
> This is because the FfixedHW is only an indication that a CPU specific
> 'feature' (even though already somehow defined in ACPI like P-state,
> C-state, etc.) have to be handled by the OS in a non-acpi driver, as
> per ACPI spec, and that will be dependant of the CPU.
> 

Agree with most of your comments. 
Current ACPI P-state driver ignored everything other than SYSTEM_IO.
And we are trying to add support for FIXED_HW. I was unaware of
any other CPU using ACPI PCT FIXED_HW to mean anything other than
MSR. As you mentioned, if K7 indeed exports some ACPI-PCT information 
to mean something else, then that is a real bug in my patch. I will 
add CPU specific abstraction to handle FIXED_HW get/set functions in 
the next revision of the patch. 

Thanks,
-Venkatesh
