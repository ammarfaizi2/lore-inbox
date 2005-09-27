Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVI0TDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVI0TDx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 15:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVI0TDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 15:03:52 -0400
Received: from mail-lon.bigfish.com ([213.206.137.197]:38528 "EHLO
	mail7-lon-R.bigfish.com") by vger.kernel.org with ESMTP
	id S965048AbVI0TDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 15:03:51 -0400
X-BigFish: V
Message-ID: <4339978F.2010609@am.sony.com>
Date: Tue, 27 Sep 2005 12:03:43 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
References: <Pine.LNX.4.61.0509271848040.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0509271848040.3728@scrub.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> On Sun, 25 Sep 2005, Thomas Gleixner wrote:
>> Roman Zippel wrote:
>>> You know very well, that the conversion back to timespec
>>> is the killer in your calculation. You graciously
>>> decide that the "vast majority" doesn't
>>> want to read the timer, how did you get to that
>>> conclusion?
>>
>> I graciously put instrumentation into _all_ the
>> relevant syscalls on a desktop and a server machine.
>> The result is that less than 1% of the
>> calls provide the read back variable.
> 
> That still means it is used and if an application
> actually depends on it, it would be penalized by
> your implementation. These timers may open up new
> application (in kernel or user space), where
> this conversion may be needed, so _only_ looking
> at the current numbers is a bit misleading.

Oh good heavens!  One can always point to real or
hypothetical cases where a change like this
will result in worse performance.  Will you only
be satisfied if there is provably NO performance
degradation for ANY app on ANY platform?  Even
if the code is easier to maintain, and allows
for improvements in functionality and equal or
better performance for the majority of apps.
and platforms?

We're talking about a tradeoff here, and I,
of all people, should be worried about the
possible impact on low-end embedded hardware.
However, having seen some of the problems with
the current timer system in the kernel, I'm in
favor of looking at some abstraction improvements.

Unless I missed something, ktimers has not been
recommended for mainlining yet.  I suspect (without
having measured it myself yet) that the
core abstraction that it proposes (timers
vs. timeouts) is an important one for improving
the kernel timing system.

Personally, I'd like to see it go into
-mm or some other experimental tree, to give
it a proper shakedown.  If some nasty corner
cases show up, then let them show up under testing
rather than via conjecture.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

