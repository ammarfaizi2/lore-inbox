Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263431AbTDCTyS 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261492AbTDCTxe 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:53:34 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25310 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263572AbTDCTvH 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 14:51:07 -0500
Date: Thu, 3 Apr 2003 22:02:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, t-kouchi@cq.jp.nec.com
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: 2.5.66-mm3: acpiphp_glue.c must depend on CONFIG_ACPI_BUS
Message-ID: <20030403200228.GO3693@fs.tum.de>
References: <20030403005817.69a29d7b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403005817.69a29d7b.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is most likely neither new nor specific to -mm:

It seems drivers/hotplug/acpiphp_glue.c depends on CONFIG_ACPI_BUS 
and/or similar options but this isn't expressed in the Kconfig file 
(this compile error occurs with CONFIG_ACPI_HT_ONLY enabled):

<--  snip  -->

...
  gcc -Wp,-MD,drivers/hotplug/.acpiphp_glue.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default 
-nostdinc -iwithprefix include  -D_LINUX 
-I/home/bunk/linux/kernel-2.5/linux-2.5.66-mm3/drivers/acpi  -DKBUILD_BASENAME=acpiphp_glue -DKBUILD_MODNAME=acpiphp -c -o 
drivers/hotplug/acpiphp_glue.o drivers/hotplug/acpiphp_glue.c
drivers/hotplug/acpiphp_glue.c:642: warning: `struct acpi_device' 
declared inside parameter list
drivers/hotplug/acpiphp_glue.c:642: warning: its scope is only this 
definition or declaration, which is probably not what you want
drivers/hotplug/acpiphp_glue.c: In function `add_bridges':
drivers/hotplug/acpiphp_glue.c:644: dereferencing pointer to incomplete type
drivers/hotplug/acpiphp_glue.c: In function `enable_device':
drivers/hotplug/acpiphp_glue.c:828: warning: assignment makes pointer 
from integer without a cast
drivers/hotplug/acpiphp_glue.c: At top level:
drivers/hotplug/acpiphp_glue.c:1050: variable `acpi_pci_hp_driver' has 
initializer but incomplete type
drivers/hotplug/acpiphp_glue.c:1051: unknown field `name' specified in 
initializer
drivers/hotplug/acpiphp_glue.c:1051: warning: excess elements in struct 
initializer
drivers/hotplug/acpiphp_glue.c:1051: warning: (near initialization for 
`acpi_pci_hp_driver')
drivers/hotplug/acpiphp_glue.c:1052: unknown field `class' specified in 
initializer
drivers/hotplug/acpiphp_glue.c:1052: warning: excess elements in struct 
initializer
drivers/hotplug/acpiphp_glue.c:1052: warning: (near initialization for 
`acpi_pci_hp_driver')
drivers/hotplug/acpiphp_glue.c:1053: unknown field `ids' specified in 
initializer
drivers/hotplug/acpiphp_glue.c:1053: warning: excess elements in struct 
initializer
drivers/hotplug/acpiphp_glue.c:1053: warning: (near initialization for 
`acpi_pci_hp_driver')
drivers/hotplug/acpiphp_glue.c:1054: unknown field `ops' specified in 
initializer
drivers/hotplug/acpiphp_glue.c:1054: extra brace group at end of 
initializer
drivers/hotplug/acpiphp_glue.c:1054: (near initialization for 
`acpi_pci_hp_driver')
drivers/hotplug/acpiphp_glue.c:1056: warning: excess elements in struct 
initializer
drivers/hotplug/acpiphp_glue.c:1056: warning: (near initialization for 
`acpi_pci_hp_driver')
drivers/hotplug/acpiphp_glue.c: In function `acpiphp_glue_init':
drivers/hotplug/acpiphp_glue.c:1070: warning: implicit declaration of 
function `acpi_bus_register_driver'
include/linux/ctype.h: At top level:
drivers/hotplug/acpiphp_glue.c:1050: storage size of 
`acpi_pci_hp_driver' isn't known
make[2]: *** [drivers/hotplug/acpiphp_glue.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

