Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSJ2Jxs>; Tue, 29 Oct 2002 04:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSJ2Jxs>; Tue, 29 Oct 2002 04:53:48 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:63963 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261613AbSJ2Jxr>; Tue, 29 Oct 2002 04:53:47 -0500
Date: Tue, 29 Oct 2002 11:00:04 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.44-ac5
In-Reply-To: <200210281452.g9SEqwF17910@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0210291056170.14144-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<--  snip  -->

$ make xconfig
make -f scripts/Makefile scripts/kconfig.tk
  Generating scripts/kconfig.tk
drivers/serial/Config.in: 112: unknown define_bool value
...
make: *** [xconfig] Error 1
$

<--  snip  -->


The fix is simple:


--- linux-2.5.44-full-ac/drivers/serial/Config.in.old	2002-10-29 10:52:34.000000000 +0100
+++ linux-2.5.44-full-ac/drivers/serial/Config.in	2002-10-29 10:53:20.000000000 +0100
@@ -109,7 +109,7 @@
    bool '68360 SMC uart support' CONFIG_SERIAL_68360_SMC
    bool '68360 SCC uart support' CONFIG_SERIAL_68360_SCC
    if [ "$CONFIG_SERIAL_68360_SMC" = "y" -o "$CONFIG_SERIAL_68360_SCC" = "y" ]; then
-      define_bool CONFIG_68360_SERIAL
+      define_bool CONFIG_68360_SERIAL y
    fi
 fi



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



