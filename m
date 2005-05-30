Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVE3JiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVE3JiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 05:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVE3JiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 05:38:14 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:34482 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261577AbVE3Jhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 05:37:46 -0400
Message-ID: <429ADEDD.4020805@yahoo.com.au>
Date: Mon, 30 May 2005 19:37:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: James Bruce <bruce@andrew.cmu.edu>
CC: "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu>
In-Reply-To: <4299A98D.1080805@andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bruce wrote:
> Nick Piggin wrote:
> 
>> But nobody has been able to say why a single kernel is better than a
>> nanokernel.
> 
> 
> I think it's a bit more like you haven't realized the answer when people 
> gave it, so let me try to be more clear.  It's purely a matter of effort 

Sorry no, nobody answered me. What I did realize was that there
was a lot of noise nothing really got resolved.

> - in general it's far easier to write one process than two communicating 
> processes.

I reject the vague "complexity" argument. If your application
is not fairly clear on what operations need to happen in a
deterministic time and what aren't, or if you aren't easily able
to get 2 communicating processes working, then I contend that you
shouldn't be writing a realtime application.

What's more, you don't even need to have 2 communicating processes,
you could quite possibly do everything in the realtime kernel if
you are talking some simple control system and driver.

Note that I specifically reject the *vague* complexity argument,
because if you have a *real* one (ie. we need functionality
equivalent to this sequence of system calls executed in a
deterministic time - the nanokernel approach sucks because [...])
then I'm quite willing to accept it.

The fact is, nobody seems to know quite what kind of deterministic
functionality they want (and please, let's not continue the jokes
about X11 and XFS, etc.). Which really surprises me.

I will give *you* a complexity argument. Making the Linux kernel
hard realtime is slightly more complex than writing an app that
consists of 2 communicating processes.

> As far as APIs, with a single-kernel approach, an RT 
> programmer just has to restrict the program to calling APIs known to be 
> RT-safe (compare with MT-safe programming).  In a split-kernel approach, 
> the programmer has to write RT-kernel support for the APIs he wants to 
> use (or beg for them to be written).

Yeah great. Can we stop with these misleading implications now?
*A* programmer will have to write RT support in *either* scheme.
*THE* programmer (you imply, a consumer of the userspace API)
does not.

There is absolutely no difference for the userspace programmer
in terms of realtime services.

>  Most programmers would much rather 
> limit API usage than implement new kernel support themselves.
> 

...

> A very common RT app pattern is to do a bunch of non-RT stuff, then 
> enter an RT loop.  For an example from my work, a robot control program 
> starts by reading a bunch of configuration files before it starts doing 
> anything requiring deadlines, then enters the RT control loop.  Having 
> to read all the configuration in a separate program and then marshall 
> the data over to an RT-only process via file descriptors is quite a bit 
> more effort.  I guess some free RT-nanokernels might/could support 
> non-RT to RT process migration, or better messaging, but there's 

You're controling a robot, and you consider passing configuration
data over a file descriptor to be overly complex? I guess the robot
doesn't do much, then?

> additional programming effort (and overhead) that wasn't there before. 
> In general an app may enter and exit RT sections several times, which 
> really makes a split-kernel approach less than ideal.
> 

You know that if your app executes some code that doesn't require
deterministic completion then it doesn't have to exit from the
RT kernel, right?

Nor does the RT kernel have to provide *only* deterministic services.
Hey, it could implement a block device backed filesystem - that solves
your robot's problem.

> An easy way to visualize the difference in programming effort for the 
> two approaches is to take your favorite threaded program and turn it 
> into one with separate processes that only communicate via pipes.  You 

Yeah, or turn it into seperate processes that communicate via
shared memory. Oh, wait...

> can *always* do this, its just very much more painful to develop and 
> maintain.  Your stance of "nobody can prove why a split-kernel won't 
> work" is equivalent to saying "we don't ever really need threads, since 
> processes suffice".  That's true, but only in the same way that I don't 
> need a compilier or a pre-existing operating system to write an 
> application.
> 

No it is not equivalent at all, and even if it were, that is not
what my stance is. Let's dispense with the metaphors and abstract
comparisons, and cut to what my stance actually is:

"Nobody has even yet *suggested* any *slightly* credible reasons
of why a single kernel might be better than a split-kernel for
hard-RT"

Of all the "reasons" I have been given, most either I (as a naive
idiot, if you will) have been able to shoot holes in, or others
have simply said they're wrong.

I hate to say but I find this almost dishonest considering
assertions like "obviously superior" are being thrown around,
along with such fine explanations as "start writing realtime apps
and you'll find out".
Send instant messages to your online friends http://au.messenger.yahoo.com 
