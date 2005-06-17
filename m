Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVFQRqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVFQRqU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVFQRqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:46:20 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:12555 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262030AbVFQRqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:46:14 -0400
Message-ID: <42B30CE9.4050707@tmr.com>
Date: Fri, 17 Jun 2005 13:48:25 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Stezenbach <js@linuxtv.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050607091144.GA5701@linuxtv.org> <20050608111503.GA5777@linuxtv.org> <42A6D521.606@ens-lyon.org> <20050608113718.GA5949@linuxtv.org>
In-Reply-To: <20050608113718.GA5949@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach wrote:
> Brice Goglin wrote:
> 
>>Johannes Stezenbach a écrit :
>>
>>>Johannes Stezenbach wrote:
>>>
>>>
>>>>Hype-threading stopped working for me (probably due to
>>>>me not enabling ACPI). dmesg output and .config attached.
>>>>-rc5 worked fine. The board is an Asus P4P800-Deluxe.
>>>>
>>>>dmesg: WARNING: 1 siblings found for CPU0, should be 2
>>>
>>>
>>>Indeed SMT works fine if I enable ACPI.
>>>Is SMT without ACPI not supported?
>>
>>You can pass acpi=ht into the kernel command line to disable
>>ACPI except the minimum required to get HT support.
> 
> 
> That's nice, but I was thinking along the lines of:
> 
> diff -ur linux-2.6.12-rc6.orig/arch/i386/Kconfig linux-2.6.12-rc6/arch/i386/Kconfig
> --- linux-2.6.12-rc6.orig/arch/i386/Kconfig	2005-06-06 23:16:27.000000000 +0200
> +++ linux-2.6.12-rc6/arch/i386/Kconfig	2005-06-08 13:35:08.000000000 +0200
> @@ -503,7 +503,7 @@
>  
>  config SCHED_SMT
>  	bool "SMT (Hyperthreading) scheduler support"
> -	depends on SMP
> +	depends on SMP && ACPI
>  	default off
>  	help
>  	  SMT scheduler support improves the CPU scheduler's decision making
> 
> Comments? Is this intended?

I would think that you can't do HT without ACPI, so there's no point in 
building in HT scheduling unless you can have HT.

Is that what you were asking? I was hoping someone else would comment.

Scheduling is getting harder and harder to get right... I have this 
thought of a Beowolf cluster of NUMA machines, with each node being HT 
multicore SMP. By "right" I meant "optimal," I'm sure that setup would 
do something reasonable with current scheduling.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
