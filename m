Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263034AbSITRG5>; Fri, 20 Sep 2002 13:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263062AbSITRG5>; Fri, 20 Sep 2002 13:06:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29901 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263034AbSITRG4>; Fri, 20 Sep 2002 13:06:56 -0400
Date: Fri, 20 Sep 2002 19:11:56 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>, Patrick Mochel <mochel@osdl.org>,
       <andrew.grover@intel.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.37
In-Reply-To: <Pine.LNX.4.33.0209200840320.2721-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0209201907480.10334-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Linus Torvalds wrote:

>...
> Patrick Mochel <mochel@osdl.org>:
>...
>   o ACPI: move PREFIX to a common header
>...


This patch that moved PREFIX to acpi_bus.h broke the compilation of
drivers/acpi/numa.c because this file didn't include acpi_bus.h:

<--  snip  -->

...
  gcc -Wp,-MD,./.numa.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.37-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -I/home/bunk/linux/kernel-2.5/linux-2.5.37-full/arch/i386/mach-generic
-nostdinc -iwithprefix include  -D_LINUX -I/home/bunk/linux/kernel-2.5/linux-2.5.37-full/d
rivers/acpi/include -DACPI_DEBUG_OUTPUT  -DKBUILD_BASENAME=numa   -c -o
numa.o numa.c
numa.c: In function `acpi_table_print_srat_entry':
numa.c:48: parse error before `PREFIX'
...
make[2]: *** [numa.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.37-full/drivers/acpi'

<--  snip  -->


The fix is simple:


--- drivers/acpi/numa.c.old	2002-09-20 19:05:06.000000000 +0200
+++ drivers/acpi/numa.c	2002-09-20 19:06:48.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/acpi.h>
+#include "acpi_bus.h"

 extern int __init acpi_table_parse_madt_family (enum acpi_table_id id, unsigned long madt_size, int entry_id, acpi_madt_entry_handler handler);


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

