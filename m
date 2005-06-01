Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVFAULX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVFAULX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVFAUJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:09:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:58060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261152AbVFAUJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:09:06 -0400
Date: Wed, 1 Jun 2005 13:08:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Lynch <rusty.lynch@intel.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, rusty.lynch@intel.com
Subject: Re: 2.6.12-rc5-mm2 on x86_64 missing pci_bus_to_node symbol
Message-Id: <20050601130808.24772303.akpm@osdl.org>
In-Reply-To: <200506011857.j51IvjmE027415@linux.jf.intel.com>
References: <200506011857.j51IvjmE027415@linux.jf.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Lynch <rusty.lynch@intel.com> wrote:
>
> Attempting to install a fresh 2.6.12-rc5-mm2 kernel on my x86_64 box, 
>  I am unable to load my e1000 driver because pci_bus_to_node is undefined.

Doh.  I fixed that but forgot to include the patch in the series file, sorry.

>  I'm not sure if this is the correct way of fixing this, but here is a quick 
>  patch to export pci_bus_to_node on x86_64.

We tend to export things at their definition site nowadays:

--- 25/arch/x86_64/kernel/mpparse.c~x86-x86_64-pcibus_to_node-fix	2005-05-31 23:19:17.000000000 -0700
+++ 25-akpm/arch/x86_64/kernel/mpparse.c	2005-05-31 23:21:29.000000000 -0700
@@ -23,6 +23,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
+#include <linux/module.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -46,6 +47,7 @@ int apic_version [MAX_APICS];
 unsigned char mp_bus_id_to_type [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 unsigned char pci_bus_to_node [256];
+EXPORT_SYMBOL(pci_bus_to_node);
 
 static int mp_current_pci_id = 0;
 /* I/O APIC entries */
_

