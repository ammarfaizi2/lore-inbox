Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUAZPk4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 10:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265259AbUAZPkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 10:40:55 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:52726 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S264933AbUAZPk3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 10:40:29 -0500
Date: Mon, 26 Jan 2004 10:50:31 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Steve Youngs <sryoungs@bigpond.net.au>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040126105031.A27128@mail.kroptech.com>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org> <Pine.LNX.4.58.0401251054340.18932@home.osdl.org> <microsoft-free.877jzfoc5h.fsf@eicq.dnsalias.org> <20040125222242.A24443@mail.kroptech.com> <microsoft-free.87hdyjs3h3.fsf@eicq.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <microsoft-free.87hdyjs3h3.fsf@eicq.dnsalias.org>; from sryoungs@bigpond.net.au on Mon, Jan 26, 2004 at 03:06:48PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 03:06:48PM +1000, Steve Youngs wrote:
> * Adam Kropelin <akropel1@rochester.rr.com> writes:
> 
>   > On Mon, Jan 26, 2004 at 09:12:58AM +1000, Steve Youngs wrote:
>   >> * Linus Torvalds <torvalds@osdl.org> writes:
>   >> 
>   >> >  - doing proper refcounting of modules is _really_ really
>   >> >    hard. The reason is that proper refcounting is a "local"
>   >> 
>   >> Please understand that I coming from an _extremely_ naive perspective,
>   >> but why do refcounting at all?  Couldn't the refcount be a simple
>   >> boolean?
> 
>   > A boolean is just a one-bit reference count. If the maximum number of
>   > simultaneous 'users' for a given module is one, then a boolean will work.
>   > If there is potential for more than one simultaneous user then you need
>   > more bits.
> 
> Why?  A module is either being used or it isn't, the number of uses
> shouldn't even come into it.

I think others in the thread have adequately explained the details
you're missing.

> I'm suggesting that the responsibility for determining when it is safe
> to unload a particular module should lay with the module itself and
> not with the kernel.

That does not change anything at all. The same problems apply and the
same pool of solutions is still available. The easy cases are still easy
and the hard cases are still *really* hard.

>   >> >  - lack of testing. 
>   >> 
>   >> A moot point once the kernel can safely and efficiently do module
>   >> unloading. 
> 
>   > I don't follow your logic. Once it works we don't have to test it so 
>   > therefore we never need to test it?
> 
> Possibly a poor choice of words on my part.  What I meant was that
> once the functionality goes into the kernel testing will happen on
> every single Linux box in the land that has this future kernel.  Some
> of those users will report bugs if there are any.  And some of those
> users may even help to fix those bugs.

Hello? 2.4, etc. support removing modules. Linus was speaking from
experience. One of the reasons module removal is perpetually broken in
subtle ways on those kernels is that it simply does not receive enough
testing. Having some new implementation on 2.6 doesn't change that.

> Also what I meant is that you can't test something that doesn't
> exist.

As I pointed out above, it does exist.

>   >> We get an awful lot of blue moons here.
> 
>   > This moon's not worth barking at.
> 
> There are an awful lot of users out there who would disagree with you
> on that.  _One_ of the reasons that I believe that this moon is worth
> barking at is:
> 
> If a module should never, in the normal course of events, be unloaded,
> then there isn't _any_ point to being able to load them in the first
> place.  Not being able to unload them _totally_ defeats the purpose of
> modules.

Think a little harder and you'll see why that's a ridiculous conclusion.
Hint #1: Distributions. Hint #2: SILO.

> Tell me that this problem is _impossible_ to solve and providing you
> can show me _why_ it is impossible I'll speak no more on this
> matter.

No one yet has claimed this is "impossible" to solve, only that it's not
worth solving. Clearly it's important to you, so have at it. Further
discussion of how you "see the answer so clearly" and the rest of us are
"not trying hard enough" should come in the form of patches.

--Adam

