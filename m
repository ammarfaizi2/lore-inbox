Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317922AbSG2UlE>; Mon, 29 Jul 2002 16:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSG2UlE>; Mon, 29 Jul 2002 16:41:04 -0400
Received: from codepoet.org ([166.70.99.138]:18080 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S317922AbSG2UlD>;
	Mon, 29 Jul 2002 16:41:03 -0400
Date: Mon, 29 Jul 2002 14:44:25 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc3-ac4
Message-ID: <20020729204424.GA4449@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200207291740.g6THewQ19578@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207291740.g6THewQ19578@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 29, 2002 at 01:40:58PM -0400, Alan Cox wrote:
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> This patch contains SiS IDE updates. Usual caveats apply. The HP merge is
> now down to 5340 lines.
> 
> Linux 2.4.19rc3-ac4
> o	Lots of gcc 3.1 __FUNCTION__ warning fixes	(me)

make -C drm modules
make[3]: Entering directory `/usr/src/linux/drivers/char/drm'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=radeon_drv  -c -o radeon_drv.o radeon_drv.c
In file included from radeon_drv.c:34:
ati_pcigart.h: In function `radeon_ati_pcigart_init':
ati_pcigart.h:96: parse error before `)'
ati_pcigart.h:102: parse error before `)'
ati_pcigart.h:107: parse error before `)'
ati_pcigart.h:115: parse error before `)'
ati_pcigart.h:135: parse error before `)'
[---------------tons of similar noise snipped-------------------]
In file included from radeon_drv.c:108:
drm_stub.h: In function `radeon_stub_register':
drm_stub.h:125: parse error before `)'
drm_stub.h:133: parse error before `)'
drm_stub.h:137: parse error before `)'
make[3]: *** [radeon_drv.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/char/drm'
make[2]: *** [_modsubdir_drm] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

The problem seems to be that 
    DRM_ERROR( "no scatter/gather memory!\n" );

expands into
    printk("<3>"  "[" "drm"  ":%s] *ERROR* "   "cannot allocate PCI GART page!\n"   ,  ) ;

I think the __FUNCTION__ changes to DRM_ERROR and friends in drmP.h 
look awfully bogus.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
