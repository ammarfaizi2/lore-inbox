Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWARLDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWARLDO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWARLDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:03:14 -0500
Received: from ns.suse.de ([195.135.220.2]:7065 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030221AbWARLDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:03:13 -0500
Date: Wed, 18 Jan 2006 12:03:04 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Kumar Gala <galak@kernel.crashing.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 6/6] serial8250: convert to the new platform device interface
Message-ID: <20060118110304.GA18326@suse.de>
References: <20060116233143.GB23097@flint.arm.linux.org.uk> <Pine.LNX.4.44.0601161752560.6677-100000@gate.crashing.org> <20060117193604.GA25724@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060117193604.GA25724@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jan 17, Olaf Hering wrote:

>  On Mon, Jan 16, Kumar Gala wrote:
> 
> > > Mea Culpa - should've spotted that - that patch is actually rather
> > > broken.  platform_driver_register() can't be moved from where it
> > > initially was.
> > 
> > This seems to fix my issue on arch/powerpc and arch/ppc, please push to 
> > Linus ASAP.


older pSeries systems with serial ports dont get any console output
after recent changes. CONFIG_ISA does not make sense for CONFIG_PPC_PSERIES
because it enables lots of old drivers.
Instead, remove the dependency on CONFIG_ISA from the serial port
discovery code.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/legacy_serial.c |    4 ----
 1 files changed, 4 deletions(-)

Index: linux-2.6.16-rc1-olh/arch/powerpc/kernel/legacy_serial.c
===================================================================
--- linux-2.6.16-rc1-olh.orig/arch/powerpc/kernel/legacy_serial.c
+++ linux-2.6.16-rc1-olh/arch/powerpc/kernel/legacy_serial.c
@@ -134,7 +134,6 @@ static int __init add_legacy_soc_port(st
 	return add_legacy_port(np, -1, UPIO_MEM, addr, addr, NO_IRQ, flags);
 }
 
-#ifdef CONFIG_ISA
 static int __init add_legacy_isa_port(struct device_node *np,
 				      struct device_node *isa_brg)
 {
@@ -168,7 +167,6 @@ static int __init add_legacy_isa_port(st
 	return add_legacy_port(np, index, UPIO_PORT, reg[1], taddr, NO_IRQ, UPF_BOOT_AUTOCONF);
 
 }
-#endif
 
 #ifdef CONFIG_PCI
 static int __init add_legacy_pci_port(struct device_node *np,
@@ -276,7 +274,6 @@ void __init find_legacy_serial_ports(voi
 		of_node_put(soc);
 	}
 
-#ifdef CONFIG_ISA
 	/* First fill our array with ISA ports */
 	for (np = NULL; (np = of_find_node_by_type(np, "serial"));) {
 		struct device_node *isa = of_get_parent(np);
@@ -287,7 +284,6 @@ void __init find_legacy_serial_ports(voi
 		}
 		of_node_put(isa);
 	}
-#endif
 
 #ifdef CONFIG_PCI
 	/* Next, try to locate PCI ports */

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
