Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268978AbUH0Vs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268978AbUH0Vs3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268889AbUH0VqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:46:23 -0400
Received: from smcc.demon.nl ([212.238.157.128]:27660 "HELO smcc.demon.nl")
	by vger.kernel.org with SMTP id S268737AbUH0Vmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:42:32 -0400
From: "Nemosoft Unv." <webcam@smcc.demon.nl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Termination of the Philips Webcam Driver (pwc)
Date: Fri, 27 Aug 2004 23:42:30 +0200
User-Agent: KMail/1.6.1
Cc: Craig Milo Rogers <rogers@isi.edu>, Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040826233244.GA1284@isi.edu> <20040827185541.GC24018@isi.edu> <Pine.LNX.4.58.0408271157540.14196@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408271157540.14196@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408272342.30619@smcc.demon.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On Friday 27 August 2004 21:06, Linus Torvalds wrote:
> On Fri, 27 Aug 2004, Craig Milo Rogers wrote:
> > 	If you read Nemosoft's final driver release (which has been
> > reposted, and of which I now have a copy), you can see that he was
> > rewriting his code to move the proprietary codecs out of the kernel
> > entirely, and into user-mode libraries to be linked with consenting
> > applications
>
> That sounds quite good, in my opinion.

And not even too good to be true. In PWC 9.0 I introduced a RAW mode that 
passes the compressed stream through unmodified, together with some support 
ioctl()s.

> Whenever somebody says "accept the driver to help users", they are
> missing the big picture. A binary driver SCREWS OVER users on other
> architectures. It pretty much guarantees that those other architectures
> will never be supported. (And that's totally ignoring the maintenance
> issues even on regular x86).

Well, there's cross-compiling. You're probably not aware of this, but the 
most recent PWC major version increase included some changes that would 
make it a lot easier for me to cross-compile the real decompressor core to 
any platform that GCC supports. The code is (was) turned into a library 
(.a) which can be used as a user-program library, or turned into a kernel 
module with a bit of glue code. So far, 6 different platforms in various 
'flavors' were supported, and the number was growing. 

Still not a perfect solution, but it means less and less people were 
'screwed over', with relatively little effort (all they had to do was point 
me to a cross-compiler toolchain...). I think I was supporting more 
platforms than nVidia ever will :-P

> > 	Linus, would you adress a moot issue, please?  If Nemosoft (or
> > someone else) were to release some of the codecs in question as one or
> > more open-source loadable kernel modules (similar to sound card
> > support modules in the ALSA system), while other codecs remain
> > binary-only loadable kernel modules (distributed outside the kernel,
> > but using the same hook as the open-source loadable modules), would
> > the pwc driver and codec extension hook be allowable, in your opinion,
> > please?
>
> I'd be leery.

[snip]

> So I'd personally much prefer the user mode approach. At that point it's
> still closed-source, but at least there is not even a whiff of a "hook"
> inside the kernel.

My problem with that is that it makes using such cams a lot harder for both 
users and developers of webcam tools. Basicly, every tool that wanted to 
use webcam X that has some binary-only library would need to specifically 
support it, use probing routines, check which formats are supported, set up 
the decompressor, push the data through it, etc. Conversely, every user 
that wanted to use webcams X, Y and Z would need to check first if they are 
all supported by the program(s) he would like to use.

The point is, the current API for video devices is the Video4Linux of 
Video4Linux2 interface. It's relative simple one, but it _works_ the same 
on all hardware, either TV card or webcam. What you're proposing is 
fragmenting that support into programs that support X, Y or Z, or only a 
subset, or none, based on whether or not the developer of said tool had the 
time, skill and desire to incorporate these libraries into their program.

So instead of putting the support burden on one person (me), you want to 
distribute it among a few dozen software developers. I don't think that's 
really smart. It also takes the fun out of hacking a small webcam tool 
together for whatever purpose, if you need a ton of extra tools, libraries 
and program just to get one image.

A solution could be something like JACK for the ALSA sound cards, but then 
for video. But you need a compelling reason, and somebody (somebodies) to 
design, write and maintain it.

Anyway... wether or not PWC was illegal under the GPL, technically 
undesirable or just not good enough, is irrelevant now. The damage has been 
done, and that's just sad.

 - Nemosoft


