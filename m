Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUIFEcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUIFEcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 00:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267440AbUIFEcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 00:32:47 -0400
Received: from fmr99.intel.com ([192.55.52.32]:58592 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S267438AbUIFEck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 00:32:40 -0400
Subject: Re: 2.6.9-rc1-mm3 (ACPI broken)
From: Len Brown <len.brown@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <397530000.1094223829@[10.10.2.4]>
References: <397530000.1094223829@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1094445149.2506.16.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 06 Sep 2004 00:32:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The bk-acpi.patch in -mm3 is not consistent with the
tree that I've exported for -mm.
http://linux-acpi.bkbits.net:8080/linux-acpi-test-mm
(which builds Martin's config w/o errors)

As you recall, we had some problems deleting CONFIG_ACPI_BOOT
in -mm2, so I excluded that patch pending resolution to some
questions such as the PCI_GOANY issue.
I subsequently added the CONFIG_ACPI_BLACKLIST_YEAR patch.
You can see these two changes clearly in the history for
drivers/acpi/Kconfig

But while the bk-acpi.patch in -mm3 includes 
the CONFIG_ACPI_BLACKLIST_YEAR patch,  it does
mysteriously does not include the earlier exclusion of the
CONFIG_ACPI_BOOT patch.

I expected that using bk cset -x would give you consistent
history and make things easy, but perhaps it has confused
the tools somehow?

thanks,
-Len

On Fri, 2004-09-03 at 11:03, Martin J. Bligh wrote:
> Something is still borked - looks very much like ACPI still, but not
> the same bug.
> Backing out the force-ons out of mm2 fixed it ... so it's something
> else other
> than just the config.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/config.numaq
> 
> larry:~/linux/2.6.9-rc1-mm3# grep ACPI .config
> # Power management options (ACPI, APM)
> # ACPI (Advanced Configuration and Power Interface) Support
> # CONFIG_ACPI is not set
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_BLACKLIST_YEAR=0
> 
> arch/i386/kernel/built-in.o(.text+0xdb6c): In function
> `mp_register_gsi':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c:1098: undefined
> reference to `io_apic_set_pci_routing'
> arch/i386/kernel/built-in.o(.init.text+0x12fe): In function
> `sys_sigreturn':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/signal.c:229: undefined
> reference to `acpi_boot_init'
> arch/i386/kernel/built-in.o(.init.text+0x16b6): In function
> `dmi_disable_acpi':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/dmi_scan.c: undefined
> reference to `acpi_force'
> arch/i386/kernel/built-in.o(.init.text+0x16de):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/dmi_scan.c: undefined reference to `acpi_ht'
> 
> arch/i386/kernel/built-in.o(.init.text+0x16e8):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/dmi_scan.c: undefined reference to `acpi_pci_disabled'
> 
> arch/i386/kernel/built-in.o(.init.text+0x16f2): In function
> `setup_rt_frame':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/signal.c:320: undefined
> reference to `acpi_noirq'
> arch/i386/kernel/built-in.o(.init.text+0x1712): In function
> `force_acpi_ht':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/dmi_scan.c:207: undefined
> reference to `acpi_force'
> arch/i386/kernel/built-in.o(.init.text+0x173a): In function
> `force_acpi_ht':
> /root/linux/2.6.9-rc1-mm3/include/asm/acpi.h:128: undefined reference
> to `acpi_pci_disabled'
> arch/i386/kernel/built-in.o(.init.text+0x1744):/root/linux/2.6.9-rc1-mm3/include/asm/acpi.h:129: undefined reference to `acpi_noirq'
> 
> arch/i386/kernel/built-in.o(.init.text+0x174e): In function
> `force_acpi_ht':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/dmi_scan.c:210: undefined
> reference to `acpi_ht'
> arch/i386/kernel/built-in.o(.init.text+0x177e): In function
> `ignore_timer_override':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/dmi_scan.c:228: undefined
> reference to `acpi_skip_timer_override'
> arch/i386/kernel/built-in.o(.init.text+0x5401): In function
> `smp_boot_cpus':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/smpboot.c: undefined
> reference to `acpi_lapic'
> arch/i386/kernel/built-in.o(.init.text+0x5fde): In function
> `smp_read_mpc':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c: undefined
> reference to `acpi_lapic'
> arch/i386/kernel/built-in.o(.init.text+0x6015):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c: undefined reference to `acpi_lapic'
> 
> arch/i386/kernel/built-in.o(.init.text+0x6243): In function
> `get_smp_config':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c: undefined
> reference to `acpi_lapic'
> arch/i386/kernel/built-in.o(.init.text+0x624c):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c: undefined reference to `acpi_ioapic'
> 
> arch/i386/kernel/built-in.o(.init.text+0x684b): In function
> `mp_register_ioapic':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c:918: undefined
> reference to `io_apic_get_unique_id'
> arch/i386/kernel/built-in.o(.init.text+0x6857):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c:919: undefined reference to `io_apic_get_version'
> 
> arch/i386/kernel/built-in.o(.init.text+0x6883):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/mpparse.c:927: undefined reference to `io_apic_get_redir_entries'
> 
> arch/i386/kernel/built-in.o(.init.text+0x851a): In function
> `setup_IO_APIC':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/io_apic.c: undefined
> reference to `acpi_ioapic'
> arch/i386/kernel/built-in.o(.init.text+0x8549):/root/linux/2.6.9-rc1-mm3/arch/i386/kernel/io_apic.c: undefined reference to `acpi_ioapic'
> 
> arch/i386/kernel/built-in.o(.init.text+0x8b46): In function `sys_ipc':
> /root/linux/2.6.9-rc1-mm3/arch/i386/kernel/sys_i386.c:154: undefined
> reference to `acpi_ioapic'
> arch/i386/mach-default/built-in.o(.init.text+0xf): In function
> `intr_init_hook':
> /root/linux/2.6.9-rc1-mm3/arch/i386/mach-default/setup.c:47: undefined
> reference to `acpi_ioapic'
> drivers/built-in.o(.init.text+0x1d6a): In function `pci_get_device':
> /root/linux/2.6.9-rc1-mm3/drivers/pci/search.c:270: undefined
> reference to `__acpi_map_table'
> drivers/built-in.o(.init.text+0x1de2): In function
> `pci_find_device_reverse':
> /root/linux/2.6.9-rc1-mm3/drivers/pci/search.c:295: undefined
> reference to `__acpi_map_table'
> drivers/built-in.o(.init.text+0x1e59): In function `pci_get_class':
> /root/linux/2.6.9-rc1-mm3/drivers/pci/search.c:329: undefined
> reference to `__acpi_map_table'
> drivers/built-in.o(.init.text+0x2007): In function `resource_show':
> /root/linux/2.6.9-rc1-mm3/drivers/pci/pci-sysfs.c:54: undefined
> reference to `__acpi_map_table'
> drivers/built-in.o(.init.text+0x202b):/root/linux/2.6.9-rc1-mm3/drivers/pci/pci-sysfs.c:59: undefined reference to `__acpi_map_table'
> 
> drivers/built-in.o(.init.text+0x2104):/root/linux/2.6.9-rc1-mm3/include/linux/pci.h:743: more undefined references to `__acpi_map_table' follow
> 
> drivers/built-in.o(.init.text+0x2317): In function `acpi_table_init':
> /root/linux/2.6.9-rc1-mm3/drivers/acpi/tables.c: undefined reference
> to `acpi_find_rsdp'
> make: *** [.tmp_vmlinux1] Error 1
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

