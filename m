Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbTAUHE4>; Tue, 21 Jan 2003 02:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266203AbTAUHEz>; Tue, 21 Jan 2003 02:04:55 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:56985 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266041AbTAUHEx>;
	Tue, 21 Jan 2003 02:04:53 -0500
Message-ID: <3E2CF327.8030107@colorfullife.com>
Date: Tue, 21 Jan 2003 08:13:43 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>, Zwane Mwaikambo <zwane@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] smp_call_function_mask
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:

>On Fri, 2003-01-17 at 05:18, Zwane Mwaikambo wrote:
>> +	/* Wait for response */
>> +	while (atomic_read(&data.started) != num_cpus)
>> +		barrier();
>
>Only old old intel x86 that does -bad- things as it
>generates a lot of bus locked cycles. Better to do
>
>	while(atomic_read(&data.started) != num_cpus)
>		while(data.started.value != num_cpus)
>		{
>			barrier();
>			cpu_relax();
>		}
>
>I would think ?
>
>  
>
from 2.5.52, <asm-i386/atomic.h>
    #define atomic_read(v)          ((v)->counter)
AFAIK atomic_read never contained locked bus cycles.

Btw, Zwane, what about removing non_atomic from the prototype?

--
    Manfred

