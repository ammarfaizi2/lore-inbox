Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWBDSEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWBDSEj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 13:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWBDSEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 13:04:39 -0500
Received: from fmr22.intel.com ([143.183.121.14]:60814 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932533AbWBDSEi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 13:04:38 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: acpi_cpufreq broken after _PDC patch
Date: Sat, 4 Feb 2006 10:03:49 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60072481C8@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: acpi_cpufreq broken after _PDC patch
Thread-Index: AcYpsq7h7FggAbNhR3iLKj6F9kK/SQAASZQg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Gerhard Schrenk" <gerhard.schrenk@uni-konstanz.de>
Cc: "Gerhard Schrenk" <deb.gschrenk@gmx.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Feb 2006 18:03:50.0619 (UTC) FILETIME=[5A39BAB0:01C629B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: Gerhard Schrenk [mailto:gerhard.schrenk@uni-konstanz.de] 
>Sent: Saturday, February 04, 2006 9:43 AM
>To: Pallipadi, Venkatesh
>Cc: Gerhard Schrenk; linux-kernel@vger.kernel.org
>Subject: Re: acpi_cpufreq broken after _PDC patch
>
>* Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> 
>[2006-02-04 16:32]:
>> 
>> Please use Enhanced speedstep config option as well under Ppower
>> Management->cpufreq (with ACPI option under it enabled too). 
>That will
>> configure speedstep-centrino driver, which should work here.
>> Speedstep-centrino driver is a better option than acpi-cpufreq, as it
>> will do much faster P-state transition.
>
>Thank you for your instantaneous reply! Do you mean?
>
>CONFIG_X86_SPEEDSTEP_CENTRINO=y
>CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
>
>I *always* had those drivers statically compiled in my kernel 
>along with
>
>CONFIG_X86_ACPI_CPUFREQ=m
>
>These settings always "worked" in the sense that I saw frequencies down
>to 800Mhz in /proc/cpuinfo and I could set different governors in
>/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor.
>
>Probably the speedstep-centrino driver actually never worked for me and
>only the acpi_cpufreq driver did it's job until your patch!?  
>
>To give you a chance to reproduce this or to avoid missunderstandings I
>attach you my .config. I didn't touch my cpufreq settings since
>2.6.14.x.
>
>The acpi-tables of my MSI S260 (branded as Medion sim 2100) seem to be
>problematic. Here are my boot options
>


You need to configure X86_SPEEDSTEP_CENTRINO_ACPI as well. That is
required to make speedstep-centrino work with ACPI.

I understand that my change caused the change of behaviour here. But,
the code originally was wrong and causing crashes on few other systems.
Besides, as I mentioned earlier, using speedstep-centrino driver rather
than acpi-cpufreq is a better option. 

If it doesn't work with this new config either, we will need to root
cause the failure of these two drivers with CPU_FREQ_DEBUG and also
possible acpidump.

Thanks,
Venki
