Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422828AbWJPS53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422828AbWJPS53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422832AbWJPS53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:57:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11925 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422828AbWJPS51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:57:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@muc.de>
Cc: Yinghai Lu <yinghai.lu@amd.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
Subject: Re: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when update pos for vector and offset
References: <86802c440610150029k28957786v3b313e29f1f52c8@mail.gmail.com>
	<86802c440610151221v2217cb67t354e1ccbcee54b6a@mail.gmail.com>
	<86802c440610160826g6b918d9bh65948d49f668e892@mail.gmail.com>
	<m1zmbwb0gg.fsf@ebiederm.dsl.xmission.com>
	<20061016183542.GA41969@muc.de>
Date: Mon, 16 Oct 2006 12:54:40 -0600
In-Reply-To: <20061016183542.GA41969@muc.de> (Andi Kleen's message of "16 Oct
	2006 20:35:42 +0200, Mon, 16 Oct 2006 20:35:42 +0200")
Message-ID: <m1mz7way6n.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> On Mon, Oct 16, 2006 at 12:05:35PM -0600, Eric W. Biederman wrote:
>> For 2.6.19 we should be able to get my typos fixed, and probably
>> the default mask increased so that we are given a choice of something
>> other than cpu 0.
>> 
>> Beyond that it is going to take some additional working and thinking
>> and so it probably makes sense to have the code sit in the -mm
>> or Andi's tree for a while, and let it mature for 2.6.20.
>
> I admit I lost track of the patches for this new code which went
> in while I was away.
>
> Is that the only patch needed or are there other known problems too?

The story.

The code went from -mm to -linus and everything was going smoothly
until we found a hyperthreaded cpu that in lowest priority delivery
mode would delivery mode would deliver irqs to hyperthreads even
if they were not in the mask.

Because of that and because Linus really likes lowest priority delivery
mode I submitted a patch that generalized the vector allocator to be
able to work on multiple cpus.

The patch was good except I missed one spot in retrigger irqs,
that YH caught, and I while the logic was fine in the vector allocator
I had several cases of using the wrong variable in the vector allocator.

Grumble! I made the vector allocator too general....

The one thinko that really affects people I fixed.  There are two more
cases that YH caught this weekend, that are still to be pushed.  Plus
there is the case that YH just caught that TARGET_CPUS being only a single
cpu is a real problem if you have more than 240 distinct irq sources.

So all that is pending are those two thinko fixes from YH.  The first
that fixes the retrigger irqs is a real bug fix.  The second that started
this thread is clearly the right thing to do, but I don't think there
are actually any real side effects from it.

Given how many thinkos I made last time I attacked this I'm not wanting
to do anything until I know I am thinking clearly :)

Eric
