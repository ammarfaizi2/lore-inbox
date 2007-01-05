Return-Path: <linux-kernel-owner+w=401wt.eu-S1161091AbXAENUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbXAENUH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 08:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbXAENUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 08:20:07 -0500
Received: from twin.jikos.cz ([213.151.79.26]:34918 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161091AbXAENUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 08:20:05 -0500
Date: Fri, 5 Jan 2007 14:19:41 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>
cc: linux-acpi@intel.com, linux-kernel@vger.kernel.org
Subject: ACPI bay - 2.6.20-rc3-mm1 hangs on boot
Message-ID: <Pine.LNX.4.64.0701051351200.16747@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.20-rc3-mm1 hangs on boot on my IBM T42p when compiled with ACPI_BAY=y. 
Below is the trace of two BUGs I get.

When compiled with ACPI_BAY=n, it boots fine.

The traces are hand-rewritten (no serial console on that machine), so I 
have omitted the code offsets in the stacktraces.

ACPI: ACPI Dock Station Driver
ACPI: \_SB_PCI0.IDE0.SCND.MSTR: found ejectable bay
ACPI: \_SB_PCI0.IDE0.SCND.MSTR: Adding notify handler
PM: Adding info for platform:bay.0
ACPI: Bay [\_SB_.PCI0.IDE0.SCND.MSTR] Added
BUG: at lib/kref.c:32 kref_get()
	kref_get+0x34/0x3b
	kobject_get+0xf/0x13
	get_bus+0xe/0x1d
	bus_add_driver+0x13/0x165
	init_waitqueue_head+0x12/0x1e
	bay_init+0x57/0x79
	find_bay+0x0/0x2c4
	init+0x88/0x16d
	restore_nocheck+0x12/0x15
	init+0x0/0x16d
	init+0x0/0x16d
	kernel_thread_helper+0x7/0x10
	==========
BUG: at lib/kref.c:32 kref_get()
	kref_get+0x34/0x3b
	kobject_get+0xf/0x13
	kobject_init+0x5d/0x70
	kobject_set_name+0x5c/0x92
	bus_add_driver+0x50/0x79
	bay_init+0x57/0x79
	find_bay+0x0/0x2c4
	init+0x88/0x16d
	init+0x88/0x16d
	kernel_thread_helper+0x7/0x10
	=========

-- 
Jiri Kosina
