Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755110AbWKQOBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbWKQOBs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbWKQOBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:01:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:58499 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1755103AbWKQOBr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:01:47 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,435,1157353200"; 
   d="scan'208"; a="165398647:sNHT21094836"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.19-rc5-mm2] cpufreq: set policy->curfreq on initialization
Date: Fri, 17 Nov 2006 06:01:45 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454E7610F@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.19-rc5-mm2] cpufreq: set policy->curfreq on initialization
Thread-Index: AccI6ZdBq3amunLFSuq5VrO+3iDd0wBZy+6Q
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Mattia Dongili" <malattia@linux.it>, <ego@in.ibm.com>,
       "Reuben Farrelly" <reuben-linuxkernel@reub.net>,
       "Andrew Morton" <akpm@osdl.org>, <davej@redhat.com>,
       <linux-kernel@vger.kernel.org>,
       "CPUFreq Mailing List" <cpufreq@lists.linux.org.uk>,
       "Sadykov, Denis M" <denis.m.sadykov@intel.com>
X-OriginalArrivalTime: 17 Nov 2006 14:01:47.0038 (UTC) FILETIME=[EBA3A3E0:01C70A50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Acked.
Andrew: Please include this patch in mm.

Thanks,
Venki 

>-----Original Message-----
>From: Mattia Dongili [mailto:malattia@linux.it] 
>Sent: Wednesday, November 15, 2006 11:05 AM
>To: Pallipadi, Venkatesh; ego@in.ibm.com; Reuben Farrelly; 
>Andrew Morton; davej@redhat.com; linux-kernel@vger.kernel.org; 
>CPUFreq Mailing List; Sadykov, Denis M
>Subject: [PATCH 2.6.19-rc5-mm2] cpufreq: set policy->curfreq 
>on initialization
>
>
>Check the correct variable and set policy->cur upon acpi-cpufreq
>initialization to allow the userspace governor to be used as default.
>
>Signed-off-by: Mattia Dongili <malattia@linux.it>
>
>---
>
>Reuben, could you also try if this patch fixes the BUG()?
>Thanks
>
>diff --git a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c 
>b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
>index 18f4715..a630f94 100644
>--- a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
>+++ b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
>@@ -699,14 +699,14 @@ static int acpi_cpufreq_cpu_init(struct
> 	if (result)
> 		goto err_freqfree;
> 
>-	switch (data->cpu_feature) {
>+	switch (perf->control_register.space_id) {
> 	case ACPI_ADR_SPACE_SYSTEM_IO:
> 		/* Current speed is unknown and not detectable 
>by IO port */
> 		policy->cur = acpi_cpufreq_guess_freq(data, 
>policy->cpu);
> 		break;
> 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
> 		acpi_cpufreq_driver.get = get_cur_freq_on_cpu;
>-		get_cur_freq_on_cpu(cpu);
>+		policy->cur = get_cur_freq_on_cpu(cpu);
> 		break;
> 	default:
> 		break;
>
