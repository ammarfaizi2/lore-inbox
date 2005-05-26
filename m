Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVEZXpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVEZXpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 19:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVEZXpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 19:45:54 -0400
Received: from mail.timesys.com ([65.117.135.102]:51926 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261851AbVEZXpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 19:45:47 -0400
Message-ID: <42965F43.2010904@timesys.com>
Date: Thu, 26 May 2005 19:44:03 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Sven-Thorsten Dietrich <sdietrich@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT patch acceptance
References: <20050525005942.GA24893@nietzsche.lynx.com> <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de>
In-Reply-To: <20050526202747.GB86087@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 May 2005 23:39:06.0140 (UTC) FILETIME=[1B1625C0:01C5624C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I really dislike the idea of interrupt threads. It seems totally
> wrong to me to make such a fundamental operation as an interrupt
> much slower.  If really any interrupts take too long they should
> move to workqueues instead and be preempted there.

That is the basic idea but is being applied by default.
There is nothing more happening here than pushing the limits
of the design.  Certainly there will be some inefficiencies
introduced in the process where some interrupt payload
would have been more efficiently executed in exception
context.  If it makes sense on a system-wide basis to
do so, it can be reverted on a case-by-case basis.  This is
after all experimental code.

Yet there are other factors which influence the decision
of a running context for the interrupt payload.  Depending
on how other code in the system best synchronizes with the
payload, minimizing interrupt disable time in either
payload code and/or coordinating code, etc..

> Most spinlocks only protect small code parts. Those that protect
> larger codes can probably use optionally some different lock.
> 
> But dont attack it with "one size fits all" locking please.

This another case of a sweeping change to the default
behavior.  Again an experiment to push the limits of the
given design.  Clearly we aren't buying anything to trade off
a spinlock protecting the update of a single pointer with a
blocking lock and associated context switching.  But it does
demonstrate code previously relying on synchronization via
polled lock faired remarkably well with preemptive blocking
mutexes.

-john

-- 
john.cooper@timesys.com
