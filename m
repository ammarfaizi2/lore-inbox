Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbSJPJ5m>; Wed, 16 Oct 2002 05:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265003AbSJPJ5m>; Wed, 16 Oct 2002 05:57:42 -0400
Received: from apollo.nbase.co.il ([194.90.137.2]:58630 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP
	id <S265002AbSJPJ5l>; Wed, 16 Oct 2002 05:57:41 -0400
Message-ID: <3DAD3A68.4090200@mrv.com>
Date: Wed, 16 Oct 2002 12:07:36 +0200
From: Eran Mann <emann@mrv.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>, johnstul@us.ibm.com
Subject: Re: Linux 2.4.20-pre11 - UP compile fails
References: <Pine.LNX.4.44L.0210152109360.31342-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20-pre11 compile with CONFIG_X86_LOCAL_APIC but without 
CONFIG_X86_IO_APIC fails in mpparse.c:
gcc -D__KERNEL__ -I/usr/src/2.4.20/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
mpparse.c:70: `dest_LowestPrio' undeclared here (not in a function)
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory `/usr/src/2.4.20/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

The offending line is:
mpparse.c:70:unsigned char int_delivery_mode = dest_LowestPrio;

This fails because mpparse.c compile depends on CONFIG_X86_LOCAL_APIC 
while dest_LowestPrio definition in include/asm-i386/io_apic.h depends 
on CONFIG_X86_IO_APIC.

Marcelo Tosatti wrote:
> Hi,
> 
> Here goes -pre11 with a lot of misc fixes.
> 
....

> <johnstul@us.ibm.com>:
>   o Cleanup clustered APIC code to allow others to use it
This seems to be the ChangeSet that introduced the failing line:
http://linux.bkbits.net:8080/linux-2.4/cset@1.783


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Eran Mann
Senior Software Engineer
MRV International
Tel: 972-4-9936297
Fax: 972-4-9890430
www.mrv.com

