Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271695AbTHMIcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 04:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271699AbTHMIcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 04:32:50 -0400
Received: from mail.hometree.net ([212.34.181.120]:6797 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S271695AbTHMIcs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 04:32:48 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Intel ICH5 APIC, ACPI problems in 2.4
Date: Wed, 13 Aug 2003 08:32:46 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bhct3e$s29$1@tangens.hometree.net>
References: <3F37D13D.7080309@pobox.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1060763566 28745 212.34.181.4 (13 Aug 2003 08:32:46 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 13 Aug 2003 08:32:46 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

>I have a couple uniprocessor ICH5 systems from different vendors, with 
>similar behavior:

>2.6:  HyperThreading works, ACPI works, all irqs properly routed

>2.4:  HT works only works with ACPI enabled, but,
>       ACPI kills the irq routing for the external PCI slots.
>       pci=noacpi or whatever doesn't work.  !CONFIG_ACPI + "noapic"
>       fixes irq routing, but then no HT sibling appears.

To give a datapoint:

ICH5 works like a breeze with RH 2.4.20-19.9 kernel:

% lspci -vt

-[00]-+-00.0  Intel Corp. 82865G [Springdale-G] Chipset Host Bridge
[...]
      +-1f.1  Intel Corp. 82801EB ICH5 IDE
[...]

%  cat /proc/cpuinfo | grep -i genuine | wc -l
      2

% dmesg
Linux version 2.4.20-19.9smp (bhcompile@stripples.devel.redhat.com) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 SMP Tue Jul 15 17:04:18 EDT 2003
[...]
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00f5b40
RSD PTR  v0 [ACPIAM]
ACPI table found: RSDT v1 [INTEL  D865PERL 8195.1813]
ACPI table found: FACP v2 [INTEL  D865PERL 8195.1813]
ACPI table found: APIC v1 [INTEL  D865PERL 8195.1813]
LAPIC (acpi_id[0x0001] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16
LAPIC_NMI (acpi_id[0x0001] polarity[0x0] trigger[0x0] lint[0x1])
LAPIC (acpi_id[0x0002] id[0x1] enabled[1])
CPU 1 (0x0100) enabledProcessor #1 Pentium 4(tm) XEON(tm) APIC version 16
[...]

This is an intel 865 PERLK desktop board with a 2,6 GHz HT CPU. Even
the ICH5 serial ATA works which really had me impressed:

ICH5-SATA: IDE controller at PCI slot 00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: 100% native mode on irq 18
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 6Y120M0, ATA DISK drive
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=238216/16/63, UDMA(33)

(The UDMA(33) seems to be a lie, I can read ~ 57 MBytes/sec from this disk).

So there might be some patches in the RH kernel, that are missing from
2.4.22-rc2

	Regards
		Henning



-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

"Dominate!! Dominate!! Eat your young and aggregate! I have grotty silicon!" 
      -- AOL CD when played backwards  (User Friendly - 200-10-15)
