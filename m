Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264761AbSJaArY>; Wed, 30 Oct 2002 19:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSJaAq5>; Wed, 30 Oct 2002 19:46:57 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13799 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265057AbSJaAqv>; Wed, 30 Oct 2002 19:46:51 -0500
Date: Thu, 31 Oct 2002 01:53:14 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
In-Reply-To: <20021030233605.A32411@jaquet.dk>
Message-ID: <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Rasmus Andersen wrote:

> Hi,

Hi Rasmus,

>...
> As before, your comments and suggestions will be
> appreciated.

could you try to use "-Os" instead of "-O2" as gcc optimization option
when CONFIG_TINY is enabled? Something like the following (completely
untested) patch:

--- Makefile.old	2002-10-31 01:35:36.000000000 +0100
+++ Makefile	2002-10-31 01:49:10.000000000 +0100
@@ -155,8 +155,9 @@
 NOSTDINC_FLAGS  = -nostdinc -iwithprefix include

 CPPFLAGS	:= -D__KERNEL__ -Iinclude
-CFLAGS 		:= $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
+CFLAGS 		:= $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs\
 	  	   -fomit-frame-pointer -fno-strict-aliasing -fno-common
+
 AFLAGS		:= -D__ASSEMBLY__ $(CPPFLAGS)

 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
@@ -207,6 +208,13 @@

 endif

+ifdef CONFIG_TINY
+CFLAGS          += -Os
+else
+CFLAGS          += -O2
+endif
+
+
 include arch/$(ARCH)/Makefile

 core-y		+= kernel/ mm/ fs/ ipc/ security/


> Regards,
>   Rasmus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



