Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWF2Xdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWF2Xdw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWF2Xdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:33:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:44446 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751309AbWF2Xdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:33:51 -0400
Date: Fri, 30 Jun 2006 01:33:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Milton Miller <miltonm@bga.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: klibc and what's the next step?
In-Reply-To: <200606290034.k5T0YkCw028911@terminus.zytor.com>
Message-ID: <Pine.LNX.4.64.0606300038410.12900@scrub.home>
References: <Pine.LNX.4.64.0606271316220.17704@scrub.home>
 <f5e0f599448456bcbf2699994f0bbc76@bga.com> <Pine.LNX.4.64.0606290117220.17704@scrub.home>
 <200606290034.k5T0YkCw028911@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 28 Jun 2006, H. Peter Anvin wrote:

> > > * There is concern about how much is bloat, where do we draw the line 
> > > for in-kernel
> > 
> > That actually wouldn't be my initial concern. Otherwise I'm happy to point 
> > out kernel bloat, but here it's more important to prototype a mechanism. 
> > In this case bloat can still be fixed later, as it's rather isolated 
> > behind a standard API.
> 
> First of all, I don't think there is any significant amount of bloat
> (in the sense of a larger kernel image.)  I'm not saying kinit-based
> kernel images are *smaller*, but they shouldn't be significantly
> larger.

As I said, IMO it's not an immediate issue.

> The code currently in kinit is trying to be as closely compatible with
> the mainstream kernel as practical -- a drop-in replacement.  Thus, I
> have actively avoided making radical changes,

The point is, this also makes it its largest problem - it adds no 
immediate value, you add a lot of infrastructure without a single user. 
There is practically nothing, where one could say "Yes, that looks like a 
good way to go forward."

As it looks like it's distribution which are mostly interested in this. 
Have you talked with any distribution maintainer to find out what they 
need and what they want to put initramfs? What are the exact problems 
which distributions have and how do you want to solve them?
Here it should be not that difficult to prototype any new mechanism and
whether it uses an initrd or initramfs is not important initially. From 
this it would be a lot easier to see what is required from the kernel. 

> I definitely agree -- and I'm sure Neil does as well -- that the md
> code should be rewritten, but as long as the whole thing is maintained
> by me out of tree I want to minimize the delta.

The question should rather be: how can Neil maintain it out of tree?
How do we avoid having to split all utils into a klibc version and the 
normal version?

> The whole point of this exercise is that it gives us a platform by
> which to reduce the maintenance of multiple different code bases.
> Kernel programming is completely different than user-space
> programming, it's poorly understood, and it is much more difficult.
> With klibc, it's trivial to share code with even fairly large
> userspace projects (e.g. udev); furthermore it is trivial to create
> standalone components (e.g. nfsmount) which can not only be tested
> standalone, but actually used by customized userspaces, thus
> improving code reuse and reducing overall complexity.

Nobody really disagrees with this, but _how_ do you want to do this?
Do you just expect that by throwing a lot of source into the kernel all of 
this will solve itself?

> > klibc will continue as independent project anyway, so it should not be 
> > difficult to include from the kernel whatever the distribution provides. 
> > It would help avoiding possible problems with mixing binaries built from 
> > different libraries.
> 
> As long as klibc/kinit is not merged, the current code will have to be
> maintained.  This means maintaining in-kernel ipconfig, nfsroot, and
> it pretty much dooms the possibility of getting stuff like md detect
> and partition discovery rewritten.

What has klibc to do with kinit? This rather suggest both are interrelated 
projects, why should one be dependent on the other?

> The utility of klibc is thus greatly diminished by not having it in
> the mainline kernel tree.  Its performance in -mm so far has shown
> that it works just fine.

That just says, it doesn't create new problems, but it still doesn't say 
anything about how you want to solve any of the existing problems without 
creating a whole bunch of new problems.

> Incidentally, there is one more reason for klibc which hasn't gotten
> much mention, but it provides a prototype userspace for kernel
> developers to:
> 
>   a) test new features (or at least a significant subset thereof), and
>   b) document, in code, a recommended way for the more advanced libcs
>      to make new features available to userspace, in the form of
>      headers and the like.

Why has this to be distributed with the kernel? It sounds like it can be 
nicely maintained independently.

bye, Roman
