Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289166AbSBMXnG>; Wed, 13 Feb 2002 18:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289186AbSBMXm4>; Wed, 13 Feb 2002 18:42:56 -0500
Received: from rgminet1.oracle.com ([148.87.122.30]:53969 "EHLO
	rgminet1.oracle.com") by vger.kernel.org with ESMTP
	id <S289166AbSBMXmm>; Wed, 13 Feb 2002 18:42:42 -0500
Message-ID: <3C6AFA47.8020904@oracle.com>
Date: Thu, 14 Feb 2002 00:44:07 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Wayne.Brown@altec.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.5-pre1
In-Reply-To: <86256B5F.0080E1BC.00@smtpnotes.altec.com> <1013643123.950.43.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Wed, 2002-02-13 at 18:20, Wayne.Brown@altec.com wrote:
> 
> 
>>So where is it?  I haven't been able to find it at kernel.org yet.
>>
> 
> I'll keep the list in the CC since I see this question on IRC ...
> 
> its in 
> 	/pub/linux/kernel/testing
> not the usual
> 	/pub/linux/kernel/v2.5/testing

More issues:

  - xconfig broken

[asuardi@dolphin linux]$ make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
/usr/src/linux/include
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.5.5-pre1/scripts'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o tkparse.cgcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkcond.o tkcond.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o tkgen.c
gcc -o tkparse tkparse.o tkcond.o tkgen.o
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
sound/Config.in: 22: incorrect argument
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.5-pre1/scripts'
make: *** [xconfig] Error 2



  - rtctimer.c doesn't build due to undefined rtc_task_t

gcc -D__KERNEL__ -I/usr/src/linux-2.5.5-pre1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=rtctimer  -DEXPORT_SYMTAB -c rtctimer.c
rtctimer.c:75: parse error before "rtc_task"
rtctimer.c:75: warning: type defaults to `int' in declaration of `rtc_task'
rtctimer.c:75: warning: data definition has no type or storage class
rtctimer.c: In function `rtctimer_start':
rtctimer.c:99: `rtc_task_t' undeclared (first use in this function)
rtctimer.c:99: (Each undeclared identifier is reported only once
rtctimer.c:99: for each function it appears in.)
rtctimer.c:99: `rtc' undeclared (first use in this function)
rtctimer.c:99: invalid lvalue in assignment
rtctimer.c:101: warning: implicit declaration of function `rtc_control'
rtctimer.c: In function `rtctimer_stop':
rtctimer.c:110: `rtc_task_t' undeclared (first use in this function)
rtctimer.c:110: `rtc' undeclared (first use in this function)
rtctimer.c:110: invalid lvalue in assignment
rtctimer.c: In function `rtctimer_interrupt':
rtctimer.c:123: warning: implicit declaration of function `tasklet_hi_schedule'
rtctimer.c: In function `rtctimer_private_free':
rtctimer.c:143: `rtc_task_t' undeclared (first use in this function)
rtctimer.c:143: `rtc' undeclared (first use in this function)
rtctimer.c:143: invalid lvalue in assignment
rtctimer.c:145: warning: implicit declaration of function `rtc_unregister'
rtctimer.c: In function `rtctimer_init':
rtctimer.c:174: warning: implicit declaration of function `tasklet_init'
rtctimer.c:182: request for member `func' in something not a structure or union
rtctimer.c:183: request for member `private_data' in something not a structure or union
rtctimer.c:184: warning: implicit declaration of function `rtc_register'
rtctimer.c: At top level:
rtctimer.c:79: storage size of `rtc_tq' isn't known
make[3]: *** [rtctimer.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.5-pre1/sound/core'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.5-pre1/sound/core'
make[1]: *** [_subdir_core] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.5-pre1/sound'
make: *** [_dir_sound] Error 2



  - ramdisk broken (at least as module)

gcc -D__KERNEL__ -I/usr/src/linux-2.5.5-pre1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -DKBUILD_BASENAME=rd  -c -o rd.o rd.c
rd.c: In function `rd_make_request':
rd.c:271: too many arguments to function
make[2]: *** [rd.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.5-pre1/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.5-pre1/drivers'
make: *** [_mod_drivers] Error 2

--alessandro

  "If your heart is a flame burning brightly
    you'll have light and you'll never be cold
   And soon you will know that you just grow / You're not growing old"
                               (Husker Du, "Flexible Flyer")

