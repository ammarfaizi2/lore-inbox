Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262605AbSJBVQu>; Wed, 2 Oct 2002 17:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSJBVPq>; Wed, 2 Oct 2002 17:15:46 -0400
Received: from p028.as-l031.contactel.cz ([212.65.234.220]:13696 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S262598AbSJBVPR>;
	Wed, 2 Oct 2002 17:15:17 -0400
Date: Wed, 2 Oct 2002 23:08:48 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: tim <tim@holymonkey.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: include/asm/irq_vectors.h not found
Message-ID: <20021002210848.GE1883@ppc.vc.cvut.cz>
References: <20021002135939.129a6a5f.tim@holymonkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002135939.129a6a5f.tim@holymonkey.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 01:59:39PM -0700, tim wrote:
> when installing dri drivers for my gfx card (r200-20020927-linux.i386) i get the following error during kernel module compilation:

VMware suffers from same problem. Because of I do not support VMware
on SGI visual workstation, I now use an additional
-I/lib/modules/`uname -r`/build/arch/i386/mach-generic
in vmmon/vmnet Makefile, and for 2.5.x it is required to have full kernel 
source installed, not only kernel-headers package (if there is some distro
that distributes kernel-headers 2.5.x package...).

> cc -O2 -Wall -Wwrite-strings -Wpointer-arith -Wcast-align -Wstrict-prototypes -Wnested-externs -Wpointer-arith -D__KERNEL__ -DMODULE -fomit-frame-pointer -DCONFIG_AGP -DCONFIG_AGP_MODULE -DCONFIG_DRM_SIS -DMODVERSIONS -include /lib/modules/2.5.39/build/include/linux/modversions.h -DEXPORT_SYMTAB -I/lib/modules/2.5.39/build/include -c radeon_drv.c -o radeon_drv.o
> In file included from /lib/modules/2.5.39/build/include/linux/irq.h:19,
>                  from /lib/modules/2.5.39/build/include/asm/hardirq.h:6,
>                  from /lib/modules/2.5.39/build/include/linux/interrupt.h:44,
>                  from drm_os_linux.h:3,
>                  from drmP.h:75,
>                  from radeon_drv.c:32:
> /lib/modules/2.5.39/build/include/asm/irq.h:16: irq_vectors.h: No such file or directory
> make: *** [radeon_drv.o] Error 1

I think that behavior should be changed. irq_vectors.h (and eventually other .h) should
be moved to include/asm-i386/irq_vectors-generic.h (or irq_vectors-visws.h) and irq_vectors.h
should be either appropriate symlink, or simple 

#ifdef CONFIG_VISWS
#include <irq_vectors-visws.h>
#else
#include <irq_vectors-generic.h>
#endif

Or vendors should be taught to install properly configured kernel-sources by default,
so that we can use (cd /lib/modules/`uname -r`/build; make SUBDIRS=`pwd` modules) (or how
it works in 2.5.x kbuild) instead of just trying to guess compiler, compiler options
and include paths because of by default vendors's sources are configured for something 
else than running kernel (f.e. -Xcustom instead of -X in EXTRAVERSION in main makefile).

					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz


