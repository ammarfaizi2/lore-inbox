Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945983AbWBDPOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945983AbWBDPOs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 10:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945989AbWBDPOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 10:14:48 -0500
Received: from fmr21.intel.com ([143.183.121.13]:59064 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1945983AbWBDPOr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 10:14:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: acpi_cpufreq broken after _PDC patch
Date: Sat, 4 Feb 2006 07:14:40 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6007248198@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: acpi_cpufreq broken after _PDC patch
Thread-Index: AcYpnFLI+htk4q6+QO+pH1P1J2wwzwAAQaJg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Gerhard Schrenk" <deb.gschrenk@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Feb 2006 15:14:42.0932 (UTC) FILETIME=[B9BB9340:01C6299D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please use Enhanced speedstep config option as well under Ppower
Management->cpufreq (with ACPI option under it enabled too). That will
configure speedstep-centrino driver, which should work here.
Speedstep-centrino driver is a better option than acpi-cpufreq, as it
will do much faster P-state transition.

Thanks,
Venki 

>-----Original Message-----
>From: Gerhard Schrenk [mailto:deb.gschrenk@gmx.de] 
>Sent: Saturday, February 04, 2006 7:03 AM
>To: Pallipadi, Venkatesh
>Cc: linux-kernel@vger.kernel.org
>Subject: acpi_cpufreq broken after _PDC patch
>
>Hi,
>
>commit 05131ecc99ea9da7f45ba3058fe8a2c1d0ceeab8 breaks acpi_cpufreq for
>an Intel Centrino notebook with Pentium M 1.60GHz (it's a Medion MD
>95600 (aka MSI S260) notebook).
>
>|gps@medusa:~/scratch/kernel-tree$ git bisect bad
>|05131ecc99ea9da7f45ba3058fe8a2c1d0ceeab8 is first bad commit
>|diff-tree 05131ecc99ea9da7f45ba3058fe8a2c1d0ceeab8 (from 
>d2149b542382bfc206cb28485108f6470c979566)
>|Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>|Date:   Sun Oct 23 16:31:00 2005 -0400
>|
>|    [ACPI] Avoid BIOS inflicted crashes by evaluating _PDC only once
>|    
>|    Linux invokes the AML _PDC method (Processor Driver Capabilities)
>|    to tell the BIOS what features it can handle.  While the ACPI
>|    spec says nothing about the OS invoking _PDC multiple times,
>|    doing so with changing bits seems to hopelessly confuse the BIOS
>|    on multiple platforms up to and including crashing the system.
>|    
>|    Factor out the _PDC invocation so Linux invokes it only once.
>|    
>|    http://bugzilla.kernel.org/show_bug.cgi?id=5483
>|    
>|    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>|    Signed-off-by: Len Brown <len.brown@intel.com>
>
>The error message is
>
>|gps@medusa:~$ sudo modprobe acpi_cpufreq
>|FATAL: Error inserting acpi_cpufreq
>|(/lib/modules/2.6.15-rc3-bisect1/kernel/arch/i386/kernel/cpu/c
pufreq/acpi-cpufreq.ko):
>|No such device
>
>Unfortunately 
>
>  git revert 05131ecc99ea9da7f45ba3058fe8a2c1d0ceeab8 
>
>does not work without merge conflict on top of Linus' tree.
>
>-- Gerhard
>
