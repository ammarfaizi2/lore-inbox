Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271185AbTHCLDY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 07:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271177AbTHCLDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 07:03:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12010 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271158AbTHCLBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 07:01:17 -0400
Date: Sun, 3 Aug 2003 13:01:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, willy@ods.org,
       andrew.grover@intel.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.4 patch] fix a compile warning in acpi/system.c
Message-ID: <20030803110109.GQ16426@fs.tum.de>
References: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 01:19:11PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.22-pre9 to v2.4.22-pre10
> ============================================
>...
> Willy Tarreau:
>   o ACPI poweroff fix
>...

This patch causes the following compile warnings:

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.22-pre10-full/include -
Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6  -Os  -DACPI_DEBUG_OUTPUT 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=system  -c -o system.o system.c
system.c: In function `acpi_power_off':
system.c:93: warning: implicit declaration of function `acpi_suspend'
system.c: At top level:
system.c:303: warning: type mismatch with previous implicit declaration
system.c:93: warning: previous implicit declaration of `acpi_suspend'
system.c:303: warning: `acpi_suspend' was previously implicitly declared to return `int'
...

<--  snip  -->


The following patch removes these warnings:

--- linux-2.4.22-pre10-full/drivers/acpi/system.c.old	2003-08-02 22:23:08.000000000 +0200
+++ linux-2.4.22-pre10-full/drivers/acpi/system.c	2003-08-02 22:26:28.000000000 +0200
@@ -59,6 +59,8 @@
 static int acpi_system_add (struct acpi_device *device);
 static int acpi_system_remove (struct acpi_device *device, int type);
 
+acpi_status acpi_suspend (u32 state);
+
 static struct acpi_driver acpi_system_driver = {
 	.name =		ACPI_SYSTEM_DRIVER_NAME,
 	.class =	ACPI_SYSTEM_CLASS,



I've tested the compilation with 2.4.22-pre10.

Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

