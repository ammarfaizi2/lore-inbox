Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUKABg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUKABg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 20:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUKABg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 20:36:27 -0500
Received: from alog0114.analogic.com ([208.224.220.129]:10112 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261715AbUKABf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 20:35:27 -0500
Date: Sun, 31 Oct 2004 20:31:40 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.58.0410291209170.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0410312024150.19538@chaos.analogic.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com>
 <Pine.LNX.4.58.0410291209170.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-666545155-1099272700=:19538"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678434306-666545155-1099272700=:19538
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

On Fri, 29 Oct 2004, Linus Torvalds wrote:

>
>
> On Fri, 29 Oct 2004, linux-os wrote:
>>
>> Linus, there is no way in hell that you are going to move
>> a value from memory into a register (pop ecx) faster than
>> you are going to do anything to the stack-pointer or
>> any other register.
>
> Sorry, but you're wrong.

I am not wrong.

I don't understand anything about your theoretical CPU
with the magic stack engine. Anything I can get my
hands on functions exactly as I described and exactly
as would be expected. We work with real hardware here
and I have to test it as part of my job.

And, FYI, I spend all my working time trying to get the
last iota of performance out of ix86 CPUS. Since I can
only read publicly available documentation, I have
to test code in actual operation.

The attached file shows that the Intel Pentium 4 runs
exactly as I described. Further, there is no difference in
the CPU clocks used when adding a constant to the stack-
pointer or using LEA.

It also shows that poping stack-data into the same register
twice, as you suggested, takes the same time as using a
different register.


Timer overhead = 88 CPU clocks
push 3, pop 3 = 12 CPU clocks
push 3, pop 2 = 12 CPU clocks
push 3, pop 1 = 12 CPU clocks
push 3, pop none using ADD = 8 CPU clocks
push 3, pop none using LEA = 8 CPU clocks
push 3, pop into same register = 12 CPU clocks

The code uses a separate assembly-language file so that
the 'C' compiler can't optimize-away what I am measuring.
It also saves and uses the shortest number of CPU cycles
so the code doesn't have to execute with the interrupts
OFF to get a stable reading.

>
> Learn about modern CPU's some day, and realize that cached accesses are
> fast, and pipeline stalls are relatively much more expensive.
>

That's what I do, and that's what I teach.

> Now, if it was uncached, you'd have a point.
>
> Also think about why
>
> 	call xxx
> 	jmp yy
>
> is often much faster than
>
> 	push $yy
> 	jmp xxx
>
> and other small interesting facts about how CPU's actually work these
> days.
>
> 		Linus
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
--1678434306-666545155-1099272700=:19538
Content-Type: APPLICATION/x-gzip; name="test-sp.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0410312031400.19538@chaos.analogic.com>
Content-Description: 
Content-Disposition: attachment; filename="test-sp.tar.gz"

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
MMu/HnKCxAB4AAA=

--1678434306-666545155-1099272700=:19538--
