Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSGLKKz>; Fri, 12 Jul 2002 06:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSGLKKy>; Fri, 12 Jul 2002 06:10:54 -0400
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:15373 "EHLO
	Midgard.attbi.com") by vger.kernel.org with ESMTP
	id <S315870AbSGLKKw> convert rfc822-to-8bit; Fri, 12 Jul 2002 06:10:52 -0400
Content-Type: text/plain;
  charset="iso-8859-2"
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Missing files in 2.4.19-rc1
Date: Fri, 12 Jul 2002 05:13:48 -0500
User-Agent: KMail/1.4.2
References: <Pine.OSF.4.44.0207121138410.264794-100000@tao.natur.cuni.cz>
In-Reply-To: <Pine.OSF.4.44.0207121138410.264794-100000@tao.natur.cuni.cz>
Cc: Martin =?iso-8859-2?q?MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207120513.48616.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 July 2002 04:47 am, Martin MOKREJ© wrote:
> Hi,
>   I'm getting while `make dep`
>
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
> -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__
> au1000_gpio.c
>
> | /sbin/genksyms -p smp_ -k 2.4.19 >
> | /usr/src/linux-2.4.19-rc1/include/linux/modules/au1000_gpio.ver.tmp
>
(snip)
> via-pmu.c:40: asm/prom.h: No such file or directory
> via-pmu.c:41: asm/machdep.h: No such file or directory
> via-pmu.c:45: asm/sections.h: No such file or directory
> via-pmu.c:48: asm/pmac_feature.h: No such file or directory
> via-pmu.c:51: asm/sections.h: No such file or directory
> via-pmu.c:52: asm/cputable.h: No such file or directory
> via-pmu.c:53: asm/time.h: No such file or directory
(snip)
> amd7930.c:95: asm/openprom.h: No such file or directory
> amd7930.c:96: asm/oplib.h: No such file or directory
> amd7930.c:100: asm/sbus.h: No such file or directory
> amd7930.c:102: asm/audioio.h: No such file or directory
(snip)
> dbri.c:53: asm/openprom.h: No such file or directory
> dbri.c:54: asm/oplib.h: No such file or directory
> dbri.c:58: asm/sbus.h: No such file or directory
> dbri.c:61: asm/audioio.h: No such file or directory
(snip)
> su.c:78: asm/oplib.h: No such file or directory
> su.c:80: asm/ebus.h: No such file or directory
(snip)
> bbc_i2c.c:16: asm/oplib.h: No such file or directory
> bbc_i2c.c:17: asm/ebus.h: No such file or directory
> bbc_i2c.c:18: asm/spitfire.h: No such file or directory
> bbc_i2c.c:19: asm/bbc.h: No such file or directory

Dumb question: Did you do a make menuconfig/config/xconfig, or just copy over 
your .config file from an old kernel?  Was a make mrproper done at any time?

When you first untar a stock kernel source tree, the "include/asm" directory 
does not exist in the tree.  When you make config/menuconfig/xconfig, an 
"include/asm" symlink gets created (among other things), linking to an 
architecture specific asm header directory like include/asm-i386 or the like.  
"make mrproper" destroys this symlink as part of the source tree cleanup.

So if you fail to do the make *config, or you do a make mrproper after your 
most recent make *config, you lose that symlink.  Thus a possible cause for 
the errors you're getting.

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does it still cost 
four figures to fix?"

