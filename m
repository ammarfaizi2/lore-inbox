Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVE3Nq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVE3Nq0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 09:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVE3Nq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 09:46:26 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:27097 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261600AbVE3Noj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 09:44:39 -0400
Message-ID: <429B1898.8040805@andrew.cmu.edu>
Date: Mon, 30 May 2005 09:43:52 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au>
In-Reply-To: <429ADEDD.4020805@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Sorry no, nobody answered me. What I did realize was that there
> was a lot of noise nothing really got resolved.

I believe you mean you don't believe any answer given so far.  You could 
easily be correct, and us wrong, but it's not that nobody answered you. 
  Why not start by saying you disagree with us rather than pretending we 
never said anything?

>> - in general it's far easier to write one process than two 
>> communicating processes.
> 
> I reject the vague "complexity" argument. If your application
> is not fairly clear on what operations need to happen in a
> deterministic time and what aren't, or if you aren't easily able
> to get 2 communicating processes working, then I contend that you
> shouldn't be writing a realtime application.

There is nothing vague about this.  I have written distributed and 
non-distributed control algorithms for quite a while now.  I know how to 
judge the complexity of a design for that type of system.  You can claim 
that I cannot judge such complexity a priori, but then I could equally 
claim that you cannot judge the complexity of a kernel modification.  In 
that case we get nowhere.  Instead let's respect each others' area of 
expertise, shall we?

> What's more, you don't even need to have 2 communicating processes,
> you could quite possibly do everything in the realtime kernel if
> you are talking some simple control system and driver.

In the real world things get a bit more complicated than a simple PID 
controller.  There is a whole progression between soft-realtime programs 
that need lots of kernel services, and hard realtime apps that might 
need only a single device.  It's hard to service a middle ground with a 
completely different approach to the two ends of the problem space.

> Note that I specifically reject the *vague* complexity argument,
> because if you have a *real* one (ie. we need functionality
> equivalent to this sequence of system calls executed in a
> deterministic time - the nanokernel approach sucks because [...])
> then I'm quite willing to accept it.

Adding support to the nanokernel for all the APIs a user may need 
strikes me as more code than the RT patch in question, which outside of 
all the locks it changes is pretty compact.  Especially important is the 
fact that it mainly relies on SMP-safeness to achieve RT performance.

> The fact is, nobody seems to know quite what kind of deterministic
> functionality they want (and please, let's not continue the jokes
> about X11 and XFS, etc.). Which really surprises me.

It's more like the amount of functionality that can be provided with RT 
defines what applications are possible and what they can do.  If Ingo 
asks for a usage case or similar information, I'll gladly provide it. 
Since the patch in question doesn't actually need that information to 
work, he hasn't asked.  Your responses throughout this thread have led 
me to believe any detailed information I take the time to collect will 
be summarily dismissed in a few seconds, so I won't bother.

> I will give *you* a complexity argument. Making the Linux kernel
> hard realtime is slightly more complex than writing an app that
> consists of 2 communicating processes.

Nobody asked for guaranteed hard realtime yet.  Right now we're 
discussing a particular patch that achieves measurably good (but not 
guaranteed) RT performance.  It's a question of supporting that patch, 
or not, and hard realtime has nothing to do with it right now.  In fact, 
an attempt was made to just focus in on IRQ threading to avoid a 
flame-fest.  So your complexity argument about a mythical future 
modification of this patch not even under discussion is vague... more 
vague in fact, than my example above that you rejected for being "too 
vague".  If you dislike the approach in the RT patch, say "the RT 
patch", and don't invoke assumed future difficulties from "hard 
realtime" which is not currently under discussion.

Let's entertain the complexity argument anyway though.  Writing a good 
shared library is more complicated than adding the support you need to a 
particular application.  Why do we have shared libraries then?  That's 
because there's more than *one* application.  So its better to ask if 
supporting realtime in the kernel is easier than hundreds of developers 
writing split-kernel applications for the next several years.  For the 
RT patch it's not a question of implementation, since there already seem 
to be people such as Ingo willing to do the work.  It's just a question 
of supporting such a beast once integrated.  I think this patch's 
approach shines in the fact that it depends mostly on existing SMP-safe 
coding practices, and an intrusive but arguably bearable annotation of 
spinlocks as to whether they need to be raw or not.  The locks could be 
better named, but a patch to rename them all would be far too large to 
ever get accepted.

