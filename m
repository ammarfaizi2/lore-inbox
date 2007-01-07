Return-Path: <linux-kernel-owner+w=401wt.eu-S932544AbXAGOHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbXAGOHz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 09:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbXAGOHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 09:07:55 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:59185 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932544AbXAGOHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 09:07:54 -0500
Message-ID: <45A0FEB9.50906@vmware.com>
Date: Sun, 07 Jan 2007 06:07:53 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch] paravirt: isolate module ops
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com>	 <1168064710.20372.28.camel@localhost.localdomain>	 <20070106070807.GA11232@elte.hu>	 <1168105353.20372.39.camel@localhost.localdomain>	 <45A00CB0.2020509@vmware.com> <1168132196.20372.45.camel@localhost.localdomain>
In-Reply-To: <1168132196.20372.45.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Sat, 2007-01-06 at 12:55 -0800, Zachary Amsden wrote:
>   
>> Rusty Russell wrote:
>>     
>>> +int paravirt_write_msr(unsigned int msr, u64 val);
>>>       
>> If binary modules using debug registers makes us nervous, the 
>> reprogramming MSRs is also similarly bad.
>>     
>
> Yes, but this is simply from experience.  Several modules wrote msrs
> (you can take out the EXPORT_SYMBOL and find them quite quickly).
>   

Several in tree, GPL'd modules did so.  I'm not aware of out of tree 
modules that do that, and if they do, they are misbehaving.  
Reprogramming MTRR memory regions under the kernel's nose is not a 
proper way to behave, and this is the most benign use I can think of for 
write access to MSRs.  If this really breaks any code out there, then 
there should be a proper, controlled API to do this so the kernel can 
manage it.

>>> +void raw_safe_halt(void);
>>> +void halt(void);
>>>       
>> These shouldn't be done by modules, ever.  Only the scheduler should 
>> decide to halt.
>>     
>
> Several modules implement alternate halt loops.  I guess being in a
> module for specific CPUs makes sense...
>   

Yes, but halting is a behavior that can easily introduce critical, grind 
to a halt problems because of race conditions.  I have no problems 
having modules implement alternative halt loops.  I think there is a 
serious debuggability issue with binary modules invoking halt directly.

Zach
