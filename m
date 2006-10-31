Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423146AbWJaMkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423146AbWJaMkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 07:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423152AbWJaMkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 07:40:08 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:12517 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423146AbWJaMkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 07:40:06 -0500
Message-ID: <454743F2.6010305@in.ibm.com>
Date: Tue, 31 Oct 2006 18:09:14 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Pavel Emelianov <xemul@openvz.org>
CC: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, menage@google.com,
       linux-mm@kvack.org
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com> <4546212B.4010603@openvz.org> <454638D2.7050306@in.ibm.com> <45470DF4.70405@openvz.org> <45472B68.1050506@in.ibm.com> <4547305A.9070903@openvz.org>
In-Reply-To: <4547305A.9070903@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelianov wrote:
>> That's like disabling memory over-commit in the regular kernel.
> 
> Nope. We limit only unreclaimable mappings. Allowing user
> to break limits breaks the sense of limit.
> 
> Or you do not agree that allowing unlimited unreclaimable
> mappings doesn't alow you the way to cut groups gracefully?
> 


A quick code review showed that most of the accounting is the
same.

I see that most of the mmap accounting code, it seems to do
the equivalent of security_vm_enough_memory() when VM_ACCOUNT
is set. May be we could merge the accounting code to handle
even containers.

I looked at

do_mmap_pgoff
acct_stack_growth
__do_brk (
do_mremap


> [snip]
> 
>> Please see the patching of Rohit's memory controller for user
>> level patching. It seems much simpler.
> 
> Could you send me an URL where to get the patch from, please.
> Or the patch itself directly to me. Thank you.

Please see http://lkml.org/lkml/2006/9/19/283

> 
> [snip]
> 
>> I would prefer a different set
>>
>> 1 & 2, for now we could use any interface and then start developing the
>> controller. As we develop the new controller, we are likely to find the
>> need to add/enhance the interface, so freezing in on 1 & 2 might not be
>> a good idea.
> 
> Paul Menage won't agree. He believes that interface must come first.
> I also remind you that the latest beancounter patch provides all the
> stuff we're discussing. It may move tasks, limit all three resources
> discussed, reclaim memory and so on. And configfs interface could be
> attached easily.
> 

I think the interface should depend on the controllers and not
the other way around. I fear that the infrastructure discussion might
hold us back and no fruitful work will happen on the controllers.
Once we add and agree on the controller, we can then look at the
interface requirements (like persistence if kernel memory is being
tracked, etc). What do you think?

>> I would put 4, 5 and 6 ahead of 3, based on the changes I see in Rohit's
>> memory controller.
>>
>> Then take up the rest.
> 
> I'll review Rohit's patches and comment.

ok



-- 
	Thanks,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
