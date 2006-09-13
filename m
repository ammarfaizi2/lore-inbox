Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbWIMIGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWIMIGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 04:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbWIMIGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 04:06:46 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:5561 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751683AbWIMIGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 04:06:45 -0400
Message-ID: <4507BC11.6080203@openvz.org>
Date: Wed, 13 Sep 2006 12:06:41 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: sekharan@us.ibm.com, balbir@in.ibm.com, Srivatsa <vatsa@in.ibm.com>
CC: Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>	 <44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>	 <1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>	 <1157730221.26324.52.camel@localhost.localdomain>	 <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>	 <4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>	 <1158000590.6029.33.camel@linuxchandra>  <45069072.4010007@openvz.org> <1158105488.4800.23.camel@linuxchandra>
In-Reply-To: <1158105488.4800.23.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Tue, 2006-09-12 at 14:48 +0400, Pavel Emelianov wrote:
> <snip>
>   
>>> I do not think it is that simple since
>>>  - there is typically more than one class I want to set guarantee to
>>>  - I will not able to use both limit and guarantee
>>>  - Implementation will not be work-conserving.
>>>
>>> Also, How would you configure the following in your model ?
>>>
>>> 5 classes: Class A(10, 40), Class B(20, 100), Class C (30, 100), Class D
>>> (5, 100), Class E(15, 50); (class_name(guarantee, limit))
>>>   
>>>       
>> What's the total memory amount on the node? Without it it's hard to make
>> any
>> guarantee.
>>     
>
> I wrote the example treating them as %, so 100 would be the total amount
> of memory.
>   
OK. Then limiting must be done this way (unreclaimable limit/total limit)
A (15/40)
B (25/100)
C (35/100)
D (10/100)
E (20/50)
In this case each group will receive it's guarantee for sure.

E.g. even if A, B, E and D will eat all it's unreclaimable memory then
we'll have
100 - 15 - 25 - 20 - 10 = 30% of memory left (maybe after reclaiming) which
is perfectly enough for C's guarantee.
>   
>>> "Limit only" approach works for DoS prevention. But for providing QoS
>>> you would need guarantee.
>>>   
>>>       
>> You may not provide guarantee on physycal resource for a particular group
>> without limiting its usage by other groups. That's my major idea.
>>     
>
> I agree with that, but the other way around (i.e provide guarantee for
> everyone by imposing limits on everyone) is what I am saying is not
> possible.
Then how do you make sure that memory WILL be available when the group needs
it without limiting the others in a proper way?
