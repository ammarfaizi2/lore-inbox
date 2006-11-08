Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754400AbWKHHTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400AbWKHHTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 02:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbWKHHTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 02:19:54 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:4541 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1754395AbWKHHTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 02:19:53 -0500
Date: Wed, 8 Nov 2006 16:22:35 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-ia64@vger.kernel.org, auke-jan.h.kok@intel.com, jeff@garzik.org
Subject: Re: [BUG] [2.6.19-rc4-mm2] can't compile
 drivers/acpi/processor_idle.c
Message-Id: <20061108162235.7645bb40.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061107225259.0eff22d2.akpm@osdl.org>
References: <20061108150141.b792fbdb.kamezawa.hiroyu@jp.fujitsu.com>
	<20061107225259.0eff22d2.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 22:52:59 -0800
Andrew Morton <akpm@osdl.org> wrote:

> On Wed, 8 Nov 2006 15:01:41 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> > 
> > While compiling 2.6.19-rc4-mm2 on ia64, I met this compile error.
> > ==
> >   CC [M]  drivers/acpi/processor_idle.o
> > drivers/acpi/processor_idle.c:43:22: asm/apic.h: No such file or directory
> > drivers/acpi/processor_idle.c: In function `acpi_processor_power_seq_show':
> > drivers/acpi/processor_idle.c:1202: warning: long long unsigned int format, u64 arg (arg 5)
> > ==
> > 
> > This is because of acpi-include-apic-h.patch, maybe.
> > ia64 doesn't have asm/acpi.h
> 
> That got fixed (by ugly means).

Ah, okay. I'll move to rc5-mm1. Thank you.

> 
> > my .config is attached.
> 
> But rc5-mm1 remains broken with that .config:
> 
> arch/ia64/pci/pci.c: In function `pci_acpi_scan_root':
> arch/ia64/pci/pci.c:354: warning: implicit declaration of function `pxm_to_node'
> ...
> arch/ia64/pci/built-in.o(.text+0xe92): In function `pci_acpi_scan_root':
> : undefined reference to `pxm_to_node'
> 
> This bug exists in mainline.
> 

How about this ? Maybe ia64 people's review is necessary.

-Kame
==
When ACPI && NUMA, pxm_to_node is used and it exists in drivers/acpi/numa.c

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujtisu.com>

Index: linux-2.6.19-rc4-mm2/arch/ia64/Kconfig
===================================================================
--- linux-2.6.19-rc4-mm2.orig/arch/ia64/Kconfig	2006-11-08 14:15:21.000000000 +0900
+++ linux-2.6.19-rc4-mm2/arch/ia64/Kconfig	2006-11-08 16:16:40.000000000 +0900
@@ -353,6 +353,7 @@
 	bool "NUMA support"
 	depends on !IA64_HP_SIM && !FLATMEM
 	default y if IA64_SGI_SN2
+	select ACPI_NUMA if ACPI
 	help
 	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
 	  Access).  This option is for configuring high-end multiprocessor

