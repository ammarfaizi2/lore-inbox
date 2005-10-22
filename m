Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVJVLNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVJVLNF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 07:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVJVLNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 07:13:05 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:39572 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932220AbVJVLNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 07:13:04 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <435A1793.1050805@s5r6.in-berlin.de>
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com> <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>  <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <43593100.5040708@pobox.com> <43593884.7000800@adaptec.com> <4359395B.9030402@pobox.com> <43593FE1.7020506@adaptec.com> <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com> <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com> <43596F16.7000606@pobox.com> <435A1793.1050805@s5r6.in-berlin.de>
Date: Sat, 22 Oct 2005 04:12:44 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally
 attachedPHYs)
In-Reply-To: <435A1793.1050805@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.62.0510220357250.4997@qynat.qvtvafvgr.pbz>
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>
  <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com> 
 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com>
 <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com>
 <435929FD.4070304@adaptec.com> <43593100.5040708@pobox.com>
 <43593884.7000800@adaptec.com> <4359395B.9030402@pobox.com>
 <43593FE1.7020506@adaptec.com> <4359440E.2050702@pobox.com>
 <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com>
 <43595CA6.9010802@adaptec.com> <43596070.3090902@pobox.com>
 <43596859.3020801@adaptec.com> <43596F16.7000606@pobox.com>
 <435A1793.1050805@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2005, Stefan Richter wrote:

> Jeff Garzik wrote:
>> 
>> We differ on the path, not the goal.  As a thought experiment, you could 
>> try simply implementing the changes requested, and see where that goes.
>
> I doubt that the desired cleanup of the SCSI core could be done on-the-go, 
> i.e. without temporary breakage of larger parts of the subsystem (out of 
> mainline). But then again, I don't know much of the subsystem, so what am I 
> talking about here?
>
> Also, long-term breakage of smaller parts of the SCSI subsystem in mainline 
> is to be expected; breakage which is to be announced and scheduled.

Stefan, what you and Luben are missing is that big-bang changes like you 
are proposing are simply not acceptable anymore.

a few years ago when the 2.5 kernel series opened a similar big-bang 
approach was attempted for the IDE drivers. the instability that resulted 
(and rumors of the instability being worse then it was) eliminated a lot 
of people from testing things. things finally got bad enough that the 
entire system was reverted, and then a developer (one who had previously 
stated that such drastic changes were impossible) sat down and produced a 
long series of patches, each of which did a small amount of changes, each 
of which left the kernel in a working state (and each of which provided an 
advantage that could be identified at the time of the patch, either a 
better abstraction or a code cleanup). over a very few months (especially 
relative to the time spent working on the big-bang patches) the entire 
system was re-written.

This is what Jeff is trying to tell you. you can't just produce an 
entirely new SCSI subsystem and drop it into the kernel one day, you can 
all agree on a goal (this has almost been done, but nto quite), but that's 
only the first step. After you have some idea of the goal you then have to 
look at how to move to that goal without breaking things in the meantime. 
This requires that each step along the way keeps things working and is 
relativly straightforward in and of itself.

this definantly sounds a LOT harder then the 'throw it out and replace it 
all' approach, and it is (from the point of view of the programmer), 
however the result ends up being far more reliable as the process forces 
better examination of all the details, and allows more people to 
understand what's happening each step of the way. And since there are no 
releases that are made unuseable for people deliberatly, you also get 
extensive testing of all the steps along the way. This not only finds bugs 
sooner, it also makes it far more obvious where performance issues show up

so please accept that you aren't going to be able to replace any 
significant system in one massive change and instead start looking for 
ways to move the existing design towards where you want it to be and you 
will receive a lot of assistance in the process instead of banging heads 
with everyone.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
