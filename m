Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbUKDBlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUKDBlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 20:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUKDBlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 20:41:40 -0500
Received: from relay01.pair.com ([209.68.5.15]:22033 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S262041AbUKDBk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:40:58 -0500
X-pair-Authenticated: 66.190.53.4
Message-ID: <418988A6.4090902@cybsft.com>
Date: Wed, 03 Nov 2004 19:40:54 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sboyce@blueyonder.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
References: <4189108C.2050804@blueyonder.co.uk> <41892899.6080400@cybsft.com> <41897119.6030607@blueyonder.co.uk>
In-Reply-To: <41897119.6030607@blueyonder.co.uk>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040309050607030700030601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040309050607030700030601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sid Boyce wrote:
> K.R. Foley wrote:
> 
>> Sid Boyce wrote:
>>
>>>   CHK     include/linux/version.h
>>>   UPD     include/linux/version.h
>>>   SYMLINK include/asm -> include/asm-x86_64
>>> scripts/kconfig/conf -s arch/x86_64/Kconfig
>>> #
>>> # using defaults found in .config
>>> #
>>>   SPLIT   include/linux/autoconf.h -> include/config/*
>>>   CC      /usr/src/linux-2.6.10-rc1-mm2-RT-V0.7.7/include/asm/offsets.s
>>> In file included from include/asm/timex.h:12,
>>>                  from include/linux/timex.h:61,
>>>                  from include/linux/sched.h:11,
>>>                  from 
>>> /usr/src/linux-2.6.10-rc1-mm2-RT-V0.7.7/include/asm/offsets.c:7:
>>> include/asm/vsyscall.h:55: error: conflicting types for `xtime_lock'
>>> include/linux/time.h:83: error: previous declaration of `xtime_lock'
>>> make[1]: *** 
>>> [/usr/src/linux-2.6.10-rc1-mm2-RT-V0.7.7/include/asm/offsets.s] Error 1
>>> make: *** [prepare0] Error 2
>>>
>>> Regards
>>> Sid.
>>
>>
>>
>> You could try this untested patch that seems to follow Ingo's thinking 
>> for similar changes.
>>
>> kr
>>
>> --- linux-2.6.10-rc1-mm2/include/asm-x86_64/vsyscall.h.orig 2004-11-03 
>> 12:43:03.966625798 -0600
>> +++ linux-2.6.10-rc1-mm2/include/asm-x86_64/vsyscall.h  2004-11-03 
>> 12:44:19.430558964 -0600
>> @@ -45,14 +45,14 @@
>>  extern volatile unsigned long __jiffies;
>>  extern unsigned long __wall_jiffies;
>>  extern struct timezone __sys_tz;
>> -extern seqlock_t __xtime_lock;
>> +extern raw_seqlock_t __xtime_lock;
>>
>>  /* kernel space (writeable) */
>>  extern struct vxtime_data vxtime;
>>  extern unsigned long wall_jiffies;
>>  extern struct timezone sys_tz;
>>  extern int sysctl_vsyscall;
>> -extern seqlock_t xtime_lock;
>> +extern raw_seqlock_t xtime_lock;
>>
>>  #define ARCH_HAVE_XTIME_LOCK 1
>>
>>
>>
> Applied patch and getting the following error.
> 
> arch/x86_64/kernel/time.c:808: warning: passing arg 2 of `__writel' 
> makes pointer from integer without a cast
> arch/x86_64/kernel/time.c: In function `hpet_init':
> arch/x86_64/kernel/time.c:826: warning: passing arg 1 of `__readl' makes 
> pointer from integer without a cast
> arch/x86_64/kernel/time.c:832: warning: passing arg 1 of `__readl' makes 
> pointer from integer without a cast
> arch/x86_64/kernel/time.c: In function `time_init_smp':
> arch/x86_64/kernel/time.c:941: warning: passing arg 1 of `__readl' makes 
> pointer from integer without a cast
> arch/x86_64/kernel/time.c: In function `hpet_rtc_timer_init':
> arch/x86_64/kernel/time.c:1072: warning: passing arg 1 of `__readl' 
> makes pointer from integer without a cast
> arch/x86_64/kernel/time.c:1074: warning: passing arg 2 of `__writel' 
> makes pointer from integer without a cast
> arch/x86_64/kernel/time.c:1077: warning: passing arg 1 of `__readl' 
> makes pointer from integer without a cast
> arch/x86_64/kernel/time.c:1079: warning: passing arg 2 of `__writel' 
> makes pointer from integer without a cast
> arch/x86_64/kernel/time.c: In function `hpet_rtc_timer_reinit':
> arch/x86_64/kernel/time.c:1097: warning: passing arg 1 of `__readl' 
> makes pointer from integer without a cast
> arch/x86_64/kernel/time.c:1099: warning: passing arg 2 of `__writel' 
> makes pointer from integer without a cast
> arch/x86_64/kernel/time.c:1101: warning: passing arg 1 of `__readl' 
> makes pointer from integer without a cast
> arch/x86_64/kernel/time.c:1103: warning: passing arg 2 of `__writel' 
> makes pointer from integer without a cast

I am pretty sure the above is normal.

>   CC      arch/x86_64/kernel/ioport.o
>   CC      arch/x86_64/kernel/ldt.o
>   CC      arch/x86_64/kernel/setup.o
>   CC      arch/x86_64/kernel/i8259.o
>   CC      arch/x86_64/kernel/sys_x86_64.o
>   CC      arch/x86_64/kernel/x8664_ksyms.o
>   CC      arch/x86_64/kernel/i387.o
>   CC      arch/x86_64/kernel/syscall.o
>   CC      arch/x86_64/kernel/vsyscall.o
> In file included from arch/x86_64/kernel/vsyscall.c:50:
> include/asm/io.h: In function `memset_io':
> include/asm/io.h:265: warning: implicit declaration of function `memset'

Not sure if the above is problem or not. You'll know for sure at link time.

> arch/x86_64/kernel/vsyscall.c: At top level:
> arch/x86_64/kernel/vsyscall.c:56: error: conflicting types for 
> `__xtime_lock'
> include/asm/vsyscall.h:48: error: previous declaration of `__xtime_lock'

Does the patch below fix the above error?

> arch/x86_64/kernel/vsyscall.c: In function `do_vgettimeofday':
> arch/x86_64/kernel/vsyscall.c:92: warning: passing arg 1 of `__readl' 
> makes pointer from integer without a cast
> make[1]: *** [arch/x86_64/kernel/vsyscall.o] Error 1
> make: *** [arch/x86_64/kernel] Error 2
> Regards
> id.
> 

kr



--------------040309050607030700030601
Content-Type: text/plain;
 name="vsyscall.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vsyscall.patch2"

--- linux-2.6.10-rc1-mm2/arch/x86_64/kernel/vsyscall.c.orig	2004-11-03 19:32:26.847377112 -0600
+++ linux-2.6.10-rc1-mm2/arch/x86_64/kernel/vsyscall.c	2004-11-03 19:34:48.892102334 -0600
@@ -53,7 +53,7 @@
 #define force_inline __attribute__((always_inline)) inline
 
 int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
-seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
+DECLARE_RAW_SEQLOCK(__section_xtime_lock);
 
 #include <asm/unistd.h>
 

--------------040309050607030700030601--
