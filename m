Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWINNPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWINNPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 09:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWINNPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 09:15:51 -0400
Received: from diedas.soften.ktu.lt ([193.219.33.197]:61108 "EHLO
	diedas.soften.ktu.lt") by vger.kernel.org with ESMTP
	id S932075AbWINNPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 09:15:50 -0400
Date: Thu, 14 Sep 2006 16:19:12 +0300 (EEST)
From: Almonas Petrasevicius <draugaz@diedas.soften.ktu.lt>
To: linux-kernel@vger.kernel.org
Cc: kernel@bb.cactii.net, venkatesh.pallipadi@intel.com,
       davej@codemonkey.org.uk
Subject: Re: speedstep-centrino broke
Message-ID: <Pine.LNX.4.62.0609141558090.22822@diedas.soften.ktu.lt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I experience the same speedstep problem on my HP nc6320 (CoreDuo T2400) 
since yesterday's BIOS update (F06 to F08).

According to the release notes this BIOS update should introduce support 
for the new CPU's (Core2 "Merom" I suppose).

I did verify both kernels 2.6.16 and 2.6.17 (both vanilla), there is 
_no_ difference, both have the same speedstep problem.

I did look through the 2.6.17 logs, before and after the bios update and
diff showed the following differences:

The BIOS v F06 (speedstep was OK):

kernel: ACPI: RSDP (v000 HP                                    ) @ 
0x000f7d70
kernel: ACPI: RSDT (v001 HP     30AA     0x28040620 HP   0x00000001) @ 
0x3f7e5684
kernel: ACPI: FADT (v002 HP     30AA     0x00000002 HP   0x00000001) @ 
0x3f7e5600
kernel: ACPI: MADT (v001 HP     30AA     0x00000001 HP   0x00000001) @ 
0x3f7e56c0
kernel: ACPI: MCFG (v001 HP     30AA     0x00000001 HP   0x00000001) @ 
0x3f7e5728
kernel: ACPI: TCPA (v002 HP     30AA     0x00000001 HP   0x00000001) @ 
0x3f7e5764
kernel: ACPI: SSDT (v001 HP       HPQSAT 0x00000001 MSFT 0x0100000e) @ 
0x3f7f4af8
kernel: ACPI: SSDT (v001 HP        CpuPm 0x00003000 INTL 0x20050624) @ 
0x3f7f52e5
kernel: ACPI: DSDT (v001 HP       nc6340 0x00010000 MSFT 0x0100000e) @ 
0x00000000

The BIOS v F08 (no speedstep anymore):

kernel: ACPI: RSDP (v002 HP                                    ) @ 
0x000f7f00
kernel: ACPI: XSDT (v001 HP     30AA     0x27070620 HP   0x00000001) @ 
0x3f7e57b4
kernel: ACPI: FADT (v004 HP     30AA     0x00000003 HP   0x00000001) @ 
0x3f7e5684
kernel: ACPI: MADT (v001 HP     30AA     0x00000001 HP   0x00000001) @ 
0x3f7e5808
kernel: ACPI: MCFG (v001 HP     30AA     0x00000001 HP   0x00000001) @ 
0x3f7e5870
kernel: ACPI: TCPA (v002 HP     30AA     0x00000001 HP   0x00000001) @ 
0x3f7e58ac
kernel: ACPI: SSDT (v001 HP       HPQSAT 0x00000001 MSFT 0x0100000e) @ 
0x3f7f4e9c
kernel: ACPI: DSDT (v001 HP       nc6340 0x00010000 MSFT 0x0100000e) @ 
0x00000000


So, i suppose it has something to do with a CpuPm SSDT section which is 
now missing (or maybe present in a different form?).

As a consequence, with BIOS v. F06 i get the following messages:

kernel: ACPI: CPU0 (power states: C1[C1] C2[C2])
kernel: ACPI: Processor [CPU0] (supports 8 throttling states)
kernel: ACPI: CPU1 (power states: C1[C1] C2[C2])
kernel: ACPI: Processor [CPU1] (supports 8 throttling states)

and with BIOS v. F08 just this:

kernel: ACPI: Processor [CPU0] (supports 8 throttling states)
kernel: ACPI: Processor [CPU1] (supports 8 throttling states)

If any further info would help, I have the full ACPI dump from the BIOS 
F04 (which was OK and had that CpuPm SSDT table too) and could create the 
dump for the BIOS v F08 (which broke the speedstep).

But as it looks, I suspect it is an HP issue and probably has nothing to 
do with linux kernel.

Regards,
Almonas
