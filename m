Return-Path: <linux-kernel-owner+willy=40w.ods.org-S290020AbUKAX3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S290020AbUKAX3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267155AbUKAX3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:29:10 -0500
Received: from alog0023.analogic.com ([208.224.220.38]:7552 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S376349AbUKAWYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:24:23 -0500
Date: Mon, 1 Nov 2004 17:22:27 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0411011311520.8483@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.61.0411011718001.26520@chaos.analogic.com>
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
 <Pine.LNX.4.61.0410312024150.19538@chaos.analogic.com>
 <Pine.LNX.4.61.0411011219200.8483@twinlark.arctic.org>
 <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com>
 <Pine.LNX.4.61.0411011311520.8483@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, dean gaudet wrote:

> On Mon, 1 Nov 2004, linux-os wrote:
>
>> On Mon, 1 Nov 2004, dean gaudet wrote:
>>
>>> On Sun, 31 Oct 2004, linux-os wrote:
>>>
>>>> Timer overhead = 88 CPU clocks
>>>> push 3, pop 3 = 12 CPU clocks
>>>> push 3, pop 2 = 12 CPU clocks
>>>> push 3, pop 1 = 12 CPU clocks
>>>> push 3, pop none using ADD = 8 CPU clocks
>>>> push 3, pop none using LEA = 8 CPU clocks
>>>> push 3, pop into same register = 12 CPU clocks
>>>
>>> your microbenchmark makes assumptions about rdtsc which haven't been valid
>>> since the days of the 486.  rdtsc has serializing aspects and overhead that
>>> you can't just eliminate by running it in a tight loop and subtracting out
>>> that "overhead".
>>>
>>
>> Wrong.
>
> if you were correct then i should be able to measure 1 cycle differences
> in sequences such as the following:
[SNIPPED...]

Who said? The resolution isn't even specified. Experimental
results with several different processors seem to show that
the resolution is about 4 cycles.

Script started on Mon 01 Nov 2004 04:48:04 PM EST
# ./tester
Timer overhead = 88 CPU clocks


1 nop = 4 CPU clocks
2 nops = 4 CPU clocks
3 nops = 4 CPU clocks
4 nops = 8 CPU clocks
5 nops = 8 CPU clocks
6 nops = 8 CPU clocks
7 nops = 8 CPU clocks
8 nops = 12 CPU clocks
# exit
Script done on Mon 01 Nov 2004 04:48:34 PM EST

Assembly :


nop8:	nop
nop7:	nop
nop6:	nop
nop5:	nop
nop4:	nop
nop3:	nop
nop2:	nop
nop1:	nop
 	ret

.global	nop1
.global	nop2
.global	nop3
.global	nop4
.global	nop5
.global	nop6
.global	nop7
.global	nop8


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
