Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTJUC4P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 22:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTJUC4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 22:56:14 -0400
Received: from fmr06.intel.com ([134.134.136.7]:18590 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262738AbTJUC4L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 22:56:11 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCHSET] 0/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Date: Mon, 20 Oct 2003 19:56:07 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60077911@scsmsx403.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCHSET] 0/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Thread-Index: AcOXftwpVZbZ+ThsSW6GvfPmwMoJyw==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>
X-OriginalArrivalTime: 21 Oct 2003 02:56:07.0918 (UTC) FILETIME=[E02C50E0:01C3977E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Most of the latest CPUs (laptop CPUs in particular) have feature 
which enable very low latency P-state transitions 
(like Enhanced Speedstep Technology-EST). Using this feature, 
we can have a lightweight in kernel cpufreq governor, 
to vary CPU frequency depending on the CPU usage. The 
advantage being low power consumption and also cooler laptops.

Another related change is enhancing the current ACPI P-state 
driver to handle:
EST (and MSR based P-state transitions), make the driver SMP 
aware and introduce HT coordination in the driver (HT siblings 
share the same CPU frequency).

The patches that follow this mail addresses the above issues. 
They are against 2.6-test7 kernel. Many thanks to Dominik for 
his comments and suggestions.

The patches will work on all laptops with EST technology 
(Centrino) and also on any other system that supports low 
latency frequency change. 

Reviews/testing of patches are most welcome.

Thanks,
-Venkatesh


Patches are split as follows:

Patch 1/3: Changes to ACPI P-state driver, to handle MSR 
based transitions frequency transitions and make the driver 
SMP aware.

Patch 2/3: Introduce HT-synchronization in the ACPI P-state 
Driver, to take care of shared CPU frequency between HT siblings.

Patch 3/3: New dynamic cpufreq driver (called 
DemandBasedSwitch driver), which periodically monitors CPU 
usage and changes the CPU frequency based on the demand.
