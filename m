Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264824AbUEYJWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264824AbUEYJWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 05:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264825AbUEYJWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 05:22:32 -0400
Received: from [213.196.40.106] ([213.196.40.106]:59275 "EHLO
	eljakim.netsystem.nl") by vger.kernel.org with ESMTP
	id S264824AbUEYJW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 05:22:28 -0400
Date: Tue, 25 May 2004 11:22:25 +0200 (CEST)
From: Joris van Rantwijk <joris@eljakim.nl>
X-X-Sender: joris@eljakim.netsystem.nl
To: linux-kernel@vger.kernel.org
cc: Dominik Brodowski <linux@brodo.de>
Subject: Re: System clock speed too high - 2.6.3 kernel
In-Reply-To: <1E4zj-77w-69@gated-at.bofh.it>
Message-ID: <Pine.LNX.4.58.0405251112040.30050@eljakim.netsystem.nl>
References: <1E4zj-77w-69@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 26 Mar 2004, Praedor Atrebates wrote:
> I have Mandrake 10.0, kernel-2.6.3-7mdk installed, on an IBM Thinkpad 1412
> laptop, celeron 366, 512MB RAM.  I am finding that my system clock is ticking
> away at a rate of about 3:1 vs reality, ie, I count ~3 seconds on the system
> clock for every 1 real second.  I am running ntpd but this is unable to keep
> up with the rate of system clock passage.

I have the same problem with kernel 2.6.6, only in my case the speed is
exactly doubled (not 3:1). Saying "clock=tsc" at boot time solves this
perfectly.

My mainboard is Asus P5A (4 years old) with ALi M1541 chipset.
Linux detects a PM-Timer at port 0xec08. I measured the counting rate
of this port (while safely running with clock=tsc) and it comes out at
about 7159155 ticks per second. The rate expected by
arch/i386/kernel/timer/timer_pm.c is 3579545 ticks per second, so this
explains the double speed very nicely.

Perhaps this should be documented in the kernel config info.
If there are many systems with this problem, then calibrating the PM timer
against the PIT timer at boot time (possibly rejecting invalid rates)
might be an option.

Bye,
  Joris.

Some information from dmesg:
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f81d0
ACPI: RSDT (v001 ASUS   P5A      0x58582e32 MSFT 0x31313031) @ 0x07ffc000
ACPI: FADT (v001 ASUS   P5A      0x58582e32 MSFT 0x31313031) @ 0x07ffc080
ACPI: BOOT (v001 ASUS   P5A      0x58582e32 MSFT 0x31313031) @ 0x07ffc040
ACPI: DSDT (v001   ASUS P5A      0x00001000 MSFT 0x01000001) @ 0x00000000
ACPI: PM-Timer IO Port: 0xec08

Some information from lspci:
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
01:00.0 VGA compatible controller: nVidia Corporation Riva TnT [NV04] (rev 04)
