Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271258AbTGQASM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 20:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271267AbTGQASL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 20:18:11 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:12420 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S271258AbTGQASF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 20:18:05 -0400
Message-ID: <3F15EEB7.2060008@netcabo.pt>
Date: Thu, 17 Jul 2003 01:32:55 +0100
From: Miguel Sousa Filipe <m3thos@netcabo.pt>
Organization: IST-RNL
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.4) Gecko/20030713
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1  doesn't compile on PPC iBook2.2
References: <200307170015.h6H0FRBX019953@harpo.it.uu.se>
In-Reply-To: <200307170015.h6H0FRBX019953@harpo.it.uu.se>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jul 2003 00:28:09.0274 (UTC) FILETIME=[4C6EC1A0:01C34BFA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> On Wed, 16 Jul 2003 22:14:40 +0100, Miguel Sousa Filipe wrote:
> 
>>  CC      arch/ppc/kernel/time.o
>>arch/ppc/kernel/time.c: In function `do_settimeofday':
>>arch/ppc/kernel/time.c:247: conflicting types for `new_nsec'
>>arch/ppc/kernel/time.c:245: previous declaration of `new_nsec'
>>arch/ppc/kernel/time.c:247: conflicting types for `new_sec'
>>arch/ppc/kernel/time.c:244: previous declaration of `new_sec'
>>make[1]: *** [arch/ppc/kernel/time.o] Error 1
>>make: *** [arch/ppc/kernel] Error 2
> 
> 
> Apply the following patch:
> 
> --- linux-2.6.0-test1/arch/ppc/kernel/time.c.~1~	2003-07-14 13:17:24.000000000 +0200
> +++ linux-2.6.0-test1/arch/ppc/kernel/time.c	2003-07-14 19:06:58.000000000 +0200
> @@ -244,7 +244,7 @@
>  	time_t wtm_sec, new_sec = tv->tv_sec;
>  	long wtm_nsec, new_nsec = tv->tv_nsec;
>  	unsigned long flags;
> -	int tb_delta, new_nsec, new_sec;
> +	int tb_delta;
>  
>  	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
>  		return -EINVAL;
> 

Done, now it fails in arch/ppc/platforms/pmac_cpufreq.c,

here is the error:

   CC      arch/ppc/platforms/pmac_nvram.o
   CC      arch/ppc/platforms/pmac_cpufreq.o
arch/ppc/platforms/pmac_cpufreq.c: In function `do_set_cpu_speed':
arch/ppc/platforms/pmac_cpufreq.c:179: `CPUFREQ_ALL_CPUS' undeclared (first use 
in this function)
arch/ppc/platforms/pmac_cpufreq.c:179: (Each undeclared identifier is reported 
only once
arch/ppc/platforms/pmac_cpufreq.c:179: for each function it appears in.)
make[1]: *** [arch/ppc/platforms/pmac_cpufreq.o] Error 1
make: *** [arch/ppc/platforms] Error 2


