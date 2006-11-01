Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946686AbWKAINK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946686AbWKAINK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946695AbWKAINK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:13:10 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:62346 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946686AbWKAINJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:13:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=0lJWIWvBpwrVxqAnC86Urixxa/kYHCcbHrc0BPJ7H9ACUXIHt20WtAOem+W2uVNoJvnK3mRAIBpgZUKeqX3kvzvEvE2ArOdleTSVqst8+aUbcqJFgQx84O1jL6LUze34FZc0IY1PVpvWWhUVkiZB0uDY/p9c4iMQyfauUFjmJyQ=  ;
Message-ID: <45485713.7070005@yahoo.com.au>
Date: Wed, 01 Nov 2006 19:13:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Borislav Petkov <petkov@math.uni-muenster.de>,
       David Rientjes <rientjes@cs.washington.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched.c : correct comment for this_rq_lock() routine
References: <Pine.LNX.4.64.0610301600550.12811@localhost.localdomain> <Pine.LNX.4.64N.0610301308290.17544@attu2.cs.washington.edu> <Pine.LNX.4.64.0610301623360.13169@localhost.localdomain> <20061031153021.GA14505@gollum.tnic> <Pine.LNX.4.64.0610311250500.22528@localhost.localdomain> <4547D23A.3090007@yahoo.com.au> <Pine.LNX.4.64.0611010252460.28051@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0611010252460.28051@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> On Wed, 1 Nov 2006, Nick Piggin wrote:
> 
> 
>>Robert P. J. Day wrote:
>>
>>
>>>example, i was just poking around the source for the various
>>>"atomic.h" files and noticed a couple possible cleanups:
>>>
>>> 1) make sure *everyone* uses "volatile" in the typedef struct (which
>>>	i actually submitted recently)
>>>
>>
>>I don't see why. There is nothing in atomic (eg. atomic_read) that
>>says there must be a compiler barrier around the operation.
>>
>>Have you checked that the architecture implementation actually needs
>>the volatile where you've added it?
> 
> 
> as just one example, you can read in include/asm-alpha/atomic.h:
> 
> /*
>  * Counter is volatile to make sure gcc doesn't try to be clever
>  * and move things around on us. We need to use _exactly_ the address
>  * the user gave us, not some alias that contains the same information.
>  */

asm-alpha has volatile.

> 
> now it may be that *some* architectures don't specifically require a
> volatile counter but, AFAIK, it doesn't actually hurt if it isn't
> necessary.  OTOH, if it isn't necessary *at all* for *any*
> architecture, then that storage class should be *removed* in its
> entirety.

Then given that architecture specific code is private to that architecture,
the logical conclusion is that if it isn't required by *an* architectures,
then it should be removed as well.

IOW, you can't assume that because one arch does something one way, that
another has the same restrictions.

> in any event, all this is is another example of what appears to be
> niggling and unnecessary differences between arch-specific header
> files that could easily be turned into a single, standard definition
> that would work for everyone with very little effort (and perhaps some
> day be included from a single generic header file to avoid all that
> duplication in the first place).

So if you want to do that, then I'd prefer that you instead go through all
arch headers and figure out where the volatile is needed, and why, and
document it.

For example FRV, at a glance, doesn't need volatile AFAIKS. Probably neither
do a lot of architectures, given that atomic_read/set/add/etc. need not
imply compiler or memory barriers (I think).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
