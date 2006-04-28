Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWD1GIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWD1GIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 02:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWD1GIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 02:08:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:46235 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965195AbWD1GIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 02:08:46 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] [3/4] i386: Fix overflow in e820_all_mapped
Date: Fri, 28 Apr 2006 08:08:15 +0200
User-Agent: KMail/1.9.1
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jbeulich@novell.com
References: <4451A80E.mailNZX1XN4A8@suse.de> <Pine.LNX.4.64.0604272237430.3701@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604272237430.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604280808.16256.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 07:39, Linus Torvalds wrote:
> 
> On Fri, 28 Apr 2006, Andi Kleen wrote:
> > 
> > The 32bit version of e820_all_mapped() needs to use u64 to avoid
> > overflows on PAE systems.  Pointed out by Jan Beulich
> 
> I don't think that's true.
> 
> It can't be called with 64-bit arguments anyway. If the base address 
> doesn't fit in 32-bit, we'd be screwed in other places, afaik.

To quote Jan's original description (should have put that in)
I think it's needed.

-Andi

>>>

>> It would seem to me that using 'unsigned long' for start and end is inappropriate on 32bits; at least start should
be
>> 'unsigned long long' as it gets updated from ei->addr + ei->size, which may (truncated to 32 bits) happen to be
zero.
>
>the current user has it 32 bit for sure; once another user appears we certainly can fix this...

The effect is not on the current user's parameter passing, but in the result the function may produce. If, say, for the
PCI mmconfig and BIOS space, there is a (reserved) entry starting at E0000000 and being 20000000 in size, then as far as
I can tell the function will return zero (rather than one).

<<<
