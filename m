Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313900AbSDJV41>; Wed, 10 Apr 2002 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313904AbSDJV40>; Wed, 10 Apr 2002 17:56:26 -0400
Received: from tstac.esa.lanl.gov ([128.165.46.3]:60098 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S313900AbSDJV4W>; Wed, 10 Apr 2002 17:56:22 -0400
Subject: Re: Cannot compile mandrake 8.2 Kernel
From: Steven Cole <elenstev@mesatop.com>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0204101505220.5649-100000@rtlab.med.cornell.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 10 Apr 2002 15:52:43 -0600
Message-Id: <1018475564.17571.10.camel@spc.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-10 at 13:10, Calin A. Culianu wrote:
> 
> The stupid mandrake 8.2 kernel (2.4.18-mdk6) won't compile.  I know,
> mandrake is kind of a newbie distro, but I needed to mess with that kernel
> for some reason (don't ask).
> 
> Anyway it gets errors like the following then you do make modules.  I
> notices someone else also had the exact same problem.. also below is
> preprocessor output from that compile... I think the problem is due to
> some of the exported kernel symbols containing parens...:
> 
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.18-6mdk-rtl/include  -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-common -fomit-frame-pointer
> -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS
> -include /usr/src/linux-2.4.18-6mdk-rtl/include/linux/modversions.h
> -DKBUILD_BASENAME=loop  -DEXPORT_SYMTAB -c loop.c
> In file included from
> /usr/src/linux-2.4.18-6mdk-rtl/include/linux/prefetch.h:13,
>                  from
> /usr/src/linux-2.4.18-6mdk-rtl/include/linux/list.h:6,
>                  from
> /usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:12,
> from loop.c:64:
> /usr/src/linux-2.4.18-6mdk-rtl/include/asm/processor.h:51: warning:
> parameter names (without types) in function declaration
> /usr/src/linux-2.4.18-6mdk-rtl/include/asm/processor.h:51: field
> `loops_per_jiffy_R_ver_str' declared as a function
> In file included from loop.c:64:
> /usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:183: nondigits in
> number and not hexadecimal
> /usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:183: nondigits in
> number and not hexadecimal
> /usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:183: nondigits in
> number and not hexadecimal
> /usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:183: nondigits in
> number and not hexadecimal
> /usr/src/linux-2.4.18-6mdk-rtl/include/linux/module.h:183: parse error

[other errors snipped]

I was able to reproduce this, but then I remembered Jeff Garzik's advice
to always do a make mrproper (that applied to Alan's trees) when you see
this kind of thing.  So, I saved the Mandrake supplied .config somewhere
safe, did a make mrproper, copied the .config back, did make oldconfig,
make dep, make -j3 bzImage (dual PIII machine), and make modules.  The
first time, without the make mrproper, the failure occurred almost
immediately, and now make modules has been cranking away for quite a
while, so it should be OK.  Good luck.

Steven

