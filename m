Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbTBULid>; Fri, 21 Feb 2003 06:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267385AbTBULid>; Fri, 21 Feb 2003 06:38:33 -0500
Received: from node-c-58b2.a2000.nl ([62.194.88.178]:64384 "EHLO
	wsprwl.xs4all.nl") by vger.kernel.org with ESMTP id <S267365AbTBULib>;
	Fri, 21 Feb 2003 06:38:31 -0500
Date: Fri, 21 Feb 2003 12:48:38 +0100
From: rkmp@xs4all.nl
To: linux-kernel@vger.kernel.org
Cc: Thomas Stuefe <thomas.stuefe@online.de>
Subject: Re: 2.5.62 hisax compile broke. isac_setup double defined (hisax.o & hisax_isac.o)
Message-ID: <20030221114838.GA26631@wsprwl.xs4all.nl>
References: <200302211138.19592.thomas.stuefe@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302211138.19592.thomas.stuefe@online.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems not the only bug in compiling ISDN,  I have this for the last
few kernel versions (note the "....hisax 1..." probably should read "=1")

  gcc -Wp,-MD,drivers/isdn/hisax/.fsm.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include  -DHISAX_MAX_CARDS=2  -DKBUILD_BASENAME=fsm -DKBUILD_MODNAME=hisax -c -o drivers/isdn/hisax/fsm.o drivers/isdn/hisax/fsm.c
  gcc -Wp,-MD,drivers/isdn/hisax/.cert.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include  -DHISAX_MAX_CARDS=2 -DCERTIFICATION=/usr/src/linux-2.5.62/drivers/isdn/hisax 1 -DKBUILD_BASENAME=cert -DKBUILD_MODNAME=hisax -c -o drivers/isdn/hisax/cert.o drivers/isdn/hisax/cert.c
gcc: cannot specify -o with -c or -S and multiple compilations
make[3]: *** [drivers/isdn/hisax/cert.o] Error 1
make[2]: *** [drivers/isdn/hisax] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2

>gcc --version
2.95.3

>grep ISDN .config
# ISDN subsystem
CONFIG_ISDN_BOOL=y
# Old ISDN4Linux
CONFIG_ISDN=y
# CONFIG_ISDN_NET_SIMPLE is not set
# CONFIG_ISDN_NET_CISCO is not set
CONFIG_ISDN_PPP=y
# CONFIG_ISDN_PPP_VJ is not set
# CONFIG_ISDN_MPP is not set
# CONFIG_ISDN_PPP_BSDCOMP is not set
# CONFIG_ISDN_AUDIO is not set
# ISDN feature submodules
# CONFIG_ISDN_DRV_LOOP is not set
# CONFIG_ISDN_DIVERSION is not set
# CONFIG_ISDN_CAPI is not set
# ISDN4Linux hardware drivers
CONFIG_ISDN_DRV_HISAX=y
# CONFIG_ISDN_DRV_ICN is not set
# CONFIG_ISDN_DRV_PCBIT is not set
# CONFIG_ISDN_DRV_SC is not set
# CONFIG_ISDN_DRV_ACT2000 is not set
# CONFIG_ISDN_DRV_EICON is not set
# CONFIG_ISDN_DRV_TPAM is not set

_
Ruud Linders

On Fri, Feb 21, 2003 at 11:38:19AM +0100, Thomas Stuefe wrote:
> hi all,
> 
> tried to compile 2.5.62. 
> 
> when linking hisax/built-in.o, the linker complains about the function 
> isac_setup being defined twice, once in hisax.o and once in hisax_isac.o.
> 
> 
