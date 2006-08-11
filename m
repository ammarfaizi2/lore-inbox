Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWHKWTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWHKWTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWHKWTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:19:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:62991 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964802AbWHKWTD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:19:03 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,115,1154934000"; 
   d="scan'208"; a="107173447:sNHT18020506"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: cpufreq stops working after a while
Date: Fri, 11 Aug 2006 15:18:58 -0700
Message-ID: <EB12A50964762B4D8111D55B764A84546F8FE2@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpufreq stops working after a while
thread-index: Aca9kKiDinoyEVa6TFWKiVtj9EwfzgAAwU6g
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Mark Lord" <lkml@rtr.ca>
Cc: "Dave Jones" <davej@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 11 Aug 2006 22:18:59.0961 (UTC) FILETIME=[24F6EE90:01C6BD94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Mark Lord [mailto:lkml@rtr.ca] 
>Sent: Friday, August 11, 2006 2:54 PM
>To: Pallipadi, Venkatesh
>Cc: Dave Jones; Linux Kernel; Andrew Morton
>Subject: Re: cpufreq stops working after a while
>
>Pallipadi, Venkatesh wrote:
>>> Mark Lord wrote:
>>> Yup, thermal.
>>> Trips shortly after I see 66C in 
>>> /proc/acpi/thermal_zone/THM/temperature
>>>
>>> If I stop number crunching for a bit, the temperature drops 
>down to the
>>> low 50's, and the max freq then gets set back to 1100.
>>>
>>> Mmmm.. is there a way to control the high/low thermostat 
>values there?
>..
>> What is the "cooling mode" you have in
>> /proc/acpi/thermal_zone/THM/cooling_mode.
>> Output of all files in that directory will help.
>
>/proc/acpi/thermal_zone/THM/cooling_mode:
>	<setting not supported>
>	cooling mode:   critical
>
>/proc/acpi/thermal_zone/THM/polling_frequency:
>	<polling disabled>
>
>/proc/acpi/thermal_zone/THM/state:
>	state:                   ok
>
>/proc/acpi/thermal_zone/THM/temperature:
>	temperature:             49 C
>
>/proc/acpi/thermal_zone/THM/trip_points:
>	critical (S5):           95 C
>
>==========
>
>This is a passively cooled notebook, so there's no fan
>to control.  They probably self-limit the CPU speed when
>the temperature gets high to prevent meltdown of the drive.
>
>But I would like to raise the lower limit if possible,
>allowing the speed to bump back up at, say 58C rather
>than waiting for 52C as it currently does.
>
>??

Passive cooling starting temperature is given by platform manufacturer
through BIOS. You can check whether your BIOS has any option to change
it. Changing it manually by custom DSDT etc may be risky :).
One thing you can try from software is the polling_frequency above. For
some reason it is set to zero above. Try setting it to 1 sec and see
whether that makes any difference (echo 1 >
/proc/acpi/thermal_zone/THM/polling_frequency).

Venki
