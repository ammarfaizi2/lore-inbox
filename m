Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752113AbWCGHDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbWCGHDu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbWCGHDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:03:49 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:55712 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752089AbWCGHDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:03:48 -0500
Date: Tue, 7 Mar 2006 16:03:14 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Greg KH <greg@kroah.com>, LHMS <lhms-devel@lists.sourceforge.net>,
       ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH] naming memory hotplug's phys_device take2 [3/3] name memory
 at boot
Message-Id: <20060307160314.35687b55.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch shows ACPI information of rams which exists at boot time,
maybe will not be used until memory-hot-remove will be implemented.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc5-mm2/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/drivers/acpi/acpi_memhotplug.c	2006-03-07 15:28:08.000000000 +0900
+++ linux-2.6.16-rc5-mm2/drivers/acpi/acpi_memhotplug.c	2006-03-07 15:28:10.000000000 +0900
@@ -387,6 +387,10 @@
 
 	printk(KERN_INFO "%s \n", acpi_device_name(device));
 
+	/* if memory is available now (we have page memmap), name it */
+	if ( pfn_valid(mem_device->start_addr >> PAGE_SHIFT)) {
+		acpi_memory_device_export_name(mem_device);
+	}
 	return_VALUE(result);
 }
 
