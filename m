Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317754AbSGPELI>; Tue, 16 Jul 2002 00:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317755AbSGPELH>; Tue, 16 Jul 2002 00:11:07 -0400
Received: from host158.spe.iit.edu ([198.37.27.158]:14472 "EHLO lostlogicx.com")
	by vger.kernel.org with ESMTP id <S317754AbSGPELG>;
	Tue, 16 Jul 2002 00:11:06 -0400
Date: Mon, 15 Jul 2002 23:14:02 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-rc1-ac5 -- Build error in mpparse.c
Message-ID: <20020715231402.A29860@lostlogicx.com>
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com> <1026792066.1417.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1026792066.1417.19.camel@localhost.localdomain>; from miles@megapathdsl.net on Mon, Jul 15, 2002 at 09:01:06PM -0700
X-Operating-System: Linux found 2.4.17-openmosix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a "second" here, I think we are missing some #ifdef CONFIG_SMP in 
this file plus somewhere a twice defined constant showed up, looks like the 
latter definition is the correct one. (btw, this was introduced in -ac4)

--Brandon

On Mon, 07/15/02 at 21:01:06 -0700, Miles Lane wrote:
> I have not seen this particular error with mpparse.c 
> mentioned on LKML before.
> 
> I hit this with gcc version 3.1.1 20020708 (prerelease):
> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/3.1.1/include -DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
> In file included from mpparse.c:25:
> /usr/src/linux/include/asm/smp.h:45:1: warning: "INT_DELIVERY_MODE" redefined
> /usr/src/linux/include/asm/smp.h:42:1: warning: this is the location of the previous definition
> mpparse.c:72: parse error before numeric constant
> mpparse.c:76: parse error before numeric constant
> mpparse.c:77: parse error before numeric constant
> mpparse.c:78: parse error before numeric constant
> mpparse.c:79: parse error before numeric constant
> mpparse.c: In function `smp_read_mpc':
> mpparse.c:601: invalid lvalue in assignment
> 
> CONFIG_MPENTIUM4=y
> CONFIG_TOSHIBA=y
> CONFIG_MTRR=y
> # CONFIG_SMP is not set
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
