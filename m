Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbUAJRAx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUAJRAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:00:51 -0500
Received: from 217-162-71-11.dclient.hispeed.ch ([217.162.71.11]:33665 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S265256AbUAJRAe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:00:34 -0500
Message-ID: <40002F69.9020302@steudten.com>
Date: Sat, 10 Jan 2004 17:59:21 +0100
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: Thomas Steudten <alpha@steudten.com>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>,
       Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-alpha@vger.kernel.org, akpm@osdl.org
Subject: BUG: Kernel Panic: kernel-2.6.1 for alpha in scsi context ll_rw_blk.c
References: <3FB92938.8040906@steudten.com> <87r806d6n6.fsf@student.uni-tuebingen.de> <3FB93EF6.807@steudten.com> <87islid5tq.fsf@student.uni-tuebingen.de> <20031118021922.A7816@den.park.msu.ru> <3FBA8F20.3050701@steudten.com>
In-Reply-To: <3FBA8F20.3050701@steudten.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: Mailer
X-Authenticated-Sender: user thomas from 192.168.1.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I test the new 2.6.1 kernel and run in the same problem as before.
The reason is, that the patch from Ivan isn´t there in the kernel
source tree.

Please add the patch to the mainline.

Tom

Thomas Steudten wrote:

> Hi
> 
> With the patch from Ivan, the prefetch problem is gone.
> Please add this patch to the mainline for 2.6.0 for alpha.
> 
> Regards
> Tom
> 
>> We shouldn't prefetch the spinlocks on UP.
>>
>> Ivan.
>>
>> --- 2.6/include/asm-alpha/processor.h    Sat Oct 25 22:44:54 2003
>> +++ linux/include/asm-alpha/processor.h    Tue Nov 18 01:48:39 2003
>> @@ -78,6 +78,11 @@ unsigned long get_wchan(struct task_stru
>>  #define ARCH_HAS_PREFETCHW
>>  #define ARCH_HAS_SPINLOCK_PREFETCH
>>  
>> +#ifndef CONFIG_SMP
>> +/* Nothing to prefetch. */
>> +#define spin_lock_prefetch(lock)      do { } while (0)
>> +#endif
>> +
>>  #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
>>  extern inline void prefetch(const void *ptr)   { @@ -89,10 +94,13 @@ 
>> extern inline void prefetchw(const void      __builtin_prefetch(ptr, 
>> 1, 3);
>>  }
>>  
>> +#ifdef CONFIG_SMP
>>  extern inline void spin_lock_prefetch(const void *ptr)   {
>>      __builtin_prefetch(ptr, 1, 3);
>>  }
>> +#endif
>> +
>>  #else
>>  extern inline void prefetch(const void *ptr)   { @@ -104,10 +112,13 
>> @@ extern inline void prefetchw(const void      __asm__ ("ldq $31,%0" 
>> : : "m"(*(char *)ptr));  }
>>  
>> +#ifdef CONFIG_SMP
>>  extern inline void spin_lock_prefetch(const void *ptr)   {
>>      __asm__ ("ldq $31,%0" : : "m"(*(char *)ptr));  }
>> +#endif
>> +
>>  #endif /* GCC 3.1 */
>>  
>>  #endif /* __ASM_ALPHA_PROCESSOR_H */
> 
> 

-- 
Tom

LINUX user since kernel 0.99.x 1994.
RPM Alpha packages at http://alpha.steudten.com/packages
Want to know what S.u.S.E 1995 cdrom-set contains?