IMHO Linux has always taken the path of best design to achieve a goal, 
which is distinct from "simplest design, period".  It's easier to write 
a non-SMP kernel, yet Linux has one.  It's easier to write a kernel that 
works on one architecture than one that works on 23, yet we have that 
too.  Is this patch the most elegant approach?  Probably not, and you 
can be sure it'll change a lot before it's included (if ever), simply 
based on the history of such things.  However we're not even getting 
that far, because you are attacking everyone that says they like 
programming for a single-kernel model, arguing from a viewpoint of not 
having read the patch or following its development up to this point.

> Yeah great. Can we stop with these misleading implications now?
> *A* programmer will have to write RT support in *either* scheme.
> *THE* programmer (you imply, a consumer of the userspace API)
> does not.

Right, a programmer (a maintainer, really) will have to keep the 
nanokernel's API up to date with additions to Linux's API that RT people 
want to use.  The single kernel approach simply means new APIs have to 
be inspected for RT performance, but many that are written to be SMP 
scalable will "just work" for most RT people.  I know for me at least 
its a hell of a lot easier to read kernel code and see what latency it 
might entail than to produce a steady stream of updates to keep an API 
up to date.  The split kernel approach sounds a lot like UML in terms of 
effort, which makes sense to avoid if you can.

> You're controling a robot, and you consider passing configuration
> data over a file descriptor to be overly complex?

I said MORE complex, not OVERLY complex.  Really the SOLE PURPOSE of an 
OS is to make writing applications easier.  That's because anything 
*could* be written for bare hardware in assembler from scratch; Its 
simply a question of time and effort spent.  Infrastructure such as an 
OS or compiler make sense only because they amortize their very 
difficult design over the thousands or millions of things people end up 
doing with them.  Enough people want at least soft RT that it *will* 
happen, so let's work together to find the most elegant implementation.

 > I guess the robot doesn't do much, then?

...or maybe its a system with several hundred configuration parameters, 
calculated and learned tables, and other associated stuff I'd rather not 
marshal over to a control process since its completely unnecessary to do 
so with a better designed RT subsystem?  If you know better about all 
these apps, feel free to come to the next IROS or ICRA and tell us all 
we've been wasting our lives on robotics research.  I'm glad Linux has 
become the preeminent OS for robotics in spite of attitudes such as this.

> You know that if your app executes some code that doesn't require
> deterministic completion then it doesn't have to exit from the
> RT kernel, right?

Sure, it can always upcall to the normal kernel, but the piping for this 
has to be written (and maintained), along with possible library updates 
to support the user-visible API.  In any of the designs I've seen so far 
this doesn't come for free.  I haven't studied RTAI/Fusion though, so 
maybe things have changed.

> Nor does the RT kernel have to provide *only* deterministic services.
> Hey, it could implement a block device backed filesystem - that solves
> your robot's problem.

And who's going to write it?  I think you overestimate the burden of 
supporting the proposed approach in the RT patch in comparison to 
maintaining a nanokernel with a useful set of APIs.  Writing and 
supporting a nanokernel connected with Linux is by no means trivial or 
free, and the effort for implementation and maintenance goes up for 
every added API or upcall to the non-RT system.

> "Nobody has even yet *suggested* any *slightly* credible reasons
> of why a single kernel might be better than a split-kernel for
> hard-RT"
>
> Of all the "reasons" I have been given, most either I (as a naive
> idiot, if you will) have been able to shoot holes in, or others
> have simply said they're wrong.

Yes, you "shoot holes" by bringing up examples such as fork/exec and 
other things RT apps would almost never do while expecting to meet 
deadlines.  Then at the same time, when someone describes what an RT 
application typically does do, you claim how simple and trivial it all 
is, and without knowing any of the details tell them that it'd be easy 
to split it into separate processes.  Please explain how a split-kernel 
method supports a continuous progression from soft-realtime to 
hard-realtime, where each set of API calls has associated latency 
effects that may or may not be tolerable for a given application. 
That's the problem space, and I can guarantee applications exist all 
along that progression, and many don't fall cleanly into one side or the 
other.

> I hate to say but I find this almost dishonest considering
> assertions like "obviously superior" are being thrown around,
> along with such fine explanations as "start writing realtime apps
> and you'll find out".

I said neither, why don't you take it up with the authors of those 
comments.  Btw, Mach was extended to do RT in a project called RT-Mach. 
  Since you like that approach so much, maybe you should ask yourself 
why it failed.  You could also think about why the Jack people aren't 
using something like RTAI with its nanokernel approach.  It's certainly 
not because the people working on those systems are ignorant.

  - Jim Bruce
