Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVE1Gtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVE1Gtt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 02:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVE1Gtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 02:49:49 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:695 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261979AbVE1Gt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 02:49:28 -0400
Message-ID: <42981467.6020409@yahoo.com.au>
Date: Sat, 28 May 2005 16:49:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com>
In-Reply-To: <20050528054503.GA2958@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> On Sat, May 28, 2005 at 01:53:59PM +1000, Nick Piggin wrote:
> 
> 
> OpenGL must be RT aware for the off screen buffer to be flipped. This
> model isn't practical. With locking changes in X using something like
> xcb in xlib, you might be able to achieve these goals. SGI IRIX is
> enable to do things like this.
> 

OpenGL seems to work just fine here, and it can flip off screen buffers.

> Please try to understand the app issues here, because you seem to have
> a naive understanding of this.  [evil jab :)]
> 

It's not an evil jab, because I do have a naive understanding of this.
But nobody has been able to say why a single kernel is better than a
nanokernel.

> True, but XFS was designed to deal with this in the first place. It's
> not that remote a thing and if you have a nice SMP friendly system so
> it's possible to restore that IRIX functionality in Linux.
> 

Then it is also possible to have that functionality in a hard-RT
guest kernel too.

> 
> There's a lot of unknowns here, but XFS is under utilized in Linux.
> I can't really imagine how a RT host kernel could really respect
> something as complicated as XFS with all of it's tree balancing stuff
> and low level IO submissions with concurrent reads/writes. The nanokernel
> adapation doesn't fly once you think about how complex that chain is.

Err, that wouldn't go in the nanokernel. Do you understand what I'm
talking about? The nanokernel supervises a Linux guest and a hard-RT
guest.

> The RT patch is priming that path to happen already and I would like to
> see this used more.
>  

Sorry, you aren't going to make XFS in Linux generally realtime capable
any time soon, so there is no point saying how hard it is going to be
with a nanokernel.

Oh hang on, wait a second here. *I* am not talking about removing
atomic critical sections or interrupts off periods from the kernel
so that your unrelated high priority userspace code or interrupt
handler can run. I understand PREEMPT_RT has basically solved that.

What I am talking about is an RT app calling into the kernel, and
being granted some resource or service within a deterministic time.
If you RT guys don't need such a thing, then let's clear that up
now so we can all go home to our families ;)

> 
> The problem with that assertion is that it's pretty close to being
> hard RT as is. It's not that "mysterious" and the results are very
> solid. Try not to think about this in a piecewise manner, but how
> an overall picture of things get used and what needs to happen to
> get there as well as all of the work done so far.
> 

For interrupts that do nothing, and userspace code, I'm sure it
is pretty close to being hard-RT. What I am talking about (what
my original question asked), is what kind of useful RT work will
people want to be using the kernel for, and why isn't a microkernel
a better approach.

Seems like a pretty simple question if (as everyone seems to be
saying) the single kernel scheme is so obviously superior. No need
for any handwaving about XFS, or X11, etc.

> 
> They don't understand the patch nor the problem space, so I ignore
> them since they'll never push any edge that interesting. And Ingo's
> comment about the RT patch riding on SMP locking as is should not
> be something that's forgotten.
> 

Well it seems like maybe you don't have a good understanding of their
problem spaces either. And if you ignore them, then that's fine but
you won't get anything merged. (Ingo might, however ;) )

>>Well, you would do the RT work in the RT kernel, then communicate
>>the results to the Linux kernel.
> 
> 
> Write a mini-app and see how this methodology is going to work in
> this system. Both Ingo and me have already pointed out that folks
> already doing general purpose apps need a simple model to work with
> since they need to cross many kernel systems as well as app layers.
> 

Yeah, Linux "does" general purpose apps fine today.

> Stop thinking in terms of a kernel programmer stuck in 1995, but
> something a bit more "large picture" in nature.
> 

I would love to. I'm waiting for somebody to paint me a large picture.

> 
>>you talk about doing _real_ work, that will require an order of
>>magnitude more changes than the PREEMPT_RT patch to make Linux
>>hard-RT. And everyone will need to know about it, from device
>>driver writers and CPU arch code up.
> 
> 
> Uh, not really. Have you looked at the patch or are you inserting
> hysteria in the discussion again ? :) Sounds like hysteria.
> 

OK, I'll start small. What have you done with the tasklist lock?
How did you make signal delivery time deterministic?

How about fork/clone? Or don't those need to be realtime? What
exactly _do_ you need to be realtime? I'm not asking rhetorical
questions here.

> 
> Pretty much any call other an things related to futex handling. That
> doesn't invalidate my point since I wasn't making a broad claim in
> first place.
> 

No, but my broad question was basically - how far will people want
to go with this? And how is one method better than another?

I understand there are some operations where PREEMPT_RT probably is
very close to hard-RT. I have understood that from the start.


> 
>>Suppose the PREEMPT_RT patch gets merged tomorrow. OK, now what
>>if *you* needed a realtime TCP/IP socket. Where will you begin?
> 
> 
> Start with the DragonFly BSD sources and talk to Jeffery Hsu about
> his alt-q implementation. Their stack was parallelize recently and
> can express this kind stuff with possible a special scheduler in
> their preexisting token locking scheme. I'm not talking hard RT
> here for RT enabled IO. Obvious this is going to be problematic
> to a certain degree in a kernel and will have to be move more into
> the realm of soft RT with high performance.
>  

So why did you bring it up as a problem for the nanokernel approach
if you can't handle it with the single kernel approach?

My question is very simple. Just a simple "people need to do X, a
nanokernel can't do X because ... a single kernel can do X" will be
fine.

And you needn't use vague examples with X11 or OpenGL. A concrete
example, say a sequence of system calls would be fine.

I really won't take much convincing, I just want some basic
background.

> 
>>Sorry, not much better... But don't waste too much time on me, and
>>thanks, I appreciate the time you've given me so far.
> 
> 
> Read the patch and follow the development. That's all I can say.
>

When you're ready to submit something to be included in the Linux
kernel, then I'm sure you will have had time to write up a clea
rationale and be able to address my questions on the linux kernel
mailing list. I look forward to it ;)

> 
>>I wouldn't consider a non response (or a late response) to mean that
>>a point has been conceeded, or that I've won any kind of argument :-)
> 
> 
> Well, you're wrong. :)
> 

Wrong about what? While no doubt I've made one or two, I have tried
to steer clear of making assertions.
Send instant messages to your online friends http://au.messenger.yahoo.com 
