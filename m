Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262661AbTCPMv1>; Sun, 16 Mar 2003 07:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbTCPMv1>; Sun, 16 Mar 2003 07:51:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18674 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262661AbTCPMv0>; Sun, 16 Mar 2003 07:51:26 -0500
Date: Sun, 16 Mar 2003 14:02:11 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.64-mm8: drivers/atm/idt77252.c doesn't compile
Message-ID: <20030316130211.GL24791@fs.tum.de>
References: <20030316024239.484f8bda.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030316024239.484f8bda.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 02:42:39AM -0800, Andrew Morton wrote:
>...
> All 124 patches:
> 
> linus.patch
>   Latest from Linus
>...

The following problem seems to come from Linus' tree:

tx_inuse was removed from struct atm_vcc in include/linux/atmdev.h but 
drivers/atm/idt77252.c still needs it:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/atm/.idt77252.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -g -nostdinc -iwithprefix include  -g  
-DKBUILD_BASENAME=idt77252 -DKBUILD_MODNAME=idt77252 -c -o 
drivers/atm/idt77252.o drivers/atm/idt77252.c
drivers/atm/idt77252.c: In function `alloc_scq':
drivers/atm/idt77252.c:669: warning: unsigned int format, different type arg (arg 5)
drivers/atm/idt77252.c: In function `push_on_scq':
drivers/atm/idt77252.c:733: structure has no member named `tx_inuse'
drivers/atm/idt77252.c: In function `idt77252_send_oam':
drivers/atm/idt77252.c:2028: structure has no member named `tx_inuse'
make[2]: *** [drivers/atm/idt77252.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

