Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319686AbSIMQLI>; Fri, 13 Sep 2002 12:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319698AbSIMQLI>; Fri, 13 Sep 2002 12:11:08 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:54255 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S319686AbSIMQLC>; Fri, 13 Sep 2002 12:11:02 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3D81D377.9FD9EE75@eyal.emu.id.au> 
References: <3D81D377.9FD9EE75@eyal.emu.id.au>  <Pine.LNX.4.44.0209122313470.30211-100000@freak.distro.conectiva> 
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, ralf@linux-mips.org
Subject: Re: Linux 2.4.20-pre7 - compile fixes 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Sep 2002 17:15:17 +0100
Message-ID: <3734.1031933717@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


eyal@eyal.emu.id.au said:
> drivers/mtd/devices/ms02-nv.c
> ============================= 
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
> -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include /
> data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=ms02_nv  -c -o
> ms02-nv.o ms02-nv.c

Grr. Never seen this code before in my life. Do I need to update my address 
in MAINTAINERS?

--- Config.in	13 Sep 2002 13:46:55 -0000	1.6
+++ Config.in	13 Sep 2002 16:06:40 -0000	1.7
@@ -10,7 +10,9 @@
    bool '    PMC551 256M DRAM Bugfix' CONFIG_MTD_PMC551_BUGFIX
    bool '    PMC551 Debugging' CONFIG_MTD_PMC551_DEBUG
 fi
-dep_tristate '  DEC MS02-NV NVRAM module support' CONFIG_MTD_MS02NV $CONFIG_MTD $CONFIG_DECSTATION
+if [ "$CONFIG_DECSTATION" = "y" ]; then
+  dep_tristate '  DEC MS02-NV NVRAM module support' CONFIG_MTD_MS02NV $CONFIG_MTD
+fi
 dep_tristate '  Uncached system RAM' CONFIG_MTD_SLRAM $CONFIG_MTD
 if [ "$CONFIG_SA1100_LART" = "y" ]; then
   dep_tristate '  28F160xx flash driver for LART' CONFIG_MTD_LART $CONFIG_MTD




--
dwmw2


