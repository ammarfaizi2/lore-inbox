Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbVKQTYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVKQTYH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVKQTYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:24:07 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:58912 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964783AbVKQTYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:24:06 -0500
Message-ID: <437CD916.7030705@tmr.com>
Date: Thu, 17 Nov 2005 14:25:10 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <1132020468.27215.25.camel@mindpipe> <20051115032819.GA5620@redhat.com> <43795575.9010904@wolfmountaingroup.com> <20051115050658.GA13660@redhat.com> <43797E05.5090107@wolfmountaingroup.com> <17273.34218.334118.264701@cse.unsw.edu.au> <4379846E.2070006@wolfmountaingroup.com> <20051115141851.18c2c276.grundig@teleline.es> <1132061045.2822.20.camel@laptopd505.fenrus.org> <dld3cs$1sh$1@sea.gmane.org> <20051115185543.GI5735@stusta.de>
In-Reply-To: <20051115185543.GI5735@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Nov 15, 2005 at 11:46:30AM -0500, Giridhar Pemmasani wrote:
> 
>>Arjan van de Ven wrote:
>>
>>
>>>the same as 2.4 effectively. 2.6 also has (and I wish it becomes "had"
>>>soon) an option to get 6Kb effective stack space instead. This is an
>>>increase of 2Kb compared to 2.4.
>>
>>It has been asked couple of times before in this context and no one cared to
>>answer:
>>
>>Using 4k stacks may have advantages, but what compelling reasons are there
>>to drop the choice of 4k/8k stacks? You can make 4k stacks default, but why
>>throw away the option of 8k stacks, especially since the impact of this
>>option on the kernel implementation is very little?
> 
> 
> 
> One important point is to get remaining problems reported:
> 
> All the known issues in e.g. xfs, dm or reiser4 should have been 
> addressed.
> 
> But how many issues have never been reported because people noticed that 
> disabling CONFIG_4KSTACKS fixed the problem for them and therefore 
> didn't report it?
> 
> I experienced something similar with my patch to schedule OSS drivers 
> with ALSA replacements for removal - when someone reported he needed an 
> OSS driver for $reason I asked him for bug numbers in the ALSA bug 
> tracking system - and the highest number were 4 new bugs against one 
> ALSA driver.
> 
> Unconditionally enabling 4k stacks is the only way to achieve this.

The problem is that you persist in saying "the only way to achieve this" 
without admiting that some people are questioning the need to run in 4k 
stacks. The only argument I have seen for 4k stacks is that memory is 
allocated in 4k blocks and there might not be 8k contiguous available. 
When that's true the system is probably in deep trouble on memory anyway.

As someone pointed out using a larger memory allocation block (ie. 
multiple of hardware minimum page) would avoid the fragmentation, make 
all the bitmaps smaller, and generally have minimal effect either way on 
memory use. And you could make the stack size the memory allocation 
block size and never have to do conversions. Then the allocation size 
could be anything reasonable, from 4k to 32k as mentioned recently. 
Given the memory size of typical computers today, saving a few K per 
process matters as much as a beer fart in a cow barn.

Do all other non-x86 platforms use 4k stacks? Then why is it such a big 
thing to do it as the only choice for x86?

It seems like a lot of effort is being spent making things run in 4k 
stacks, with minimal consideration of what benefits are gained or if 
there are other ways to gain them. It just feels as though it's being 
done to prove it's possible. Linux is about choice, let's go back to that.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
