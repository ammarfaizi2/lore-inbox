Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWILMHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWILMHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 08:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWILMHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 08:07:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:33433 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932267AbWILMHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 08:07:01 -0400
Message-ID: <4506A1A7.1010806@in.ibm.com>
Date: Tue, 12 Sep 2006 17:31:43 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Pavel Emelianov <xemul@openvz.org>
Cc: Srivatsa <vatsa@in.ibm.com>, sekharan@us.ibm.com,
       Rik van Riel <riel@redhat.com>,
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
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>	<44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>	<1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>	<1157730221.26324.52.camel@localhost.localdomain>	<4501B5F0.9050802@in.ibm.com>	<450508BB.7020609@openvz.org> <4505161E.1040401@in.ibm.com>	<45051AC7.2000607@openvz.org> <45051C0A.1060302@in.ibm.com> <45068E83.5070509@openvz.org>
In-Reply-To: <45068E83.5070509@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelianov wrote:
<snip>

>>>>> E.g. I have a node with 1Gb of ram and 10 containers with 100Mb
>>>>> guarantee each.
>>>>> I want to start one more. What shall I do not to break guarantees?
>>>> Don't start the new container or change the guarantees of the existing
>>>> ones
>>>> to accommodate this one :) The QoS design (done by the administrator)
>>>> should
>>>> take care of such use-cases. It would be perfectly ok to have a
>>>> container
>>>> that does not care about guarantees to set their guarantee to 0 and set
>>>> their limit to the desired value. As Chandra has been stating we
>>>> need two
>>>> parameters (guarantee, limit), either can be optional, but not both.
>>> If I set up 9 groups to have 100Mb limit then I have 100Mb assured (on
>>> 1Gb node)
>>> for the 10th one exactly. And I do not have to set up any guarantee as
>>> it won't affect
>>> anything. So what a guarantee parameter is needed for?
>> This use case works well for providing guarantee to one container.
>> What if
>> I want guarantees of 100Mb and 200Mb for two containers? How do I setup
>> the system using limits?
> You may set any value from 100 up to 800 Mb for the first one and
> 200-900Mb for
> the second. In case of no other groups first will receive its 100Mb for
> sure and
> so does the second. If there are other groups - their guarantees should
> be concerned.

If I add another group with a guarantee of 100MB, then its limit will
be anywhere between 100MB-800MB ?

I do not understand the guarantees being concerned part.

>> Even I restrict everyone else to 700Mb. With this I cannot be sure that
>> the remaining 300Mb will be distributed as 100Mb and 200Mb.
> There's no "everyone else" here - we're talking about a "static" case.
> When new group arrives we need to recalculate guarantees as you said.

I was speaking in general where we have 'n' groups, so thats why I had
"everyone else".

> And here's my next question - what to do if the new guarantee would become
> lower that current amount of unreclaimable memory in BC?
> 

I am not quite sure I understand this question. Let me try with an example.
Lets say I have 1GB of memory and I have guarantees of 100 and 200MB for
two groups. Lets say the total unreclaimable memory is 100MB. If I add a new
group with guarantee of 50MB, which is lower than the total amount of
total unreclaimable memory. The addition of the new group should be work
fine since we have 1GB - 100 - 100 - 200MB of memory available.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
