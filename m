Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbRLGSgc>; Fri, 7 Dec 2001 13:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284308AbRLGSgW>; Fri, 7 Dec 2001 13:36:22 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:62338 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S284298AbRLGSgC>; Fri, 7 Dec 2001 13:36:02 -0500
Message-ID: <3C110C0B.4030102@antefacto.com>
Date: Fri, 07 Dec 2001 18:35:55 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Michael Poole <poole@troilus.org>
CC: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de>	<Pine.LNX.4.33.0112070941330.8465-100000@penguin.transmeta.com>	<20011207185847.A20876@wotan.suse.de> <87wuzyq4ms.fsf@sanosuke.troilus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Poole wrote:

> Andi Kleen <ak@suse.de> writes:
> 
> 
>>>You can be thread-safe without sucking dead baby donkeys through a straw.
>>>I already mentioned two possible ways to fix it so that you have locking
>>>when you need to, and no locking when you don't.
>>>
>>Your proposals sound rather dangerous. They would silently break recompiled
>>threaded programs that need the locking and don't use -D__REENTRANT (most
>>people do not seem to use it). I doubt the possible pain from that is 
>>worth it for speeding up an basically obsolete interface like putc. 
>>
>>i.e. if someone wants speed they definitely shouldn't use putc()
>>
> 
> Threaded programs that need locking and don't define _THREAD_SAFE or
> _REENTRANT or whatever is appropriate are already broken -- they just
> don't know it yet.
> 
> FreeBSD #defines putc and getc to their unlocked versions unless
> _THREAD_SAFE is defined, and people don't seem to think its libc is
> broken.  Many lightly threaded programs, in fact, wouldn't need or
> even want the locked variants to be the default.  One app I've worked
> with only reads and writes any given FILE* from one thread, and I saw
> an 4x speedup by switching to the unlocked variants.

This breaks for the case discussed @
http://sources.redhat.com/ml/bug-glibc/2001-11/msg00079.html
I.E. if you have a multithreaded lib being linked by
single threaded apps (Note multithreaded lib, not just a
threadsafe lib (I.E. the lib calls pthread_create())).

Padraig.

