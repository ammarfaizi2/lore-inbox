Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbUKAWqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbUKAWqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274748AbUKAWpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:45:12 -0500
Received: from alog0687.analogic.com ([208.224.223.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S316732AbUKAUzS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:55:18 -0500
Date: Mon, 1 Nov 2004 15:52:21 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0411011219200.8483@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, dean gaudet wrote:

> On Sun, 31 Oct 2004, linux-os wrote:
>
>> Timer overhead = 88 CPU clocks
>> push 3, pop 3 = 12 CPU clocks
>> push 3, pop 2 = 12 CPU clocks
>> push 3, pop 1 = 12 CPU clocks
>> push 3, pop none using ADD = 8 CPU clocks
>> push 3, pop none using LEA = 8 CPU clocks
>> push 3, pop into same register = 12 CPU clocks
>
> your microbenchmark makes assumptions about rdtsc which haven't been valid 
> since the days of the 486.  rdtsc has serializing aspects and overhead that 
> you can't just eliminate by running it in a tight loop and subtracting out 
> that "overhead".
>

Wrong.

(1)  The '486 didn't have the rdtsc instruction.
(2)  There are no 'serializing' or other black-magic aspects of
using the internal cycle-counter. That's exactly how you you
can benchmark the execution time of accessible code sequences.

> you have to run your inner loops at least a few thousand of times between 
> rdtsc invocations and divide it out to find out the average cost in order to 
> eliminate the problems associated with rdtsc.
>
> -dean
>

You never average the cycle-time. The cycle-time is absolute.
You need to remove the affect of interrupts when you measure
performance so you need to sample a few times and save the
lowest number. That's the number obtained during the testing interval,
was not interrupted.

The provided code allows you to experiment. You can set the
TRIES count to 1. You will find that the results are noisy if
you are connected to an active network. Good results can be
obtained with it set to 4 if your computer is not being blasted
with lots of broadcast packets from M$ servers.

>

Of course you are not really interested in learning anything
about this are you?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
