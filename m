Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWC1Xs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWC1Xs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWC1Xs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:48:56 -0500
Received: from mga03.intel.com ([143.182.124.21]:15435 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964844AbWC1Xsz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:48:55 -0500
X-IronPort-AV: i="4.03,140,1141632000"; 
   d="scan'208"; a="16014551:sNHT26659022124"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Some section mismatch in acpi_processor_power_init on ia64 build
Date: Tue, 28 Mar 2006 15:09:36 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0613EDAB@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Some section mismatch in acpi_processor_power_init on ia64 build
Thread-Index: AcZSBOVwOm4afy3CTUOD0HUH4Ow0TAAtzYeg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Mar 2006 23:09:37.0190 (UTC) FILETIME=[AF1D4C60:01C652BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've only just noticed these warnings when building ia64 !SMP or
!HOTPLUG_CPU
kernels:

WARNING: drivers/acpi/processor.o - Section mismatch: reference to
.init.data: from .text between 'acpi_processor_power_init' (at offset
0x5040) and 'acpi_processor_power_exit'
WARNING: drivers/acpi/processor.o - Section mismatch: reference to
.init.data: from .text between 'acpi_processor_power_init' (at offset
0x5050) and 'acpi_processor_power_exit'

According to git bisect, they began with Matt Domsch's "ia64: use i386
dmi_scan.c"
patch (commit 3ed3bce8), but it appears that the real issue may be
further back when
Ashok Raj marked processor_power_dmi_table as __cpuinitdata in 7ded5689
with a
cryptic comment by AK (Andi Kleen?):
  /* Actually this shouldn't be __cpuinitdata, would be better to fix
the
     callers to only run once -AK */

-Tony
