Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbUAZDNA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 22:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbUAZDM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 22:12:59 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:2545 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S265442AbUAZDMq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 22:12:46 -0500
Date: Sun, 25 Jan 2004 22:22:42 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040125222242.A24443@mail.kroptech.com>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org> <Pine.LNX.4.58.0401251054340.18932@home.osdl.org> <microsoft-free.877jzfoc5h.fsf@eicq.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <microsoft-free.877jzfoc5h.fsf@eicq.dnsalias.org>; from sryoungs@bigpond.net.au on Mon, Jan 26, 2004 at 09:12:58AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 09:12:58AM +1000, Steve Youngs wrote:
> * Linus Torvalds <torvalds@osdl.org> writes:
> 
>   >  - doing proper refcounting of modules is _really_ really
>   >    hard. The reason is that proper refcounting is a "local"
>   >    issue: you reference count a single data structure. It's
>   >    basically impossible to make a "global" reference count
>   >    without jumping through hoops.
> 
> Please understand that I coming from an _extremely_ naive perspective,
> but why do refcounting at all?  Couldn't the refcount be a simple
> boolean?

A boolean is just a one-bit reference count. If the maximum number of
simultaneous 'users' for a given module is one, then a boolean will work.
If there is potential for more than one simultaneous user then you need
more bits.

Either way, it doesn't simplify the problem.

> I see the process working along these lines: When a module is loaded
> into the kernel it (the module) exports a symbol (a function) that the
> kernel can use for determining whether or not the module is still in
> use.

And how will the module know when it is or is not "in use"? By keeping
a count of the number of current users, of course.

>   >  - lack of testing. 
> 
> A moot point once the kernel can safely and efficiently do module
> unloading. 

I don't follow your logic. Once it works we don't have to test it so 
therefore we never need to test it? I don't buy the premise or the
conclusion.

>   >    Unloading a module happens once in a blue moon, if even then.
> 
> We get an awful lot of blue moons here.

This moon's not worth barking at.

>   > But it basically boils down to: don't think of module unload as a "normal
>   > event". It isn't. Getting it truly right is (a) too painful and (b) would
>   > be too slow, so we're not even going to try.
> 
> Now there's a cop out if ever I saw one.  Surely, Linus, you've
> overcome _much_ bigger problems than this at different times.

Linus can of course speak for himself but from my perspective it's just
a simple cost/benefit analysis. This one's just not worth any more toil.
Several extremely bright people have tackled the problem and eventually
concluded it's extremely hard to solve and generally not worth the
trouble. It's time to let go.  

--Adam

