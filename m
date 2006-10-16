Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWJPNId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWJPNId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWJPNId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:08:33 -0400
Received: from mga03.intel.com ([143.182.124.21]:20080 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1750787AbWJPNIc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:08:32 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,315,1157353200"; 
   d="scan'208"; a="131575451:sNHT21365855"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
Content-Transfer-Encoding: 8BIT
Subject: RE: Ondemand/Conservative not working with 2.6.18
Date: Mon, 16 Oct 2006 06:08:29 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454BA3D91@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Ondemand/Conservative not working with 2.6.18
Thread-Index: Acbu9jsEQ8lihHfTSLGe5rYL5CJATgCLRZrg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <caglar@pardus.org.tr>
Cc: "Dave Jones" <davej@redhat.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Oct 2006 13:08:31.0624 (UTC) FILETIME=[2DCE2880:01C6F124]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: S.Çaglar Onur [mailto:caglar@pardus.org.tr] 
>Sent: Friday, October 13, 2006 11:34 AM
>To: Pallipadi, Venkatesh
>Cc: Dave Jones; linux-kernel@vger.kernel.org
>Subject: Re: Ondemand/Conservative not working with 2.6.18
>
>11 Eki 2006 Çar 22:00 tarihinde, Pallipadi, Venkatesh þunlarý 
>yazmýþtý: 
>> I guess I misunderstood the original issue. You have 
>available_frequencies
>> showing all the values and after you load ondemand, 
>frequency remains at
>> the highest, even though CPUs are idle. Is this correct?
>>
>> And everything above used to work fine with 2.6.16?
>>
>> Can you configure with CPU_FREQ_DEBUG and do "echo 5 >
>> /sys/module/cpufreq/parameter/debug" before switching the governor to
>> ondemand and see whether you see any messages in dmesg?
>
>I just found a workaround of my problem, if system boots with 
>ac adapter 
>plugged then ondemand or conservative governors are not working, but 
>unplugging the adapter and waiting some seconds, plug it back 
>solves this 
>issue and ondemand/conservative governors are starts to run as 
>expected.
>
>What should i do now? If im not wrong it seems like acpi 
>subsystem problem 
>(and just to be sure, i disassembled my dsdt, iacl claims its 
>error/warning 
>free)
>

Sorry for the delayed response. This is still very mysterious to me..

Do you see anything interesting in dmesg after you try this ac adapter unplug and plug back routine? Can you send me the dmesg. Better still open a bugzilla at bugme.osdl.org and stick the dmesg and acpidump there.

One possible reason for this is, somehow idle statistics is getting all wrong and ondemand thinks CPU is busy, even though it is idle. I have seen this happening earlier when there are issues with local APIC interrupts in deep C-states on dual core systems. But, here it is a single core CPU. Right? Can you also get the output of
#cat /proc/interrupts; sleep 10; cat /proc/interrupts
On your system when ondemand is not working and when it is working (After your unplug-plug workaround.

Thanks,
Venki
