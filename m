Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVE0Mn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVE0Mn2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 08:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVE0Mn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:43:28 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:36230 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262447AbVE0MnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:43:16 -0400
Message-ID: <429715DE.6030008@yahoo.com.au>
Date: Fri, 27 May 2005 22:43:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com>
In-Reply-To: <20050527120812.GA375@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> On Fri, May 27, 2005 at 03:19:37PM +1000, Nick Piggin wrote:
>>It appears to me (uneducated bystander, remember) that a nanokernel
>>running a small hard-rt kernel and Linux together might be "better"
>>for people that want real realtime.
> 
> 
> I answered this already in this thread with the digression about RTAI.
> I believe that it is a clear explanation but it's a bit out of the box
> so to speak since it's looking towards more sophisticated uses of this
> patch from an overall software design point of view.
> 

Yes I did see that post of yours, but I didn't really understand the
explaination. (I hope I don't quote you out of context, please correct
me if so).

I don't see why you would have problems crossing kernel "concurrency
domains" with the nanokernel approach. Presumably your hard-RT guest
kernel or its tasks aren't going to go to the Linux image in order
to satisfy a hard RT request.

Also, you said "I have to think about things like dcache_lock, route
tables, access to various IO system like SCSI and TCP/IP, etc...",
but at first glance, those locks and structures are exactly why you
wouldn't want to do hard-rt work along side general purpose work in
the Linux kernel.

And quite how they would interfere with the hard-rt guest, you didn't
make clear.

"A single system image makes access to this direct unlike dual kernel
system where you need some kind of communication coupling. Resource
access is direct."

... but you still need the locks, right?

> 
>>Just from the point of view of making the RT kernel as small and easy
>>to verify as possible, and not having to provide for general purpose
>>non-RT tasks. Then you also get the benefit of not having to make the
>>general purpose Linux support hard real time.
> 
> 
> There's really no good reason why this kernel can't get the same latency
> as a nanokernel. The scheduler paths are riddled with SMP rebalancing
> stuff and the like which contributes to overall system latency. Remove
> those things and replace it with things like direct CPU pining and you'll
> start seeing those numbers collapse. There are also TLB issues, but there
> are many way of reducing and stripping down this kernel to reach so called
> nanokernel times. Nanokernel times are overidealized IMO. It's not
> because of design necessarily, but because of implementation issues that
> add more latency to the deterministic latency time constant.
> 

Is this one reason why a nanokernel is better, then? So you wouldn't
have to worry about the SMP rebalancing, and TLB issues, and everything
else in your Linux kernel?

> Just a thread wake operation under an 2x SMP box flattens the latency
> histogram from a 8 usec spike to a 10-22 usec spread (800mhz p3 2x)
> roughly. There are many more spots that contribute to latency that can
> be made static or precomputed in some way.
> 
> RT priority thread rebalancing and IPI send off adds to this rescheduling
> latency as well.
>  
> 
>>For example, if your RT kernel had something like a tasklist lock, it
>>may have an upper limit on the number of processes, or put in restart
>>points where lower priority processes drop the lock and restart what
>>they were doing if a high prio process one comes along - obviously
>>neither solution would fly for the Linux tasklist lock.
>>
>>Or have I missed something completely? You RT guys have thought about
>>it - so what are some pros of the Linux-RT patch and/or cons of the
>>nanokernel approach, please?
> 
> 
> Again, I think I answered this in the RTAI discussion in this thread.
> If you can groke my lingo then it should lay a kind of design track
> where this kind of kernel design can be easier and more flexible to
> work with in regards to future kernel subsystem alterations.
>  

I'm not sure if you exactly answered my concerns in that thread
(or I didn't understand). It would be great if you could help me
out a bit here, because I feel I must be missing something here.

> 
>>[ And again, please don't say why Ingo's RT patch should go in, I'm
>>  not talking about any patch, any merging of patches or even that
>>  some hypothetical patch *shouldn't* go in - even if it does have
>>  above problem ;) ]
> 
> 
> Shut up :)
>  

Well, so long as everyone's on the same page, I'll stop with my
silly disclaimers ;)

Nick
Send instant messages to your online friends http://au.messenger.yahoo.com 
