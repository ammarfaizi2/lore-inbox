Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263151AbVCJVae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbVCJVae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 16:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbVCJV2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 16:28:48 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:49817 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S263156AbVCJVWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:22:03 -0500
Date: Thu, 10 Mar 2005 16:21:33 -0500
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binary drivers and development
Message-ID: <20050310212133.GE17865@csclub.uwaterloo.ca>
References: <423075B7.5080004@comcast.net> <423082BF.6060007@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423082BF.6060007@comcast.net>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 12:24:15PM -0500, John Richard Moser wrote:
> I've done more thought, here's a small list of advantages on using
> binary drivers, specifically considering UDI.  You can consider a
> different implementation for binary drivers as well, with most of the
> same advantages.
> 
>  - Smaller kernel tree
>    The kernel tree would no longer contain all of the drivers; they'd
>    slowly have to bleed into UDI until most were there

Users would have to go hunting for drivers to add to their kernel to get
hardware supported.  Making a CD with a kernel and drivers for a wide
variety of hardware would be a nightmare.

>  - Better focused development
>    The kernel's core would be the core.  Driver code would be isolated,
>    so work on the kernel would affect the kernel only and not any
>    drivers.  UDI is a standard interface that shouldn't be broken.  This
>    means that work on the high-level drivers will not need to be sanity
>    checked a thousand times against the PCI Bus interface or the USB
>    host controler API or whatnot.

But anything that runs in kernel memory space can still go trampling on
memory in the kernel by accident and is very difficult to debug without
the sources.

>  - Faster rebuilding for developers
>    The isolation between drivers and core would make rebuilding involve
>    the particular component (driver, core).  A "broken driver" would
>    just require recoding and rebuilding the driver; a "broken kernel"
>    would require building pretty much a skeletal core

That can already be done basicly.  The makefiles work just fine for
rebuilding only what has changed in general.

>  - UDI supplies SMP safety
>    The UDI page brags[1]:
> 
>    "An advanced scheduling model. Multiple driver instances can be run
>     in parallel on multiple processors with no lock management performed
>     by the driver. Free paralllism and scalability!"
> 
>    Drivers can be considered SMP safe, apparently.  Inside the same
>    driver, however, I have my doubts; I can see a driver maintaining a
>    linked list that needs to be locked during insertions or deletions,
>    which needs lock managment for the driver.  Still, no consideration
>    for anything outside the driver need be made, apparently.
>  - Vendor drivers and religious issues
>    Vendors can supply third party drivers until there are open source
>    alternatives, since they have this religious thing where they don't
>    want people to see their driver code, which is kind of annoying and
>    impedes progress

I imagine a driver writer could still easily do something not SMP safe,
but I don't know that for sure.  It sounds like a very complex thing to
promise a perfect solution for.

> Disadvantages:
> 
>  - Preemption
>    Is it still possible to implement a soft realtime kernel that
>    responds to interrupts quickly?
>  - Performance
>    UDI's developers claim that the performance overhead is negligible.
>    It's still added work, but it remains to be seen if it's significant
>    enough to degrade performance.
>  - Religious battles
>    People have this religious thing about binary drivers, which is kind
>    of annoying and impedes progress

Many of the disadvantages are a good reason why they have these opinions
on binary drivers.  They do impede getting work done if you have to use
them on your system and something isn't working right.

>  - Constriction
>    This would of course create an abstraction layer that constricts the
>    driver developer's ability to do low level complex operations for any
>    portable binary driver

You forgot the very important:
   - Only works on architecture it was compiled for.  So anyone not
     using i386 (and maybe later x86-64) is simply out of luck.  What do
     nvidia users that want accelerated nvidia drivers for X DRI do
     right now if they have a powerpc or a sparc or an alpha?  How about
     porting Linux to a new architecture.  With binary drivers you now
     start out with no drivers on the new architecture except for the
     ones you have source for.  Not very productive.

[snip]

Len Sorensen
