Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWGGDBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWGGDBk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 23:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWGGDBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 23:01:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:44181 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751149AbWGGDBj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 23:01:39 -0400
Subject: [BUG] sleeping function called from invalid context during resume
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: len.brown@intel.com, pavel@suse.cz
Content-Type: text/plain
Date: Thu, 06 Jul 2006 20:01:36 -0700
Message-Id: <1152241296.6163.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following on my laptop w/ 2.6.18-rc1.

thanks
-john

Stopping tasks:
================================================================
=======================|
pnp: Device 00:0b disabled.
ACPI: PCI interrupt for device 0000:02:01.0 disabled
ACPI: PCI interrupt for device 0000:00:1f.5 disabled
ACPI: PCI interrupt for device 0000:00:1d.7 disabled
ACPI: PCI interrupt for device 0000:00:1d.2 disabled
ACPI: PCI interrupt for device 0000:00:1d.1 disabled
ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
BUG: sleeping function called from invalid context at mm/slab.c:2882
in_atomic():0, irqs_disabled():1
 [<c0103d59>] show_trace_log_lvl+0x149/0x170
 [<c01052ab>] show_trace+0x1b/0x20
 [<c01052d4>] dump_stack+0x24/0x30
 [<c0116e51>] __might_sleep+0xa1/0xc0
 [<c0165cb5>] kmem_cache_zalloc+0xa5/0xc0
 [<c0264b5a>] acpi_os_acquire_object+0x11/0x41
 [<c027a898>] acpi_ut_allocate_object_desc_dbg+0xf/0x45
 [<c027a926>] acpi_ut_create_internal_object_dbg+0x16/0x69
 [<c0276bd3>] acpi_rs_set_srs_method_data+0x80/0xdd
 [<c02762e5>] acpi_set_current_resources+0x31/0x3f
 [<c02826bf>] acpi_pci_link_set+0xfc/0x1a5
 [<c0282a25>] irqrouter_resume+0x52/0x73
 [<c02b92aa>] __sysdev_resume+0x1a/0x90
 [<c02b9367>] sysdev_resume+0x47/0x70
 [<c02bf1f8>] device_power_up+0x8/0x10
 [<c0142185>] suspend_enter+0x65/0x80
 [<c01422a8>] enter_state+0xc8/0x1b0
 [<c014242f>] state_store+0x9f/0xb0
 [<c01a502e>] subsys_attr_store+0x2e/0x30
 [<c01a5828>] sysfs_write_file+0xb8/0x100
 [<c0169187>] vfs_write+0xa7/0x190
 [<c0169bc7>] sys_write+0x47/0x70
 [<c01031fd>] sysenter_past_esp+0x56/0x8d
 [<b7fd3410>] 0xb7fd3410
PM: Writing back config space on device 0000:00:01.0 at offset 7 (was
2a03030, w
riting 22a03030)
PCI: Enabling device 0000:00:1d.0 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level,
low) -> IRQ
 11
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PM: Writing back config space on device 0000:00:1d.0 at offset f (was
100, writi
ng 10b)


