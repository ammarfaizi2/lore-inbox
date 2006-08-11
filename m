Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWHKVI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWHKVI4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWHKVI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:08:56 -0400
Received: from mga03.intel.com ([143.182.124.21]:12901 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751031AbWHKVIv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:08:51 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,115,1154934000"; 
   d="scan'208"; a="101994200:sNHT21816263"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: cpufreq stops working after a while
Date: Fri, 11 Aug 2006 14:08:32 -0700
Message-ID: <EB12A50964762B4D8111D55B764A84546F8F4F@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpufreq stops working after a while
thread-index: Aca9hQM833Lc6Ni/Tt2we4qFNF31CwABHg4A
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Mark Lord" <lkml@rtr.ca>, "Dave Jones" <davej@redhat.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 11 Aug 2006 21:08:33.0928 (UTC) FILETIME=[4E0D7880:01C6BD8A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Mark Lord [mailto:lkml@rtr.ca] 
>Sent: Friday, August 11, 2006 1:30 PM
>To: Dave Jones
>Cc: Pallipadi, Venkatesh; Linux Kernel; Andrew Morton
>Subject: Re: cpufreq stops working after a while
>
>Pallipadi, Venkatesh wrote:
>>> Dave Jones wrote:
>>>> boot with cpufreq.debug=7, and capture dmesg output after it fails
>>>> to transition.  This might be another manifestation of the 
>mysterious
>>>> "highest frequency isnt accessable" bug, that seems to come from
>>>> some recent change in acpi.
>..
>> You also need to configure in CONFIG_CPU_FREQ_DEBUG
>
>Thanks, Venki!
>
>Okay, here's the tail end of the trace, in which (search for "max")
>one can see the top frequency limit being downgraded.
>
>But, by whom, and why ??
>And what's with these requests for oddball frequencies ("685714"),
>or is that just normal approximation within the governor?
>
>
>[  853.228000] cpufreq-core: updating policy for CPU 0
>[  853.228000] cpufreq-core: Warning: CPU frequency out of 
>sync: cpufreq and timing core thinks of 1100000, is 800000 kHz.
>[  853.228000] cpufreq-core: notification 0 of frequency 
>transition to 800000 kHz
>[  853.228000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
>[  853.228000] cpufreq-core: notification 1 of frequency 
>transition to 800000 kHz
>[  853.228000] cpufreq-core: scaling loops_per_jiffy to 
>3195840 for frequency 800000 kHz
>[  853.228000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
>[  853.228000] cpufreq-core: setting new policy for CPU 0: 
>600000 - 1100000 kHz
>[  853.228000] freq-table: request for verification of policy 
>(600000 - 1100000 kHz) for cpu 0
>[  853.228000] freq-table: verification lead to (600000 - 
>1100000 kHz) for cpu 0
>[  853.228000] freq-table: request for verification of policy 
>(600000 - 800000 kHz) for cpu 0
>[  853.228000] freq-table: verification lead to (600000 - 
>800000 kHz) for cpu 0
>[  853.228000] cpufreq-core: new min and max freqs are 600000 
>- 800000 kHz
>[  853.228000] cpufreq-core: governor: change or update limits
>[  853.228000] cpufreq-core: __cpufreq_governor for CPU 0, event 3

Looks like there are thermal events happening that is causing CPU limits
to reduce. Are you running anything on the CPU when this happens. Is
there a thermal interface in /proc/acpi that can give you the current
temperature of the system?

Thanks,
Venki
