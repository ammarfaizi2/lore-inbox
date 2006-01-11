Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWAKJ7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWAKJ7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWAKJ7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:59:21 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:15295 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932316AbWAKJ7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:59:18 -0500
Date: Wed, 11 Jan 2006 18:58:33 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Brown, Len" <len.brown@intel.com>
Subject: [Patch 0/2]Memory hotplug from ACPI container driver take 2.
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ACPI-ML <linux-acpi@vger.kernel.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060111184302.BCB0.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

I would like to post patches for ACPI memory hotplug again.
These are necessary when container driver, which is a kind of block
like NUMA node, calls memory hotplug.

If a node is hot-added, notification from ACPI reaches to container 
device, and container device driver will try to add and start
each devices which are included on the node by acpi_bus_add() and
acpi_bus_start(). 

But current acpi_memhotplug.c is just for the case that notification
reaches to memory device directly. So, add_memory() is just called by
notify handler of memory device.
If node is hot-added, contaner driver calls only acpi_memory_device_add()
to register "struct acpi_memory_device". But there is no start function
for memory, so add_memory() is not called.

I think that add_memory() should be called at acpi_bus_start() for
NUMA node case. These are patches for it.

These patches are for 2.6.15. And, I tested on my Tiger 4
 with Numa emulation by Custom DSDT.
Please apply.

Thanks.


-- 
Yasunori Goto 


