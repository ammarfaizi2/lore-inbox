Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267918AbTBSCed>; Tue, 18 Feb 2003 21:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267935AbTBSCed>; Tue, 18 Feb 2003 21:34:33 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:47886 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S267918AbTBSCe3>;
	Tue, 18 Feb 2003 21:34:29 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A339@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Christoph Hellwig '" <hch@infradead.org>
Cc: "'Linux Kernel Mailing List '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>
Subject: RE: [PATCHSET] PC-9800 subarch. support for 2.5.61 (2/26) APM
Date: Wed, 19 Feb 2003 11:44:24 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Christoph Hellwig
To: Osamu Tomita
Cc: Linux Kernel Mailing List; Alan Cox
Sent: 2003/02/18 19:37
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (2/26) APM

> On Mon, Feb 17, 2003 at 10:49:55PM +0900, Osamu Tomita wrote:
>> +#include "io_ports.h"
> 
> Isn't this introduced in a later patch?  Please make sure your patchkit
> never breaks the compile of the existing subarches when applied in order.

Of course, I never want impact on other architecture.
io_ports.h is in 'core patch (8/26)'.

>> 
>>  		"pushl %%edi\n\t"
>>  		"pushl %%ebp\n\t"
>> +#ifdef CONFIG_X86_PC9800
>> +		"pushfl\n\t"
>> +#endif
>>  		"lcall *%%cs:apm_bios_entry\n\t"
>>  		"setc %%al\n\t"
>>  		"popl %%ebp\n\t"
>> @@ -682,6 +687,9 @@
>>  		__asm__ __volatile__(APM_DO_ZERO_SEGS
>>  			"pushl %%edi\n\t"
>>  			"pushl %%ebp\n\t"
>> +#ifdef CONFIG_X86_PC9800
>> +			"pushfl\n\t"
>> +#endif
> 
> Maybe add a
> 
> #ifdef CONFIG_X86_PC9800
> #define COND_PUSHFL	"pushfl\n\t"
> #else
> #define COND_PUSHFL	"pushfl\n\t"
> #endif
> 
> to the top of this file and then use it?
> 
I think "#ifndef"s are clear and readable rather than macro definition
at this situation. 

> +#ifndef CONFIG_X86_PC9800
> 
> Once again please always use #ifdef instead of #ifndef where possible.
I see.

Thanks,
Osamu Tomita
