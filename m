Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263885AbUFBTk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUFBTk0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUFBTk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:40:26 -0400
Received: from mail.tmr.com ([216.238.38.203]:24588 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263885AbUFBTkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:40:20 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 4k stacks in 2.6
Date: Wed, 02 Jun 2004 15:40:37 -0400
Organization: TMR Associates, Inc
Message-ID: <c9la7t$ku4$1@gatekeeper.tmr.com>
References: <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040527124551.GA12194@elte.hu> <20040527135930.GC3889@dualathlon.random> <20040527140322.GA11966@devserv.devel.redhat.com> <20040527144237.GD3889@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1086204989 21444 192.168.12.100 (2 Jun 2004 19:36:29 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040527144237.GD3889@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Thu, May 27, 2004 at 04:03:22PM +0200, Arjan van de Ven wrote:
> 
>>In theory you are absolutely right, problem is the current macro..... it's
>>SO much easier to have one stacksize everywhere (and cheaper too) for
>>this... (and it hasn't been a problem so far, esp since the softirq's have
> 
> 
> I see the problem, but then why don't we wait to implement it right, to
> allow 8k irq-stacks before merging into mainline?
> 
> grep for "~s 4k" (i.e. the word "4[kK]" in the subject) on l-k and
> you'll see there's more than just nvidia. one user reported not being
> able to boot at all with 4k stacks since 2.6.6 doesn't have a stack
> overflow in the oops, so I hope he tested w/ and w/o 4KSTACKS option
> enabled to be able to claim what broke his machine is the 4KSTACKS
> option. (his oops doesn't reveal a stack overflow, the thread_info is at
> 0xf000 and the esp is at 0xffxx)
> 
> Making it a config option, is a sort of proof that you agree it can
> break something, or you wouldn't make it a config option in the first
> place. What's the point of making it a configuration option if it cannot
> break anything and if it's not risky? Making it a config option is not
> good, because then some developer may develop leaving 4KSTACKS disabled,
> and then his kernel code might break on the users with 4KSTACKS enabled
> (it's not much different from PREEMPT).  Amittedly code that overflows
> 4k is likely to be not legitimate but not all code is good (the most
> common error is to allocate big strutures locally on the stack with
> local vars), and if developers are able to notice the overflow on their
> own testing it's better.

We have lots of options which may cause problems but are useful for 
special situations, why is this one any different? The only actual 
benefit I've seen quoted for 4k stack is that it improves fork 
performance if memory is so fragmented that there is no 8k block left. 
And my first thought on hearing that was if that's common the VM should 
be investigated. This is a stable kernel, and breaking even such an 
abomination as a binary-only driver for the sake of whoever has this 
vastly fragmented memory seems to be the anthesis of stable.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
