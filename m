Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWH2CGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWH2CGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 22:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWH2CGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 22:06:20 -0400
Received: from mga03.intel.com ([143.182.124.21]:52026 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750997AbWH2CGT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 22:06:19 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,177,1154934000"; 
   d="scan'208"; a="108844263:sNHT24883250"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: one more ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Tue, 29 Aug 2006 10:05:56 +0800
Message-ID: <8BF50482CE9EE245902340E0724784D5F81952@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: one more ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Thread-Index: AcbK8L+FcfTWVo3dQM+XmIXCXgYPrwAHkqCg
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Mattia Dongili" <malattia@linux.it>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 29 Aug 2006 02:06:06.0352 (UTC) FILETIME=[AFF2F100:01C6CB0F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Mattia Dongili
>Sent: Tuesday, August 29, 2006 4:24 AM
>To: Andrew Morton
>Cc: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org
>Subject: one more ACPI Error (utglobal-0125): Unknown exception code:
>0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
>
>On Sat, Aug 26, 2006 at 04:09:22PM -0700, Andrew Morton wrote:
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-
>rc4/2.6.18-rc4-mm3/
>[...]
>>  git-acpi.patch
>
>Sorry for reporting separately, I deleted the other thread on the
issue.
>Here we go:
>[    9.386644] PCI: Using ACPI for IRQ routing
>[    9.386688] PCI: If a device doesn't work, try "pci=routeirq".  If
it
>helps, post a report
>[    9.391209] ACPI Error (utglobal-0125): Unknown exception code:
>0xFFFFFFEA [20060707]
>[    9.391521]  [<c0103a9f>] dump_trace+0x1ef/0x230
>[    9.391626]  [<c0103b06>] show_trace_log_lvl+0x26/0x40
>[    9.391724]  [<c01042bb>] show_trace+0x1b/0x20
>[    9.391820]  [<c01043a4>] dump_stack+0x24/0x30
>[    9.391918]  [<c0249f15>] acpi_format_exception+0xa3/0xb0
>[    9.392729]  [<c0246fb6>] acpi_ut_status_exit+0x31/0x5e
>[    9.393453]  [<c0243352>] acpi_walk_resources+0x10e/0x11b
>[    9.394174]  [<c025697e>] acpi_motherboard_add+0x22/0x31
>[    9.394977]  [<c0255890>] acpi_bus_driver_init+0x2b/0x7c
>[    9.395742]  [<c02568da>] acpi_bus_register_driver+0xa1/0x123
>[    9.396507]  [<c0418adb>] acpi_motherboard_init+0x17/0xfb
>[    9.397268]  [<c01003d0>] init+0x80/0x290
>[    9.397343]  [<c0103593>] kernel_thread_helper+0x7/0x14
>[    9.397439]  =======================
>
>full dmesg: http://oioio.altervista.org/linux/dmesg-2.6.18-rc4-mm3-1
>config: http://oioio.altervista.org/linux/config-2.6.18-rc4-mm3-1
>DSDT: http://oioio.altervista.org/linux/DSDT.aml
>      http://oioio.altervista.org/linux/DSDT.dsl
>lspci: http://oioio.altervista.org/linux/lspci-v
Below patch is the root cause.
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc
4/2.6.18-rc4-mm3/broken-out/hot-add-mem-x86_64-acpi-motherboard-fix.patc
h

motherboard driver is expected to reserve resources used by motherboard,
so hotplug will not fail. I don't know why memory hotplug guys change
it.

Thanks,
Shaohua
