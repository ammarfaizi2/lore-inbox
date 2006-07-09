Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbWGID7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWGID7N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 23:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbWGID7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 23:59:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49381 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161081AbWGID7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 23:59:13 -0400
Date: Sat, 8 Jul 2006 20:58:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Keith Owens <kaos@ocs.com.au>, Andi Kleen <ak@suse.de>,
       Jan Hubicka <jh@suse.cz>, "David S. Miller" <davem@davemloft.net>,
       Richard Henderson <rth@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile' 
In-Reply-To: <31410.1152414469@ocs3.ocs.com.au>
Message-ID: <Pine.LNX.4.64.0607082041400.5623@g5.osdl.org>
References: <31410.1152414469@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Jul 2006, Keith Owens wrote:
> 
>   			 "... Extended asm supports input-output or
>   read-write operands.  Use the constraint character `+' to indicate
>   such an operand and list it with the output operands.  You should
>   only use read-write operands when the constraints for the operand (or
>   the operand in which only some of the bits are to be changed) allow a
>   register."

Btw, gcc-4.1.1 docs seem to also have this language, although when you 
actually go to the "Constraint Modifier Characters" section, that thing 
doesn't actually say anything about "only for registers".

It would be good to have the gcc docs fixed. As mentioned, we've been 
using "+m" for at least a year (most of our current "+m" usage was there 
in 2.6.13), and some of those uses have actually been added by people that 
are at least active on the gcc development lists (eg Andi Kleen).

But let's add a few more people who are more deeply involved with gcc. 
Jan? Richard? Davem? Who would be the right person to check this out?

We can certainly write

	...
	:"=m" (*ptr)
	:"m" (*ptr)
	...

instead of the much simpler

	:"+m" (*ptr)

but we've been using that "+m" format for a long time already (and I 
_think_ we did so at the suggestion of gcc people), and it would be much 
better if the gcc documentation was just fixed here.

			Linus
