Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267744AbTADAap>; Fri, 3 Jan 2003 19:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267746AbTADAap>; Fri, 3 Jan 2003 19:30:45 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39404 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267744AbTADAan>; Fri, 3 Jan 2003 19:30:43 -0500
Date: Sat, 4 Jan 2003 01:39:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: shivers@cc.gatech.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: make/configuration/dependency bug in 2.4.20 kernel
Message-ID: <20030104003914.GO6114@fs.tum.de>
References: <200212272032.gBRKWgM3012465@mongkok.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212272032.gBRKWgM3012465@mongkok.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2002 at 03:32:42PM -0500, shivers@cc.gatech.edu wrote:

> I am not a member of the linux kernel-hackers community, so if this is the
> wrong address for this message, please excuse my ignorance.
> 
> There appears to be a make/configuration/dependency bug in the
> 2.4.20 kernel found at
>     http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.20.tar.gz
> 
> * Short summary
> ---------------
> The build machinery isn't aware that the driver for the smc91c92 PCMCIA card
>     /lib/modules/2.4.20/kernel/drivers/net/pcmcia/smc91c92_cs.o
> depends on /usr/src/linux-2.4.20/drivers/net/mii.c.
>...

This is a known bug in 2.4.20 that is already fixed in 2.4.21-pre.

The following patch fixes it:

--- linux-2.4.20/drivers/net/Makefile.old	2003-01-04 01:36:43.000000000 +0100
+++ linux-2.4.20/drivers/net/Makefile	2003-01-04 01:37:14.000000000 +0100
@@ -226,6 +226,9 @@
 obj-$(CONFIG_TUN) += tun.o
 obj-$(CONFIG_DL2K) += dl2k.o
 
+# non-drivers/net drivers who want mii lib
+obj-$(CONFIG_PCMCIA_SMC91C92) += mii.o
+ 
 ifeq ($(CONFIG_ARCH_ACORN),y)
 mod-subdirs	+= ../acorn/net
 subdir-y	+= ../acorn/net


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

