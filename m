Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTLDA2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTLDA2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:28:34 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:10181 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S262608AbTLDA2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:28:31 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Wed, 03 Dec 2003 16:29:53 -0800
MIME-Version: 1.0
Subject: Re: Linux GPL and binary module exception clause?
CC: andrewb@scitechsoft.com
Message-ID: <3FCE0F81.6914.3EF1D7AD@localhost>
References: <3FCDE5CA.2543.3E4EE6AA@localhost>
In-reply-to: <Pine.LNX.4.58.0312031533530.2055@home.osdl.org>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> On Wed, 3 Dec 2003, Kendall Bennett wrote:
> >
> > I have heard many people reference the fact that the although the Linux
> > Kernel is under the GNU GPL license, that the code is licensed with an
> > exception clause that says binary loadable modules do not have to be
> > under the GPL.
> 
> Nope. No such exception exists.

Right, after following a few of the links and reading the previous 
discussions, that is clear to me now ;-)

> But one gray area in particular is something like a driver that
> was originally written for another operating system (ie clearly not
> a derived work of Linux in origin). At exactly what point does it
> become a derived work of the kernel (and thus fall under the GPL)? 
> 
> THAT is a gray area, and _that_ is the area where I personally
> believe that some modules may be considered to not be derived works
> simply because they weren't designed for Linux and don't depend on
> any special Linux behaviour. 

Or what if a device driver is written such that it is completely binary 
portable between different operating systems, such that the same binary 
can work on Linux, OS/2, Windows, QNX, BeOS and multiple embedded 
systems? Clearly I am talking about our SciTech SNAP drivers here, as 
that is what they are. Would writing glue code to allow those modules to 
be loaded inside the Linux kernel make the binary driver modules derived 
works? Clearly the glue code would be Linux specific and hence need to be 
GPL, but would it extend to the binary module? I can also come up with 
some arguments both for and against this scenario, and I agree 100% that 
it is a huge gray area.

To date we have not even attempted to load our SNAP drivers inside the 
Linux kernel, even though it would be quite easy to do so, primarily 
because of this gray area. We may need to write some kernel modules 
shortly to support a few things that the SNAP drivers may need, but since 
the user space drivers would interface to this kernel module via system 
calls, only the kernel module would need to the GPL and the user space 
driver that uses it would not. So we may never try to load the SNAP 
drivers inside the kernel, but it is an interesting exercise to consider 
the legality of whether it is possible.

Anyway loading SNAP drivers inside the Linux kernel, while interesting, 
wasn't the reason I brought up this discussion. The primary reason is 
that we are going to be releasing the SciTech SNAP DDK under the GNU GPL 
soon, and I wanted to understand how this expection clause works. Since 
it doesn't exist, it does open up a few questions ;-)

It is our position that drivers that would be built from our GNU GPL DDK 
are in themselves separate works as they follow a clearly defined, binary 
compatible interface and can be used with software building using a non-
GPL version of our SDK (the SDK is actually LGPL). The driver binary 
itself on the other hand must be GPL, as it links against generic code 
provided to the developer as part of the DDK, so full source to any 
driver built with the GPL DDK must be provided. Even your own writings on 
this issue would indicate that you would agree with me on that front. 

The lowest level binary modules have a 'less public' interface, in that 
we do not directly document it (well, at least not yet except for the 
header files but some may consider that valid documentation). It does 
evolve more quickly over time than the public SDK API, but even so the 
drivers ABI is strictly maintained for backwards compatibility, even 
though it does evolve. We have a clearly defined interface for evolving 
the API while maintaining backwards compatibility, and even doing hot bug 
fixes for existing binary drivers as necessary. But above the low level 
driver is the public SciTech SNAP API, which evolves much, much more 
slowly and is completely documented (both at the header file level and 
external documentation level).

Does my position make sense? 

Clearly the intention here is to make sure that the GPL version of our 
DDK is available for free use by the Free Software community, but if 
someone like Intel or NVIDIA wants to write a SNAP driver that they don't 
provide source code for, they need to license a proprietry licensed 
version of our DDK.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

