Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266270AbSKOMFL>; Fri, 15 Nov 2002 07:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbSKOMFL>; Fri, 15 Nov 2002 07:05:11 -0500
Received: from holomorphy.com ([66.224.33.161]:38094 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266270AbSKOMFC>;
	Fri, 15 Nov 2002 07:05:02 -0500
Date: Fri, 15 Nov 2002 04:09:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021115120920.GV23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
References: <20021115081044.GI18180@conectiva.com.br> <20021115084915.GS23425@holomorphy.com> <20021115094827.GT23425@holomorphy.com> <20021115120233.GC25902@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115120233.GC25902@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[code snippet snipped]

On Fri, Nov 15, 2002 at 01:02:33PM +0100, Pavel Machek wrote:
> This certainly does not work. We'd need to do some deep magic in
> suspend_asm.S to copy pages back. [Well, deep magic... Same
> kmap_atomic.] But suspend_asm.S has to guarantee not touching any
> memory so the change is not quite trivial.

I wasn't entirely expecting it to work out of the box. I was really
trying to get the VM structure traversal and access in line with
the general case, and then worry (later) about deeper issues like
that once they arise. kmap_atomic() etc. should be no-ops without
highmem, so otherwise it'd be safe (at least on the save path), aside
from perhaps suggesting that highmem should work when it wouldn't.
The restore path, OTOH...

I should take a look at suspend_asm.S to get an idea of what you're
talking about with respect to its expectations being violated by
the code snippet I posted.


At some point in the past, I wrote:
>> I don't know what to make of highmem on laptops etc., but the VM's
>> conventions should not be that hard to follow; also, there are uses for
>> the swsusp functionality on other kinds of machines (e.g. checkpointing).
>> Pure computationally-oriented systems such as would make use of this
>> are somewhat different from my primary userbase to support, but I think
>> it would be valuable to generalize swsusp in this way, and so provide
>> rudimentary support for such users in addition to some small measure of
>> cleanup (i.e. the cleanup adds functionality).
>> Pavel, what do you think?

On Fri, Nov 15, 2002 at 01:02:33PM +0100, Pavel Machek wrote:
> I definitely want to support swsusp for server boxes, but I'm not 100%
> sure how to do that easily.
> 								Pavel

I'm not entirely sure either. Mostly I suspect that the deep arch
issues will be the tough ones, but things like this I can handle. =)


Thanks,
Bill
