Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWE3T7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWE3T7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWE3T7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:59:51 -0400
Received: from gw.goop.org ([64.81.55.164]:59294 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932426AbWE3T7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:59:51 -0400
Message-ID: <447C9F19.5000105@goop.org>
Date: Tue, 30 May 2006 12:38:01 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjan@linux.intel.com
Subject: ThinkPad X60: PCI: BIOS Bug: MCFG area is not E820-reserved (MCFG
 is in ACPI NVS)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the message:

   PCI: BIOS Bug: MCFG area is not E820-reserved
   PCI: Not using MMCONFIG.


when I boot 2.6.17-rc5 on my Lenovo Thinkpad X60.  I don't know if this 
is a problem; the machine seems to work fine.

The E820 table reported at boot says:

BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000007f6d0000 (usable)
BIOS-e820: 000000007f6d0000 - 000000007f6e3000 (ACPI data)
BIOS-e820: 000000007f6e3000 - 000000007f700000 (ACPI NVS)
BIOS-e820: 000000007f700000 - 0000000080000000 (reserved)
BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)

and the ACPI tables are:

Using APIC driver default
ACPI: RSDP (v002 LENOVO                                ) @ 0x000f6880
ACPI: XSDT (v001 LENOVO TP-7B    0x00001060  LTP 0x00000000) @ 0x7f6d6621
ACPI: FADT (v003 LENOVO TP-7B    0x00001060 LNVO 0x00000001) @ 0x7f6d6700
ACPI: SSDT (v001 LENOVO TP-7B    0x00001060 MSFT 0x0100000e) @ 0x7f6d68b4
ACPI: ECDT (v001 LENOVO TP-7B    0x00001060 LNVO 0x00000001) @ 0x7f6e2d4a
ACPI: TCPA (v002 LENOVO TP-7B    0x00001060 LNVO 0x00000001) @ 0x7f6e2d9c
ACPI: MADT (v001 LENOVO TP-7B    0x00001060 LNVO 0x00000001) @ 0x7f6e2dce
ACPI: MCFG (v001 LENOVO TP-7B    0x00001060 LNVO 0x00000001) @ 0x7f6e2e36
ACPI: HPET (v001 LENOVO TP-7B    0x00001060 LNVO 0x00000001) @ 0x7f6e2e74
ACPI: BOOT (v001 LENOVO TP-7B    0x00001060  LTP 0x00000001) @ 0x7f6e2fd8
ACPI: SSDT (v001 LENOVO TP-7B    0x00001060 INTL 0x20050513) @ 0x7f6d5bdc
ACPI: SSDT (v001 LENOVO TP-7B    0x00001060 INTL 0x20050513) @ 0x7f6d5a04
ACPI: DSDT (v001 LENOVO TP-7B    0x00001060 MSFT 0x0100000e) @ 0x00000000

So the MCFG entry is in the ACPI NVS region of the E820 table.  Is this 
bad? The code in arch/i386/pci/mmconfig.c only checks for MCFG being in 
an E820_RESERVED area.  Should it also check for E820_NVS?

This FC5 stock kernels (such as kernel-smp-2.6.16-1.2122_FC5) don't 
appear to have this check (no message printed), and they work fine on 
this machine.

Thanks,
   J


