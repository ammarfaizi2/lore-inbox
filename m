Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbUBYWFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUBYWDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:03:18 -0500
Received: from zadnik.org ([194.12.244.90]:33238 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S261651AbUBYV73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:59:29 -0500
Date: Wed, 25 Feb 2004 23:59:10 +0200 (EET)
From: Grigor Gatchev <grigor@zadnik.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <403CFE48.8090009@matchmail.com>
Message-ID: <Pine.LNX.4.44.0402252339420.18468-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Feb 2004, Mike Fedyk wrote:

> Grigor Gatchev wrote:
> >
> > On Tue, 24 Feb 2004, Mike Fedyk wrote:
> >>Not true.  What you are asking for is userspace protection to kernel
> >>modules.  You won't get that unless you use a micro-kernel approach, or
> >>run different parts of the kernel on different (to be i386 arch
> >>specific) ring in the processor.  Once you get there, you have to deal
> >>with the various processor errata since not many OSes use rings besides
> >>0 and 3 (maybe ring 1?).
> >
> >
> > These are two possible approaches. Still another is to have the lowest
> > layer export functions for memory handling - thus only the lowest layer
> > will have to run in ring 0 (almost all arch that support Linux have a
> > corresponding ability), and will handle the protection requests from the
> > upper layers... Other approaches exist, too. A discussion may help to
> > clarify which is the best.
> >
>
> And you get an effective "context switch" even if you're not crossing
> process boundaries.  (it could be argued that different layers on
> seperate rings are effectively now a "process"...)

Yes. However, you won't have to do this switch often. Request for
allocating a protected memory, or deallocating it, usually happens once
when you run a process, and once when you close it. Even if a poorly
written program requests byte-by-byte additional memory, grouping these
requests is rather trivial for a memory manager. Memory protection
violations are also rare in the reality, so one can afford the load.

In addition, this scheme solves one more problem: the fixed two-level
memory management - "kernelspace and userspace". Like the "root and users"
notion, it is good to some extent, but limits the system. The layered
kernel memory management scheme would have to allow tree-like memory
management, as a part of the tree-like resources management, thus allowing
both more flexibility and more control at the same time.

>
> > Currently, Linux supports (actually, is) only one, Unix-descended
> > platform. With a layered model, an emulator, eg. Wine, could be easily
> > rewritten as a Personality layer, and this would turn it instantly into
> > a free Windows. A modification of the Linux sofware and tools could
> > produce a free Solaris. Some people may like a free OS/2, QNX, VxWorks
> > etc. Other platforms will became easier to create and test, thus helping
> > the free software evolution. On most architectures, you will be able to
> > emulate another processor right in the kernel, either directly, or by a
> > code emulator: all other will go then much easier. Much more advantages
> > exist...
> >
>
> One way or another, you'd have to have a "personality".  With Linux
> there is one in the kernel, and possibly many in userspace.  You won't
> find many here that will agree it should be any other way.

Yes. But if you have one hardcoded in the kernel, you run it every time,
even if you don't need it. Then, you run some other personality on top of
it, and possibly more libraries and programs to support and compensate
for the difference. All this is a platform burden. If you can use a more
lightweight approach, this will both increase productivity and simplify
things. Not speaking about all other advantages (see the original post).


Grigor


