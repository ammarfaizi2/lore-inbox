Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVITSY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVITSY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVITSY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:24:56 -0400
Received: from mail.ctyme.com ([69.50.231.10]:34022 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S965021AbVITSYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:24:55 -0400
Message-ID: <433053ED.7080209@perkel.com>
Date: Tue, 20 Sep 2005 11:24:45 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Lampert <scott@lampert.org>
CC: Frank van Maarseveen <frankvm@frankvm.com>, linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks
References: <432E3D4C.4070508@perkel.com> <20050920070214.GA4208@janus> <43304F96.6000805@lampert.org>
In-Reply-To: <43304F96.6000805@lampert.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-filter-host: newton.ctyme.com - http://www.junkemailfilter.com
X-Sender-host-address: 204.95.16.61
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah - there's a patch for that here:

http://bugzilla.kernel.org/show_bug.cgi?id=5105

I haven't tried it yet but will later when I go to the data center. You 
might want to try it and let me know if it actually fixed the problem.

diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -959,9 +959,6 @@ static __init int unsynchronized_tsc(voi
  	   are handled in the OEM check above. */
  	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
  		return 0;
- 	/* All in a single socket - should be synchronized */
- 	if (cpus_weight(cpu_core_map[0]) == num_online_cpus())
- 		return 0;
 #endif
  	/* Assume multi socket systems are not synchronized */
  	return num_online_cpus() > 1;


Mizery loves company. I'm glad I'm not the only one with this problem.


Scott Lampert wrote:

> I have the exact same problem on a ASUS A8N-SLI Premium board and 
> Athlon64 4800+ X2 with every BIOS up to 1008-01.  Running with notsc 
> is the only way to get it to work.
>
> As an aside BIOS version 1008-003 is available for this board however 
> this one seems to be WAY worse as the board won't even boot.  It gets 
> panics before the boot messages unless you boot with noapic and after 
> that it gets checksum errors on the RSDP.  I'm afraid to see what the 
> next official BIOS version does. :/
>    -Scott
>
> Frank van Maarseveen wrote:
>
>> On Sun, Sep 18, 2005 at 09:23:40PM -0700, Marc Perkel wrote:
>>  
>>
>>> Got a dual core Athlon 64 X2 on an Asus board using NVidia chipset 
>>> and getting lost ticks. The software clock of course is totally 
>>> messed up. I've scanned google for a solution and see others 
>>> complaining about bad code in the SMM BIOS. I have the latest bios 
>>> and whatever they need to fix - isn't.
>>>
>>> So - what do I do to make it work?
>>>   
>>
>>
>> See http://bugzilla.kernel.org/show_bug.cgi?id=5105
>>
>> On the kernel command-line:
>>
>> x86_64:    try "notsc"
>> i386:    try "clock=pit"
>>
>> "nosmp" works but isn't fun.
>>
>>  
>>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

