Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312499AbSCUVR4>; Thu, 21 Mar 2002 16:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312500AbSCUVRq>; Thu, 21 Mar 2002 16:17:46 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:43147 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S312499AbSCUVRd>;
	Thu, 21 Mar 2002 16:17:33 -0500
Date: Thu, 21 Mar 2002 22:17:24 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203212117.WAA22504@harpo.it.uu.se>
To: macro@ds2.pg.gda.pl
Subject: Re: [PATCH] boot_cpu_data corruption on SMP x86
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Mar 2002 21:01:39 +0100 (MET), Maciej W. Rozycki wrote:
>On Thu, 14 Mar 2002, Mikael Pettersson wrote:
>
>> --- linux-2.4.19-pre3/arch/i386/kernel/head.S.~1~	Tue Feb 26 13:26:56 2002
>> +++ linux-2.4.19-pre3/arch/i386/kernel/head.S	Thu Mar 14 16:20:57 2002
>> @@ -178,7 +178,7 @@
>>   * we don't need to preserve eflags.
>>   */
>>  
>> -	movl $3,X86		# at least 386
>> +	movb $3,X86		# at least 386
>...
>
> This is broken -- these word stores assure a proper initialization on
>pre-CPUID processors.

boot_cpu_data is a static-extent object with an explicit initialiser
(i.e., ".data") in setup.c in 2.2.21rc2, 2.4.19-pre4, and 2.5.7.
Any further "initialisation" by APs is called "clobbering".

/Mikael
