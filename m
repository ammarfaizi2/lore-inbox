Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVF1IyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVF1IyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVF1GJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:09:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:25068 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261836AbVF1Fdj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:39 -0400
Cc: kaneshige.kenji@jp.fujitsu.com
Subject: [PATCH] ACPI based I/O APIC hot-plug: add interfaces
In-Reply-To: <1119936774204@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:54 -0700
Message-Id: <1119936774301@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ACPI based I/O APIC hot-plug: add interfaces

This patch adds the following new interfaces for I/O xAPIC
hotplug. The implementation of these interfaces depends on each
architecture.

    o int acpi_register_ioapic(acpi_handle handle, u64 phys_addr,
			       u32 gsi_base);

        This new interface is to add a new I/O xAPIC specified by
        phys_addr and gsi_base pair. phys_addr is the physical address
        to which the I/O xAPIC is mapped and gsi_base is global system
        interrupt base of the I/O xAPIC. acpi_register_ioapic returns
        0 on success, or negative value on error.

    o int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base);

        This new interface is to remove a I/O xAPIC specified by
        gsi_base. acpi_unregister_ioapic returns 0 on success, or
        negative value on error.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b1bb248a5d2230a3d8ef42199c742194a8580b15
tree 5335d22256e1c6f755f7aff01432ed2d5d722c9b
parent 8d50e332c8bd4f4e8cc76e8ed7326aa6f18182aa
author Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> Thu, 28 Apr 2005 00:25:58 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:44 -0700

 arch/i386/kernel/acpi/boot.c |   16 ++++++++++++++++
 arch/ia64/kernel/acpi.c      |   17 +++++++++++++++++
 include/linux/acpi.h         |    3 +++
 3 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -507,6 +507,22 @@ acpi_unmap_lsapic(int cpu)
 EXPORT_SYMBOL(acpi_unmap_lsapic);
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
+int
+acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
+{
+	/* TBD */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(acpi_register_ioapic);
+
+int
+acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)
+{
+	/* TBD */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(acpi_unregister_ioapic);
+
 static unsigned long __init
 acpi_scan_rsdp (
 	unsigned long		start,
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -825,4 +825,21 @@ acpi_map_iosapic (acpi_handle handle, u3
 	return AE_OK;
 }
 #endif /* CONFIG_NUMA */
+
+int
+acpi_register_ioapic (acpi_handle handle, u64 phys_addr, u32 gsi_base)
+{
+	/* TBD */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(acpi_register_ioapic);
+
+int
+acpi_unregister_ioapic (acpi_handle handle, u32 gsi_base)
+{
+	/* TBD */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(acpi_unregister_ioapic);
+
 #endif /* CONFIG_ACPI_BOOT */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -407,6 +407,9 @@ int acpi_map_lsapic(acpi_handle handle, 
 int acpi_unmap_lsapic(int cpu);
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
+int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base);
+int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base);
+
 extern int acpi_mp_config;
 
 extern u32 pci_mmcfg_base_addr;

