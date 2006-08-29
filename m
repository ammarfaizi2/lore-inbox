Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWH2UEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWH2UEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWH2UEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:04:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:13681 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751420AbWH2UE3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:04:29 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,183,1154934000"; 
   d="scan'208"; a="117165682:sNHT19236042"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: one more ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Tue, 29 Aug 2006 13:04:09 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: one more ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Thread-Index: AcbK8L+FcfTWVo3dQM+XmIXCXgYPrwAHkqCgACXI3HA=
From: "Moore, Robert" <robert.moore@intel.com>
To: "Li, Shaohua" <shaohua.li@intel.com>, "Mattia Dongili" <malattia@linux.it>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 29 Aug 2006 20:04:10.0518 (UTC) FILETIME=[4AB76360:01C6CBA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as the unknown exception,

>[    9.392729]  [<c0246fb6>] acpi_ut_status_exit+0x31/0x5e
>[    9.393453]  [<c0243352>] acpi_walk_resources+0x10e/0x11b
>[    9.394174]  [<c025697e>] acpi_motherboard_add+0x22/0x31

I would guess that the callback routine for walk_resources is returning
a non-zero status value which is causing an immediate abort of the walk
with that value -- and the value is bogus.

Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Li, Shaohua
> Sent: Monday, August 28, 2006 7:06 PM
> To: Mattia Dongili; Andrew Morton
> Cc: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org
> Subject: RE: one more ACPI Error (utglobal-0125): Unknown exception
code:
> 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
> 
> 
> 
> >-----Original Message-----
> >From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> >owner@vger.kernel.org] On Behalf Of Mattia Dongili
> >Sent: Tuesday, August 29, 2006 4:24 AM
> >To: Andrew Morton
> >Cc: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org
> >Subject: one more ACPI Error (utglobal-0125): Unknown exception code:
> >0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
> >
> >On Sat, Aug 26, 2006 at 04:09:22PM -0700, Andrew Morton wrote:
> >>
> >>
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-
> >rc4/2.6.18-rc4-mm3/
> >[...]
> >>  git-acpi.patch
> >
> >Sorry for reporting separately, I deleted the other thread on the
> issue.
> >Here we go:
> >[    9.386644] PCI: Using ACPI for IRQ routing
> >[    9.386688] PCI: If a device doesn't work, try "pci=routeirq".  If
> it
> >helps, post a report
> >[    9.391209] ACPI Error (utglobal-0125): Unknown exception code:
> >0xFFFFFFEA [20060707]
> >[    9.391521]  [<c0103a9f>] dump_trace+0x1ef/0x230
> >[    9.391626]  [<c0103b06>] show_trace_log_lvl+0x26/0x40
> >[    9.391724]  [<c01042bb>] show_trace+0x1b/0x20
> >[    9.391820]  [<c01043a4>] dump_stack+0x24/0x30
> >[    9.391918]  [<c0249f15>] acpi_format_exception+0xa3/0xb0
> >[    9.392729]  [<c0246fb6>] acpi_ut_status_exit+0x31/0x5e
> >[    9.393453]  [<c0243352>] acpi_walk_resources+0x10e/0x11b
> >[    9.394174]  [<c025697e>] acpi_motherboard_add+0x22/0x31
> >[    9.394977]  [<c0255890>] acpi_bus_driver_init+0x2b/0x7c
> >[    9.395742]  [<c02568da>] acpi_bus_register_driver+0xa1/0x123
> >[    9.396507]  [<c0418adb>] acpi_motherboard_init+0x17/0xfb
> >[    9.397268]  [<c01003d0>] init+0x80/0x290
> >[    9.397343]  [<c0103593>] kernel_thread_helper+0x7/0x14
> >[    9.397439]  =======================
> >
> >full dmesg: http://oioio.altervista.org/linux/dmesg-2.6.18-rc4-mm3-1
> >config: http://oioio.altervista.org/linux/config-2.6.18-rc4-mm3-1
> >DSDT: http://oioio.altervista.org/linux/DSDT.aml
> >      http://oioio.altervista.org/linux/DSDT.dsl
> >lspci: http://oioio.altervista.org/linux/lspci-v
> Below patch is the root cause.
>
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc
>
4/2.6.18-rc4-mm3/broken-out/hot-add-mem-x86_64-acpi-motherboard-fix.patc
> h
> 
> motherboard driver is expected to reserve resources used by
motherboard,
> so hotplug will not fail. I don't know why memory hotplug guys change
> it.
> 
> Thanks,
> Shaohua
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
