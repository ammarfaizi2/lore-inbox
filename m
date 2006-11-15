Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbWKOOJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbWKOOJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 09:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWKOOJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 09:09:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:30143 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1030465AbWKOOJv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 09:09:51 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,425,1157353200"; 
   d="scan'208"; a="164293764:sNHT21255479"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.19-rc5-mm2
Date: Wed, 15 Nov 2006 06:09:47 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454E4109A@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rc5-mm2
Thread-Index: AccIocz2iST7HMENQHCzBRVrSuep/wAHKcBA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <ego@in.ibm.com>, "Reuben Farrelly" <reuben-linuxkernel@reub.net>,
       "Andrew Morton" <akpm@osdl.org>, <davej@redhat.com>,
       <linux-kernel@vger.kernel.org>,
       "CPUFreq Mailing List" <cpufreq@lists.linux.org.uk>,
       "Mattia Dongili" <malattia@linux.it>
X-OriginalArrivalTime: 15 Nov 2006 14:09:49.0332 (UTC) FILETIME=[B6485D40:01C708BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Gautham R Shenoy [mailto:ego@in.ibm.com] 
>Sent: Wednesday, November 15, 2006 2:34 AM
>To: Gautham R Shenoy; Reuben Farrelly; Andrew Morton; 
>davej@redhat.com; linux-kernel@vger.kernel.org; Pallipadi, 
>Venkatesh; CPUFreq Mailing List
>Subject: Re: 2.6.19-rc5-mm2
>
>Hi,
>
>On Tue, Nov 14, 2006 at 09:58:29PM +0100, Mattia Dongili wrote:
>> 
>> maybe this helps? mostly guessing here, but when cpufreq_userspace is
>> the default governor we may hit this path and leave policy->cur
>> unset.
>
>I doubt if that's causing the problem. My reasons are:
>
>- Reuben's config shows his system to be a x64_64. So if I am not
>  mistaken, the correct file look for would be 
>  arch/ia64/kernel/cpufreq/acpi-cpufreq.c.

ia64 and x86_64 are different!
X86_64 shares acpi-cpufreq.c in arch/i386/kernel/cpu/cpufreq. So, that
is the file that can be causing problems here.

>- The fix provided by you deals with the state of a 
>  driver(hardware) specific variable data->cpu_feature while the
>  governors like userspace/performance/powersave/ondemand are 
>  driver(hardware) independent.
>
>Nevertheless, it could be a valid fix for i386 acpi_cpufreq considering
>that policy->cur is not being initialized if 
>data->cpu_feature == ACPI_ADR_SPACE_FIXED_HARDWARE.

Yes. Patch from Mattia is indeed required for acpi-cpufreq. 
Mattia: Can you please send the patch towards Andrew (With signed off
etc) for inclusion.

Reuben: Can you please enable CPU_FREQ_DEBUG in your config and boot
with "cpufreq.debug=7" boot parameter and send me the log. That will
give some more debug information that should help to root cause this
faster.

Thanks,
Venki
