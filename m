Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269323AbUICPE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269323AbUICPE0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269328AbUICPEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:04:25 -0400
Received: from jade.spiritone.com ([216.99.193.136]:53697 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S269075AbUICPD5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:03:57 -0400
Date: Fri, 03 Sep 2004 08:03:49 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm3 (ACPI broken)
Message-ID: <397530000.1094223829@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something is still borked - looks very much like ACPI still, but not the same bug.
Backing out the force-ons out of mm2 fixed it ... so it's something else other
than just the config.

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/config.numaq

larry:~/linux/2.6.9-rc1-mm3# grep ACPI .config
# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BLACKLIST_YEAR=0

arch/i386/kernel/built-in.o(.text+0xdb6c): In function `mp_register_gsi':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c:1098: undefined reference to `io_apic_set_pci_routing'
arch/i386/kernel/built-in.o(.init.text+0x12fe): In function `sys_sigreturn':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/signal.c:229: undefined reference to `acpi_boot_init'
arch/i386/kernel/built-in.o(.init.text+0x16b6): In function `dmi_disable_acpi':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/dmi_scan.c: undefined reference to `acpi_force'
arch/i386/kernel/built-in.o(.init.text+0x16de):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/dmi_scan.c: undefined reference to `acpi_ht'
arch/i386/kernel/built-in.o(.init.text+0x16e8):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/dmi_scan.c: undefined reference to `acpi_pci_disabled'
arch/i386/kernel/built-in.o(.init.text+0x16f2): In function `setup_rt_frame':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/signal.c:320: undefined reference to `acpi_noirq'
arch/i386/kernel/built-in.o(.init.text+0x1712): In function `force_acpi_ht':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/dmi_scan.c:207: undefined reference to `acpi_force'
arch/i386/kernel/built-in.o(.init.text+0x173a): In function `force_acpi_ht':
/root/linux/2.6.9-rc1-mm3/include/asm/acpi.h:128: undefined reference to `acpi_pci_disabled'
arch/i386/kernel/built-in.o(.init.text+0x1744):/root/linux/2.6.9-rc1-mm3/include/asm/acpi.h:129: undefined reference to `acpi_noirq'
arch/i386/kernel/built-in.o(.init.text+0x174e): In function `force_acpi_ht':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/dmi_scan.c:210: undefined reference to `acpi_ht'
arch/i386/kernel/built-in.o(.init.text+0x177e): In function `ignore_timer_override':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/dmi_scan.c:228: undefined reference to `acpi_skip_timer_override'
arch/i386/kernel/built-in.o(.init.text+0x5401): In function `smp_boot_cpus':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/smpboot.c: undefined reference to `acpi_lapic'
arch/i386/kernel/built-in.o(.init.text+0x5fde): In function `smp_read_mpc':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c: undefined reference to `acpi_lapic'
arch/i386/kernel/built-in.o(.init.text+0x6015):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c: undefined reference to `acpi_lapic'
arch/i386/kernel/built-in.o(.init.text+0x6243): In function `get_smp_config':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c: undefined reference to `acpi_lapic'
arch/i386/kernel/built-in.o(.init.text+0x624c):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c: undefined reference to `acpi_ioapic'
arch/i386/kernel/built-in.o(.init.text+0x684b): In function `mp_register_ioapic':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c:918: undefined reference to `io_apic_get_unique_id'
arch/i386/kernel/built-in.o(.init.text+0x6857):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c:919: undefined reference to `io_apic_get_version'
arch/i386/kernel/built-in.o(.init.text+0x6883):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c:927: undefined reference to `io_apic_get_redir_entries'
arch/i386/kernel/built-in.o(.init.text+0x851a): In function `setup_IO_APIC':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/io_apic.c: undefined reference to `acpi_ioapic'
arch/i386/kernel/built-in.o(.init.text+0x8549):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/io_apic.c: undefined reference to `acpi_ioapic'
arch/i386/kernel/built-in.o(.init.text+0x8b46): In function `sys_ipc':
/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/sys_i386.c:154: undefined reference to `acpi_ioapic'
arch/i386/mach-default/built-in.o(.init.text+0xf): In function `intr_init_hook':
/root/linux/2.6.9-rc1-mm3/arch/i386/mach-default/setup.c:47: undefined reference to `acpi_ioapic'
drivers/built-in.o(.init.text+0x1d6a): In function `pci_get_device':
/root/linux/2.6.9-rc1-mm3/drivers/pci/search.c:270: undefined reference to `__acpi_map_table'
drivers/built-in.o(.init.text+0x1de2): In function `pci_find_device_reverse':
/root/linux/2.6.9-rc1-mm3/drivers/pci/search.c:295: undefined reference to `__acpi_map_table'
drivers/built-in.o(.init.text+0x1e59): In function `pci_get_class':
/root/linux/2.6.9-rc1-mm3/drivers/pci/search.c:329: undefined reference to `__acpi_map_table'
drivers/built-in.o(.init.text+0x2007): In function `resource_show':
/root/linux/2.6.9-rc1-mm3/drivers/pci/pci-sysfs.c:54: undefined reference to `__acpi_map_table'
drivers/built-in.o(.init.text+0x202b):/root/linux/2.6.9-rc1-mm3/drivers/pci/pci-sysfs.c:59: undefined reference to `__acpi_map_table'
drivers/built-in.o(.init.text+0x2104):/root/linux/2.6.9-rc1-mm3/include/linux/pci.h:743: more undefined references to `__acpi_map_table' follow
drivers/built-in.o(.init.text+0x2317): In function `acpi_table_init':
/root/linux/2.6.9-rc1-mm3/drivers/acpi/tables.c: undefined reference to `acpi_find_rsdp'
make: *** [.tmp_vmlinux1] Error 1

