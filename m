Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317605AbSGUAlF>; Sat, 20 Jul 2002 20:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317606AbSGUAlF>; Sat, 20 Jul 2002 20:41:05 -0400
Received: from host158.spe.iit.edu ([198.37.27.158]:61576 "EHLO lostlogicx.com")
	by vger.kernel.org with ESMTP id <S317605AbSGUAlE>;
	Sat, 20 Jul 2002 20:41:04 -0400
Date: Sat, 20 Jul 2002 19:44:03 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: Alastair Stevens <alastair@camlinux.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile failure: 2.4.19-rc2-ac2
Message-ID: <20020720194403.B21534@lostlogicx.com>
References: <1027026004.13704.6.camel@dolphin.entropy.net> <20020718202641.A1645@lostlogicx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020718202641.A1645@lostlogicx.com>; from lostlogic@gentoo.org on Thu, Jul 18, 2002 at 08:26:41PM -0500
X-Operating-System: Linux found 2.4.17-openmosix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have both of the APIC options selected in your config?  IF both 
IO-APIC and LOCAL-APIC are configured you shouldn't see this error, the 
problem occurs because the definition  of the dest_PRIORITY enums is 
#ifdef IO_APIC but the uses are not, perhaps the uses should use literals 
#ifndef IO_APIC, I"m not sure what the currect fix is, but doing a little 
bit of #ifdef in mpparse.c fixes it.  

--Brandon

On Thu, 07/18/02 at 20:26:41 -0500, Brandon Low wrote:
> I posted a crappity fix for this against -ac7, but I haven't seen the 
> problem in -rc2-acX, do you get the same error if you do make mrproper 
> first?
> 
> --Brandon
> 
> On Thu, 07/18/02 at 22:00:04 +0100, Alastair Stevens wrote:
> > Hi Alan & others
> > 
> > Just a compile failure report for 2.4.19-rc2-ac2, hope it's useful. My
> > system is an ordinary Athlon XP running RH7.3, and I'm currently on
> > 2.4.19-pre10-ac2. Using the same .config which I've been using for quite
> > some time, I got the following error, having done "make oldconfig dep
> > clean modules bzImage" from a pristine tree:
> > 
> > gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   
> > -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
> > -DKBUILD_BASENAME=pci_irq  -c -o pci-irq.o pci-irq.c
> > gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   
> > -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
> > -DKBUILD_BASENAME=mtrr  -DEXPORT_SYMTAB -c mtrr.c
> > gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   
> > -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
> > -DKBUILD_BASENAME=msr  -DEXPORT_SYMTAB -c msr.c
> > gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   
> > -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
> > -DKBUILD_BASENAME=cpuid  -DEXPORT_SYMTAB -c cpuid.c
> > gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   
> > -nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
> > -DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
> > mpparse.c:74: `dest_LowestPrio' undeclared here (not in a function)
> > mpparse.c: In function `smp_read_mpc':
> > mpparse.c:609: `dest_Fixed' undeclared (first use in this function)
> > mpparse.c:609: (Each undeclared identifier is reported only once
> > mpparse.c:609: for each function it appears in.)
> > mpparse.c:609: `dest_LowestPrio' undeclared (first use in this function)
> > make[1]: *** [mpparse.o] Error 1
> > make[1]: Leaving directory `/home/alastair/linux-2.4/arch/i386/kernel'
> > make: *** [_dir_arch/i386/kernel] Error 2
> > 
> > Regards
> > Alastair
> > 
> > -- 
> >  \\ Alastair Stevens                        Cambridge
> >   \\ Technical Director                        /     \..-^..^...
> >    \\                                          |Linux solutions \
> >     \\ 01223 813774                            \     /........../
> >      \\ www.camlinux.co.uk                      '-=-'
> >       --
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
