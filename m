Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbVG3ADp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVG3ADp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbVG3ADe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:03:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11650 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262821AbVG3ABZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:01:25 -0400
Date: Fri, 29 Jul 2005 17:03:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.13-rc4: no hyperthreading and idr_remove() stack traces
Message-Id: <20050729170319.23f24a01.akpm@osdl.org>
In-Reply-To: <20050729162006.GA18866@janus>
References: <20050729162006.GA18866@janus>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen <frankvm@frankvm.com> wrote:
>
> 2.6.13-rc4 does not recognize the second CPU of a 3GHz HT P4:

OK, we seem to have broken your APIC code.

@@ -21,36 +21,26 @@
 896MB LOWMEM available.
 found SMP MP-table at 000fe710
 DMI 2.3 present.
-ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
+Intel MultiProcessor Specification v1.4
+    Virtual Wire compatibility mode.
+OEM ID: DELL     Product ID: Opti GX280   APIC at: 0xFEE00000
 Processor #0 15:4 APIC version 20
-ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
-Processor #1 15:4 APIC version 20
-ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
-ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
-ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
-ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
-IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
-ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
-ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
+I/O APIC #8 Version 32 at 0xFEC00000.
 Enabling APIC mode:  Flat.  Using 1 I/O APICs
-ACPI: HPET id: 0x8086a201 base: 0xfed00000
-Using ACPI (MADT) for SMP configuration information
+Processors: 1
 Allocating PCI resources starting at 40000000 (gap: 40000000:a0000000)
 Built 1 zonelists
-Kernel command line: auto BOOT_IMAGE=2.6.12.2-y115 ro root=802 nomodules
+Kernel command line: auto BOOT_IMAGE=2.6.13-rc4-y117 ro root=802 nomodules
 Initializing CPU#0
 PID hash table entries: 4096 (order: 12, 65536 bytes)
+Detected 2993.277 MHz processor.

Are you able to identify a later kernel than 2.6.12 which worked OK?

(The IDR problem is fixed in Linus's current tree)
