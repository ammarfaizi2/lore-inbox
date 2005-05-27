Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVE0GMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVE0GMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 02:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVE0GMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 02:12:51 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:18323 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261887AbVE0GMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 02:12:23 -0400
Message-ID: <4296ADE9.50805@yahoo.com.au>
Date: Fri, 27 May 2005 15:19:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Sven-Thorsten Dietrich <sdietrich@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       dwalker@mvista.com, bhuey@lnxw.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050525005942.GA24893@nietzsche.lynx.com> <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de>
In-Reply-To: <20050526202747.GB86087@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>>What I dislike with RT mutexes is that they convert all locks.
>>>It doesnt make much sense to me to have a complex lock that
>>>only protects a few lines of code (and a lot of the spinlock
>>>code is like this). That is just a waste of cycles.
>>>
>>
>>It is NOT just a few lines of code. Millisecond latencies on high-
>>powered CPU systems means more code than is probably required to send a
>>rocket 'round the moon and back.
> 
> 
> Most spinlocks only protect small code parts. Those that protect
> larger codes can probably use optionally some different lock.
> 
> But dont attack it with "one size fits all" locking please.
> 

I have a question about what sort of RT guarantees people might
want. Forget specific patches or implementations for a minute.
I'm genuinely curious, as an uneducated bystander - I want to get
a bit more background about this.


Presumably your RT tasks are going to want to do some kind of
*real* work somewhere along the line - so how is that work provided
guarantees?

For example, suppose you have preemptible everything, and priority
inheritance and that's all nice. But the actual time in which
some thread holds a lock is time that no other thread can take
that lock either, regardless of its priority.

So in that sense, if you do hard RT in the Linux kernel, it surely
is always going to be some subset of operations, dependant on
exact locking implementation, other tasks running and resource usage,
right?

Tasklist lock might be a good example off the top of my head - so
you may be able to send a signal to another process with deterministic
latency, however that latency might look something like: x + nrproc*y

It appears to me (uneducated bystander, remember) that a nanokernel
running a small hard-rt kernel and Linux together might be "better"
for people that want real realtime.

Just from the point of view of making the RT kernel as small and easy
to verify as possible, and not having to provide for general purpose
non-RT tasks. Then you also get the benefit of not having to make the
general purpose Linux support hard real time.

For example, if your RT kernel had something like a tasklist lock, it
may have an upper limit on the number of processes, or put in restart
points where lower priority processes drop the lock and restart what
they were doing if a high prio process one comes along - obviously
neither solution would fly for the Linux tasklist lock.

Or have I missed something completely? You RT guys have thought about
it - so what are some pros of the Linux-RT patch and/or cons of the
nanokernel approach, please?

[ And again, please don't say why Ingo's RT patch should go in, I'm
   not talking about any patch, any merging of patches or even that
   some hypothetical patch *shouldn't* go in - even if it does have
   above problem ;) ]

Thanks very much,
Nick
Send instant messages to your online friends http://au.messenger.yahoo.com 
