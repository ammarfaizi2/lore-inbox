Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbUBYKDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 05:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbUBYKDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 05:03:51 -0500
Received: from zadnik.org ([194.12.244.90]:15574 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S261276AbUBYKDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 05:03:40 -0500
Date: Wed, 25 Feb 2004 12:03:19 +0200 (EET)
From: Grigor Gatchev <grigor@zadnik.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <403BD60E.2060501@matchmail.com>
Message-ID: <Pine.LNX.4.44.0402251112180.16939-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Feb 2004, Mike Fedyk wrote:

> There is already a lot of layering in the kernel.  It seems to be doing
> what you propose to some extent.

Yes. And even if this proposal is not accepted, there inevitably will be more
and more of layering. This is the logic of the kernel usage and development.
Eventually the kernel will come to a full layered model anyway.

If so, then... the sooner, the better.

> > Sandboxing: A layer interface emulator of a lower, eg. Resources layer
> > can pass a configurable "virtual machine" to an upper, eg. Personality
> > layer. You may run a user or software inside it, passing them any
> > resources, real or emulated, or any part of your resources. All
> > advantages of a sandbox apply.
>
> Not true.  What you are asking for is userspace protection to kernel
> modules.  You won't get that unless you use a micro-kernel approach, or
> run different parts of the kernel on different (to be i386 arch
> specific) ring in the processor.  Once you get there, you have to deal
> with the various processor errata since not many OSes use rings besides
> 0 and 3 (maybe ring 1?).

These are two possible approaches. Still another is to have the lowest
layer export functions for memory handling - thus only the lowest layer
will have to run in ring 0 (almost all arch that support Linux have a
corresponding ability), and will handle the protection requests from the
upper layers... Other approaches exist, too. A discussion may help to
clarify which is the best.

> > User nesting: The traditional Unix user management model has two levels:
> > superuser (root) and subusers (ordinary users). Subusers cannot create
> > and administrate their subusers, install system-level resources, etc.
> > Running, however, a subuser in their own virtual machine and Personality
> > layer as its root, will allow tree-like management of users and resources
> > usage/access. (Imagine a much enhanced chroot.)
>
> That is differing security models, and it's being worked on with (I
> forget the term) the security module framework.

Within a layered kernel scheme, this tree-like model is very natural and
simple: all protection is provided by the standard kernel mechanisms. Of
course, it maybe can be improved; that is what the discussion is for.

> > Platforming: It is much easier to write only a Personality layer than an
> > entire kernel, esp. if you have a layer interface open standard as a
> > base. Respectively, it's easier to write only a Resources layer, adding a
> > new hardware to the "Supported by Linux" list. This will help increasing
> > supported both hardware and platforms. Also, thus you may run any
> > platform on any hardware, or many platforms concurrently on the same
> > hardware.
>
> There is arch specific, and generic setions of the kernel source tree
> already.  How do you want to improve upon that?

Currently, Linux supports (actually, is) only one, Unix-descended
platform. With a layered model, an emulator, eg. Wine, could be easily
rewritten as a Personality layer, and this would turn it instantly into
a free Windows. A modification of the Linux sofware and tools could
produce a free Solaris. Some people may like a free OS/2, QNX, VxWorks
etc. Other platforms will became easier to create and test, thus helping
the free software evolution. On most architectures, you will be able to
emulate another processor right in the kernel, either directly, or by a
code emulator: all other will go then much easier. Much more advantages
exist...

Now, to the point. When you have -one- platform over -many- hardwares, it
is easy to compile a version for your hardware - and that is as much as
you can get. However, when you have -many- platforms over -many-
hardwares, you lose in this way additional options. You can still compile
a specific platform for a specific hardware, but cannot anymore produce a
multi-platform system over a single hardware, with the ability for many
platforms to run concurrently, to have flexible distribution of resources
between them, etc. (Of course, you may rewrite the source as to be able to
compile such one, but this will effectively amount to the proposal
discussed.)

> > Heterogeneous distributed resources usage: Under this security model,
> > networks of possibly different hardware may share and redistribute
> > resources, giving to the users resource pools. Pools may be dynamical,
> > thus redistributing the resources flexibly. This mechanism is potentially
> > very powerful, and is inherently consistent with the open source spirit
> > of cooperativity and freedom.
>
> Single system image clusters are hard enough where each node is the same
>   arch, and very hard, or almost impossible when dealing with mixed
> processor arch or 32/64 bit processors.
>
> See OpenSSI and OpenMosix.

Yes, not all of the road would be taken. But an important part will be
(see the discussion above). The rest will be already easier.

As a whole, the model seems to be:

a) logically consistent with the proven kernel development logic
b) solving naturally at once several current problems, and laying the
ground for solving more

That is what makes me wary about it - it seems like a "brilliant" idea.
However, it also seems rather logical, and worth considering and
discussing.


Grigor

