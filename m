Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318864AbSICQ0I>; Tue, 3 Sep 2002 12:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318866AbSICQ0I>; Tue, 3 Sep 2002 12:26:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23561 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318864AbSICQ0H>; Tue, 3 Sep 2002 12:26:07 -0400
Date: Tue, 3 Sep 2002 01:19:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
In-Reply-To: <p73u1l7qbxs.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0209030113420.12861-100000@kiwi.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3 Sep 2002, Andi Kleen wrote:
>
> x86-64 does that already. I did it originally to fix some printk warnings.
> But it caused even more. I didn't bother then to change it back. Doesn't
> seem to have too many bad side effects at least.

The printk warnings should be easy to fix once everybody uses the same
types - I think we right now have workarounds exactly for 64-bit machines
where w check BITS_PER_LONG and use different formats for them (exactly
because they historically have _not_ had the same types as the 32-bit
machines).

However, if anybody on the list is hacking gcc, the best option really
would be to just allow better control over gcc printf formats. I have
wanted that in user space too at times. And it doesn't matter if it only
happens in new versions of gcc - we can disable the warning altogether for
old gcc's, as long as enough people have the new gcc to catch new
offenders..

(I'd _love_ to be able to add printk modifiers for other common types in
the kernel, like doing the NIPQUAD thing etc inside printk() instead of
having it pollute the callers. All of which has been avoided because of
the hardcoded gcc format warning..)

			Linus

