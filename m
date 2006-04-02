Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWDBCmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWDBCmx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 21:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWDBCmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 21:42:53 -0500
Received: from smtpout.mac.com ([17.250.248.45]:30944 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751647AbWDBCmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 21:42:52 -0500
In-Reply-To: <20060401162213.dc68d120.rdunlap@xenotime.net>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <1143376351.3064.9.camel@laptopd505.fenrus.org> <A6491D09-3BCF-4742-A367-DCE717898446@mac.com> <20060329222640.GA2755@ucw.cz> <20060401162213.dc68d120.rdunlap@xenotime.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EB70C0D0-4961-4F78-B245-69C962F8B52E@mac.com>
Cc: Pavel Machek <pavel@ucw.cz>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header infrastructure
Date: Sat, 1 Apr 2006 21:42:14 -0500
To: "Randy.Dunlap" <rdunlap@xenotime.net>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 1, 2006, at 19:22:13, Randy.Dunlap wrote:
> On Wed, 29 Mar 2006 22:26:41 +0000 Pavel Machek wrote:
>>> I plan to add a lot of other definitions to this file later on.   
>>> For  example different architectures have
>>> different notions of what a  __kernel_ino_t is (unsigned int  
>>> versus unsigned long).  I may rename  this file as types.h, but  
>>> from looking through the code I figure I'll have enough general  
>>> purpose declarations about "This architecture has  blah" that a  
>>> separate stddef.h file will be worth it.
>>>
>>>> (and... why do you prefix these with _KABI? that's a mistake  
>>>> imo.  Don't bother with that. Really. Either these need  
>>>> exporting to  userspace, but then either use __ as prefix or  
>>>> don't use a prefix.  But KABI.. No.)
>>>
>>> According to the various standards all symbols beginning with __  
>>> are  reserved for "The Implementation", including the compiler,  
>>> the  standard library, the kernel, etc.  In order to avoid  
>>> clashing with  any/all of those, I picked the __KABI_ and __kabi_  
>>> prefixes for  uniqueness.  In theory I could just use __, but  
>>> there are problems  with that too.  For example, note how the  
>>> current compiler.h files  redefine __always_inline to mean  
>>> something kinda different.  The GCC manual says we should be able  
>>> to write this:
>>
>> __KABI_ everywhere will just make your headers totally  
>> unreadable.  Please don't do that.
>
> Ack, I agree.

Let me reiterate two facts:

(1)  The various C standards state that the implementation should  
restrict itself to symbols prefixed with "__", everything else is  
reserved for user code (Including symbols prefixed with a single  
underscore).
(2)  GCC predefines a large collection of symbols, macros, and  
functions for its own use, and this set is not constant (just look at  
the number of new __-prefixed symbols added between GCC 3 and 4.  In  
addition, we're not just compiling this code under GCC, but people  
will also be using it (hopefully unmodified) under tiny-cc, intel-cc,  
PGI, PathScale, Lahey, ARM Ltd, lcc, and possibly others.  It  
probably does not need to be stated that for something as userspace- 
sensitive as the KABI headers we should not risk colliding with  
predefined builtins in any of those compilers.

So my question to the list is this:
Can you come up with any way other than using a "__kabi_" prefix to  
reasonably avoid namespace collisions with that large list of  
compilers?  If you have some way, I'd be interested to hear it, but  
as a number of those compilers are commercial I'd have no way to test  
on them (and I suspect most people on this list would not either).

Of course, if the general consensus is that supporting non-GCC is not  
important, then that's ok with me.  Judging from the number of  
negative responses my earlier "[OT] Non-GCC compilers used for linux  
userspace" got, however, that doesn't seem to be the case.

Thanks for the advice!

Cheers,
Kyle Moffett

