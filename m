Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283575AbRLDXEg>; Tue, 4 Dec 2001 18:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283577AbRLDXE0>; Tue, 4 Dec 2001 18:04:26 -0500
Received: from e24.nc.us.ibm.com ([32.97.136.230]:49819 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S283575AbRLDXER>; Tue, 4 Dec 2001 18:04:17 -0500
Date: Tue, 04 Dec 2001 15:02:54 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Lars Brinkhoff <lars.spam@nocrew.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Larry McVoy <lm@bitmover.com>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <2455827301.1007478174@mbligh.des.sequent.com>
In-Reply-To: <85elmbl4i9.fsf@junk.nocrew.org>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > you could educate me about all those 128 processor Linux boxes in the
>> > world and fill in a hole in my knowledge.  I'm listening...
>> There are at least two sets of people working on NUMA machines of that
>> order, as well as the IBM work on smaller NUMA systems.
> 
> Are you NUMA people listening?  What do you think of Larry's ideas?

I presume we're talking about what he calls ccClusters or SMP clusters.
I did a little background reading and found a couple of his old posts.
I'm not an expert on this, though I've done some work in the NUMA area. 
So I'll stick my neck out for people to chop off - I'm not sure I'd agree with 
some of his premises:

> Premise 1: SMP scaling is a bad idea beyond a very small number processors. 
>    The reasoning for this is that when you start out threading a kernel, 
>    it's just a few locks. That quickly evolves into more locks, and 
>    for a short time, there is a 1:1 mapping between each sort of object 
>    in the system (file, file system, device, process, etc) and a lock. 
>    So there can be a lot of locks, but there is only one reader/writer 
>    lock per object instance. This is a pretty nice place to be - it's 
>    understandable, explainable, and maintainable. 
>
>   Then people want more performance. So they thread some more and now 
>    the locks aren't 1:1 to the objects. What a lock covers starts to 
>    become fuzzy. Thinks break down quickly after this because what 
>    happens is that it becomes unclear if you are covered or not and 
>    it's too much work to figure it out, so each time a thing is added 
>    to the kernel, it comes with a lock. Before long, your 10 or 20 
>    locks are 3000 or more like what Solaris has. This is really bad, 
>    it hurts performance in far reaching ways and it is impossible to 
>    undo. 

OK, apart from the fact that there's some leaps of faith here (mostly
due to a lack of detail, I need to go and read some more of his papers),
the obvious objection to this is that just because he's seen it done badly
before, even that it's easy to do badly, it doesn't mean it's impossible to
do it well (it being scalability to many processors).

We will try to make it scale without breaking the low end systems. If we
can, all well and good. If we can't then our patches will get rejected
and we'll all be publicly flogged. Fair enough. And, yes, it's hard. And,
yes, it'll take a while. 

But whilst we gradually make scalability better, NUMA boxes will still
work in the meantime - just not quite as fast. I currently have a NUMA 
box that thinks it an SMP box ... it still works, just not particularly efficiently.
It will get better.

> Premise 3: it is far easier to take a bunch of operating system images 
>    and make them share the parts they need to share (i.e., the page 
>    cache), than to take a single image and pry it apart so that it 
>    runs well on N processors. 

Of course it's easier. But it seems like you're left with much more work to 
reiterate in each application you write to run on this thing. Do you want to 
do the work once in the kernel, or repeatedly in each application? I'd say
it's a damned sight easier to make an application work well on one big
machine than on a cluster.

I like Linus' opinion on the subject, which I'd boil down to "implement
both, see what works". We must have the most massivly parallel 
software engineering team for any OS ever - let's use it ;-)

Martin.

