Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUA2WN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 17:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUA2WN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 17:13:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7552 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266457AbUA2WN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 17:13:26 -0500
Date: Thu, 29 Jan 2004 17:06:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Satheesh Kumar <nksk76@yahoo.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel compilation : make modules fails
In-Reply-To: <20040129214636.75679.qmail@web41009.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0401291705570.5997@chaos>
References: <20040129214636.75679.qmail@web41009.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004, Satheesh Kumar wrote:

> I've attached the compilation failure messages
> with this mail.
>
> Appreciate your help.
>
> -Satheesh


`make modules` should have started out as:


make -C  kernel CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE" MAKING_MODULES=1 modules
make[1]: Entering directory `/usr/src/linux-2.4.20/kernel'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/usr/src/linux-2.4.20/kernel'
make -C  drivers CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE" MAKING_MODULES=1 modules
make[1]: Entering directory `/usr/src/linux-2.4.20/drivers'
make -C block modules
make[2]: Entering directory `/usr/src/linux-2.4.20/drivers/block'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=loop  -DEXPORT_SYMTAB -c loop.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=xd  -c -o xd.o xd.ca



Instead it started out as:


make -r -f tmp_include_depends all
make[1]: Entering directory `/usr/src/linux-2.4.20-8'
make[1]: Circular /usr/src/linux-2.4.20-8/include/asm/smplock.h <- /usr/src/linux-2.4.20-8/include/linux/interrupt.h dependency dropped.
make[1]: Circular /usr/src/linux-2.4.20-8/include/linux/netfilter_ipv4/ip_conntrack.h <- /usr/src/linux-2.4.20-8/include/linux/netfilter_ipv4/ip_conntrack_helper.h dependency dropped.
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/usr/src/linux-2.4.20-8'
make -C  kernel CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.20-8/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.20-8/include/linux/modversions.h" MAKING_MODULES=1 modules
make[1]: Entering directory `/usr/src/linux-2.4.20-8/kernel'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/usr/src/linux-2.4.20-8/kernel'
make -C  drivers CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.20-8/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.20-8/include/linux/modversions.h" MAKING_MODULES=1 modules



So, it seems that you started with an 'unclean' distribution.
Do:
cd /usr/src/linux-2.4.20-8 # Go there
cp .config /tmp		# Save configuration
make distclean		# Really clean it up
cp /tmp/.config .	# Get configuration back
make oldconfig		# Make configuration
make dep		# Set dependencies
make bzImage		# etc.
make modules


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


