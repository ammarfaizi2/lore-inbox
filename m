Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVEZUjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVEZUjw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVEZUjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:39:52 -0400
Received: from mail.timesys.com ([65.117.135.102]:22013 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261726AbVEZUjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:39:49 -0400
Message-ID: <429633B1.5060601@timesys.com>
Date: Thu, 26 May 2005 16:38:09 -0400
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
References: <20050525001019.GA18048@nietzsche.lynx.com> <1116981913.19926.58.camel@dhcp153.mvista.com> <20050525005942.GA24893@nietzsche.lynx.com> <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de>
In-Reply-To: <20050526193230.GY86087@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 May 2005 20:33:20.0015 (UTC) FILETIME=[277A71F0:01C56232]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> What I dislike with RT mutexes is that they convert all locks.
> It doesnt make much sense to me to have a complex lock that
> only protects a few lines of code (and a lot of the spinlock
> code is like this). That is just a waste of cycles.

I had brought this up in the dim past in the context
of adaptive mutexes which could via heuristics decide
whether to spin/sleep.

> But I always though we should have a new lock type that is between
> spinlocks and semaphores and is less heavyweight than a semaphore
> (which tends to be quite slow due to its many context switches). Something
> like a spinaphore, although it probably doesnt need full semaphore
> semantics (rarely any code in the kernel uses that anyways). It could
> spin for a short time and then sleep.

Spin if the lock is contended and the owner is active
on a cpu under the assumption the lock owner's average
hold time is less than that of a context switch.  There
are restrictions as once a path holds an adaptive
mutex as a spin lock it cannot acquire another adaptive
mutex as a blocking lock.

> If you drop irq threads then you cannot convert all locks
> anymore or have to add ugly in_interrupt()checks. So any conversion like
> that requires converting locks.

Yes, I was trying to make that point in an earlier thread.

-john


-- 
john.cooper@timesys.com
