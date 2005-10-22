Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbVJVRl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVJVRl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVJVRl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:41:59 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:48109 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750960AbVJVRl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:41:57 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <435A79B4.9070201@s5r6.in-berlin.de>
Date: Sat, 22 Oct 2005 19:41:08 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: de, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Luben Tuikov <luben_tuikov@adaptec.com>,
       andrew.patterson@hp.com, Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attachedPHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com> <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>  <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <43593100.5040708@pobox.com> <43593884.7000800@adaptec.com> <4359395B.9030402@pobox.com> <43593FE1.7020506@adaptec.com> <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com> <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com> <43596F16.7000606@pobox.com> <435A1793.1050805@s5r6.in-berlin.de> <Pine.LNX.4.62.0510220357250.4997@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0510220357250.4997@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.703) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Sat, 22 Oct 2005, Stefan Richter wrote:
>> I doubt that the desired cleanup of the SCSI core could be done 
>> on-the-go, i.e. without temporary breakage of larger parts of the 
>> subsystem (out of mainline). But then again, I don't know much of the 
>> subsystem, so what am I talking about here?
>>
>> Also, long-term breakage of smaller parts of the SCSI subsystem in 
>> mainline is to be expected; breakage which is to be announced and 
>> scheduled.
> 
> Stefan, what you and Luben are missing is that big-bang changes like you 
> are proposing are simply not acceptable anymore.

I agree with you that big-bang changes are not acceptable. This wasn't 
however what I had in mind.

> a few years ago when the 2.5 kernel series opened a similar big-bang 
> approach was attempted for the IDE drivers. the instability that 
> resulted (and rumors of the instability being worse then it was) 
> eliminated a lot of people from testing things. things finally got bad 
> enough that the entire system was reverted, and then a developer (one 
> who had previously stated that such drastic changes were impossible) sat 
> down and produced a long series of patches, each of which did a small 
> amount of changes, each of which left the kernel in a working state (and 
> each of which provided an advantage that could be identified at the time 
> of the patch, either a better abstraction or a code cleanup). over a 
> very few months (especially relative to the time spent working on the 
> big-bang patches) the entire system was re-written.

What I proposed was to "renovate" a _part_ of the SCSI subsystem (the 
core and the interfaces of the rest of the subsystem to the core) with 
the 2.6 kernel as a basis. This is a huge difference to 2.5. Changes 
took place everywhere in 2.5, many of them drastic.

I agree with you that the incremental approach is preferrable whenever 
possible. I even believe that this method could be applied to the SCSI 
core cleanup. However, concerns were voiced that this method would 
effectively lead to a double SCSI core: The old one, and a new one in 
parallel to it which doesn't share much code with the old one. (At least 
for some time, perhaps for a too long time.)

It has been said multiple times that this would not be desirable for 
reasons of /a/ more kernel bloat (while the goal was to remove existing 
bloat and lay foundations to avoid future bloat), and /b/ massive 
maintenance burden of two parallel infrastructures.

So that's why I said that *short-term* breakage right on top and right 
below the core should be accepted.

Again, the huge difference to the 2.5 times would be that all this would 
happen on top of a relatively stable kernel. (Stable in two senses.)

> This is what Jeff is trying to tell you. you can't just produce an 
> entirely new SCSI subsystem and drop it into the kernel one day, you can 

What I was referring to was to clean up a _part_ of the subsystem (the 
core), not to replace the subsystem. I admit though that my wording left 
much room for misunderstanding.

Furthermore, note that the "scsi-cleanup tree" which I referred to is 
not meant to be a fork. It should merely be another working stage before 
the -mm stage. And let me add that this stage should be left as soon as 
possible.

> all agree on a goal (this has almost been done, but nto quite), but 
> that's only the first step. After you have some idea of the goal you 
> then have to look at how to move to that goal without breaking things in 
> the meantime. This requires that each step along the way keeps things 
> working and is relativly straightforward in and of itself.
> 
> this definantly sounds a LOT harder then the 'throw it out and replace 
> it all' approach, and it is (from the point of view of the programmer), 
> however the result ends up being far more reliable as the process forces 
> better examination of all the details,

I agree with you on that. Again, although my post may have sounded like 
it, I did not want to advocate the "throw it out and replace it all" 
approach.

> and allows more people to 
> understand what's happening each step of the way.

Absolutely.

However I don't agree with you that _every_ little step must keep 
everything working. I believe that this may actually make the transition 
less easy to follow.

> And since there are no 
> releases that are made unuseable for people deliberatly, you also get 

I did not suggest to make unuseable releases.

> extensive testing of all the steps along the way. This not only finds 
> bugs sooner, it also makes it far more obvious where performance issues 
> show up

I agree with you on these advantages of the "(try to) keep everything 
working after each patch". Although the monitoring of performance is 
less important during the initial stage of the cleanup of the core.

> so please accept that you aren't going to be able to replace any 
> significant system in one massive change

Agreed. This is absolutely not what should be done.

> and instead start looking for 
> ways to move the existing design towards where you want it to be and you 
> will receive a lot of assistance in the process instead of banging heads 
> with everyone.

OK.
-- 
Stefan Richter
-=====-=-=-= =-=- =-==-
http://arcgraph.de/sr/
