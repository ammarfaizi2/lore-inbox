Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUKAO2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUKAO2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266468AbUKAO1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:27:08 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:24193 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265046AbUKAOYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:24:06 -0500
Message-ID: <418646FC.2040608@yahoo.com.au>
Date: Tue, 02 Nov 2004 01:23:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Ingo Molnar <mingo@elte.hu>, Pavel Machek <pavel@ucw.cz>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][plugsched 0/28] Pluggable cpu scheduler framework
References: <4183A602.7090403@kolivas.org> <20041031233313.GB6909@elf.ucw.cz> <20041101114124.GA31458@elte.hu> <41863AF4.1040905@kolivas.org>
In-Reply-To: <41863AF4.1040905@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Ingo Molnar wrote:
> 
>> my main worry with this approach is not really overhead but the impact
>> on scheduler development. 
> 
> 
>> no problem even under the current model, and it has happened before. We
>> made the scheduler itself easily 'rip-out-able' in 2.6 by decreasing the
>> junction points between the scheduler and the rest of the system. Also,
>> the current scheduler is no way cast into stone, we could easily end up
>> having a different interactivity code within the scheduler, as a result
>> of the various 'get rid of the two arrays' efforts currently underway.
> 
> 
> Do you honestly think with the current "2.6 forever" development process 
> that this is likely, even possible any more?
> 

That's a nutty problem... but suppose 2.7 opened tomorrow, how would
you justify putting in a new scheduler even then? And how would you
get enough testing to ensure a repeat of early 2.6 didn't happen again?

I'd be very happy if we could figure out the answer to that question,
but I'm afraid pluggable schedulers probably isn't it (unfortunately).

> Given that fact, it means the current scheduler policy mechanism is 
> effectively set in stone. Do you think we can polish the current 
> scheduler enough to be, if not perfect, good enough for _every_ situation?
> 

Specialised users always have and always will do specialised
modifications, that's no problem. But as much as I hate to say it
(it's a good thing, I'd just like to be able to get nicksched in),
it seems that the current scheduler *is* actually good enough for
a general purpose operating system. At least the lack of complaints
seems to indicate that.

My proposal to the "how to get a new scheduler in" question is a set
of pretty comprehensive controlled (blind of course), subjective tests
with proper statistical analysis, to determine best behaviour... And
I'm only half joking :(

> Noone said that if we have a plugsched infrastructure that we should 
> instantly accept any scheduler.
> 

But so long as you don't have a compelling argument to _replace_
the current scheduler, people who want to use other ones may as
well just patch them in. By having multiple schedulers however,
you don't IMO get too many benefits and a lot of downsides that
Ingo pointed out.

That said, if you were able to get a unanimous "yes" from Linus,
Andrew, and Ingo then I wouldn't complain too loudly...
