Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262678AbTCPPd3>; Sun, 16 Mar 2003 10:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262679AbTCPPd2>; Sun, 16 Mar 2003 10:33:28 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11757 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262678AbTCPPd1>; Sun, 16 Mar 2003 10:33:27 -0500
Date: Sun, 16 Mar 2003 16:44:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-mm8: drivers/atm/idt77252.c doesn't compile
Message-ID: <20030316154414.GB10253@fs.tum.de>
References: <20030316024239.484f8bda.akpm@digeo.com> <20030316130211.GL24791@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030316130211.GL24791@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 02:02:11PM +0100, Adrian Bunk wrote:
> On Sun, Mar 16, 2003 at 02:42:39AM -0800, Andrew Morton wrote:
> >...
> > All 124 patches:
> > 
> > linus.patch
> >   Latest from Linus
> >...
> 
> The following problem seems to come from Linus' tree:
> 
> tx_inuse was removed from struct atm_vcc in include/linux/atmdev.h but 
> drivers/atm/idt77252.c still needs it:
>...


The same problem is present in net/atm/pppoatm.c:


<--  snip  -->

...
  gcc -Wp,-MD,net/atm/.pppoatm.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -g -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=pppoatm -DKBUILD_MODNAME=pppoatm -c -o 
net/atm/pppoatm.o net/atm/pppoatm.c
net/atm/pppoatm.c: In function `pppoatm_send':
net/atm/pppoatm.c:234: structure has no member named `tx_inuse'
make[2]: *** [net/atm/pppoatm.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

