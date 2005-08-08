Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVHHPvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVHHPvt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVHHPvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:51:49 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:12036 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932092AbVHHPvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:51:48 -0400
Message-ID: <42F77F67.8070602@vmware.com>
Date: Mon, 08 Aug 2005 08:51:03 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Alexander Nyberg <alexn@telia.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CHECK_IRQ_PER_CPU() to avoid dead code in __do_IRQ()
References: <200508081250.05673.annabellesgarden@yahoo.de> <20050808111936.GA1393@localhost.localdomain> <200508081736.10690.annabellesgarden@yahoo.de>
In-Reply-To: <200508081736.10690.annabellesgarden@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Aug 2005 15:51:18.0640 (UTC) FILETIME=[041F0700:01C59C31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Wiese wrote:

>Am Montag, 8. August 2005 13:19 schrieb Alexander Nyberg:
>  
>
>>There are many places where one could replace run-time tests with 
>>#ifdef's but it makes reading more difficult (and in longer terms
>>maintainence). Have you benchmarked any workload that benefits 
>>from this?
>>    
>>
>
>Performance gain is small, but measurable: 0,02%
>Tested on an Atlon64 running at 1000MHz.
>I took this value from 9 runs (each with/without the patch) of 
>	$ time lame x.wav
>where each took about 1 minute.
>3000 Interrupts/s were generated at the time by running
>	$ jackd -R -dalsa -p64 -n2
>
>0,02% really isn't that much....but Athlon64 is better than P4
>with branch predictions, I think.
>
>Erm... ok, I won't insist on having this patch applied ;-) 
>
>   Karsten
>  
>

Removing dead code is always good - 0.02% is small, but if 100 kernel 
developers all did the same, that adds up to 2% rather quickly, and that 
is nothing to sneeze at.  I like your patch, but you should add some 
comments for maintainability about what CHECK_IRQ_PER_CPU does - see 
include/asm-generic/pgtable.h for similar styling.  If also probably 
doesn't hurt to leave IRQ_PER_CPU defined even when 
ARCH_HAS_CHECK_IRQ_PER_CPU is not, since it looks cleaner and prevents 
future collisions with bits defined inside of an #ifdef.

Zach
