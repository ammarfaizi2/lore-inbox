Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267451AbTASLrv>; Sun, 19 Jan 2003 06:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbTASLrv>; Sun, 19 Jan 2003 06:47:51 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10206 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267451AbTASLru>; Sun, 19 Jan 2003 06:47:50 -0500
Date: Sun, 19 Jan 2003 12:56:47 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] mics cleanups for mtd
Message-ID: <20030119115647.GD10647@fs.tum.de>
References: <20030119012938.GY10647@fs.tum.de> <Pine.LNX.4.44.0301191117540.29823-100000@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301191117540.29823-100000@imladris.demon.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 11:32:33AM +0000, David Woodhouse wrote:
> On Sun, 19 Jan 2003, Adrian Bunk wrote:
> 
> > Below is a cleanup for mtd:
> > 
> > I started with removing all #if'd code for kernels < 2.4.4.
> 
> That's a reasonable idea, I suppose -- I haven't had someone bitch about
> me breaking the 2.2 uClinux build for a while now. I want to go further
> than that with the block device drivers -- they'll be completely forked
> for 2.4/2.5 support because it's just too ugly to try to support both.  
> 
> For most of the other code, the pain of maintaining two separate versions
> just isn't justified by the marginal cleanup which this affords -- 
> especially for the drivers where the _only_ difference between building 
> out-of-the-box in 2.4 and not doing so is a #include <linux/mtd/compatmac.h>

The #include <linux/mtd/compatmac.h> has _no_ effect for building on 2.4
kernels, it only affects 2.0 and 2.2 kernels.

The only reason why I said kernels < 2.4.4 is that I removed some
  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
from drivers/mtd/devices/blkmtd.c.

If you want to support the kernels 2.4.0, 2.4.1, 2.4.2 and 2.4.3 these 
should be kept, but linux/mtd/compatmac.h is not needed for this.

> > After this cleanup linux/mtd/compatmac.h contained only #include's so I 
> > completely removed this file, removed all #include's of it in both the 
> > mtd and jffs2 (sic) code and added the few needed #include's in the .c 
> > files.
> 
> You misunderstand the purpose of this. The idea is that the code itself
> can be written for the latest kernel, but people can use it on older
> kernels and compatmac.h makes it OK. If you remove the #include
> compatmac.h then that doesn't work; obviously :)

I can send whatever patch you want.

What is the minimum kernel version you want to support:
- 2.0.0
- 2.2.0
- 2.4.0
- 2.4.4

>...
> Adding the include files which were indirectly included through 
> compatmac.h is also OK -- we can just 'touch' those to make it build with 
> older kernels; they weren't intentionally omitted.

I haven't checked older kernels but at least kernel 2.2.20 includes all 
header files I've added (init.h, sched.h, vmalloc.h).

>...
> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

