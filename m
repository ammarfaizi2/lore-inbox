Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275493AbRIZTEC>; Wed, 26 Sep 2001 15:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275497AbRIZTDw>; Wed, 26 Sep 2001 15:03:52 -0400
Received: from bacon.van.m-l.org ([208.223.154.200]:35459 "EHLO
	bacon.van.m-l.org") by vger.kernel.org with ESMTP
	id <S275493AbRIZTDj>; Wed, 26 Sep 2001 15:03:39 -0400
Date: Wed, 26 Sep 2001 15:04:06 -0400 (EDT)
From: George Greer <greerga@m-l.org>
X-X-Sender: <greerga@bacon.van.m-l.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <Pine.LNX.4.33.0109261123380.8558-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0109261501010.1519-100000@bacon.van.m-l.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Linus Torvalds wrote:

>
>On Wed, 26 Sep 2001, Dave Jones wrote:
>> On Wed, 26 Sep 2001, Alan Cox wrote:
>>
>> > VIA Cyrix CIII (original generation 0.18u)
>> >
>> > nothing: 28 cycles
>> > locked add: 29 cycles
>> > cpuid: 72 cycles
>>
>> Interesting. From a newer C3..
>>
>> nothing: 30 cycles
>> locked add: 31 cycles
>> cpuid: 79 cycles
>>
>> Only slightly worse, but I'd not expected this.
>
>That difference can easily be explained by the compiler and options.
>
>You should use "gcc -O2" at least, in order to avoid having gcc do
>unnecessary spills to memory in between the timings. And there may be some
>versions of gcc that en dup spilling even then.

Nice big difference in 'locked add' seen here.

gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)
2x Pentium 233/MMX

-O0				-O2
nothing: 15 cycles		nothing: 14 cycles
locked add: 60 cycles		locked add: 32 cycles
cpuid: 33 cycles		cpuid: 32 cycles


gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)
2x Pentium 133

-O0				-O2
nothing: 14 cycles		nothing: 13 cycles
locked add: 76 cycles		locked add: 25 cycles
cpuid: 31 cycles		cpuid: 30 cycles

-- 
George Greer, greerga@m-l.org | Genius may have its limitations, but stupidity
http://www.m-l.org/~greerga/  | is not thus handicapped. -- Elbert Hubbard

