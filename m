Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUBXWyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbUBXWyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:54:23 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:25995 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262514AbUBXWyT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:54:19 -0500
Message-ID: <403BD60E.2060501@matchmail.com>
Date: Tue, 24 Feb 2004 14:54:06 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grigor Gatchev <grigor@zadnik.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
References: <Pine.LNX.4.44.0402242147460.11666-100000@lugburz.zadnik.org>
In-Reply-To: <Pine.LNX.4.44.0402242147460.11666-100000@lugburz.zadnik.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grigor Gatchev wrote:
> Advantages
> 
> Improved source: A well defined inter-layer interface separates logically
> the kernel source into more easily manageable parts. It makes the testing
> easier. A simple and logical lower layer interface makes learning the
> base and writing the code easier; a simple and logical upper layer
> interface enforces and helps clarity in design and implementation. This
> may attract more developers, ease the work of the current ones, and
> increase the kernel quality while decreasing the writing efforts. The
> earlier this happens, the better for us all.
> 

There is already a lot of layering in the kernel.  It seems to be doing 
what you propose to some extent.

> Anti-malware protection: Sources of potentially dangerous content can be
> filtered between the kernel layers by hooked or compiled-in modules. As
> with most other advantages, this is achievable in a non-layered kernel
> too, but is more natural in a layered one. Also, propagation of malware
> between layers is mode difficult.
> 
> Security: A layer, eg. Personality, if properly written, is eventually a
> sandbox. Most exploits that would otherwise allow a user to gain
> superuser access, will give them control over only this layer, not over
> the entire machine. More layers will have to be broken.
> 
> Sandboxing: A layer interface emulator of a lower, eg. Resources layer
> can pass a configurable "virtual machine" to an upper, eg. Personality
> layer. You may run a user or software inside it, passing them any
> resources, real or emulated, or any part of your resources. All
> advantages of a sandbox apply.

Not true.  What you are asking for is userspace protection to kernel 
modules.  You won't get that unless you use a micro-kernel approach, or 
run different parts of the kernel on different (to be i386 arch 
specific) ring in the processor.  Once you get there, you have to deal 
with the various processor errata since not many OSes use rings besides 
0 and 3 (maybe ring 1?).

> User nesting: The traditional Unix user management model has two levels:
> superuser (root) and subusers (ordinary users). Subusers cannot create
> and administrate their subusers, install system-level resources, etc.
> Running, however, a subuser in their own virtual machine and Personality
> layer as its root, will allow tree-like management of users and resources
> usage/access. (Imagine a much enhanced chroot.)
> 

That is differing security models, and it's being worked on with (I 
forget the term) the security module framework.

> Platforming: It is much easier to write only a Personality layer than an
> entire kernel, esp. if you have a layer interface open standard as a
> base. Respectively, it's easier to write only a Resources layer, adding a
> new hardware to the "Supported by Linux" list. This will help increasing
> supported both hardware and platforms. Also, thus you may run any
> platform on any hardware, or many platforms concurrently on the same
> hardware.
> 

There is arch specific, and generic setions of the kernel source tree 
already.  How do you want to improve upon that?

> Heterogeneous distributed resources usage: Under this security model,
> networks of possibly different hardware may share and redistribute
> resources, giving to the users resource pools. Pools may be dynamical,
> thus redistributing the resources flexibly. This mechanism is potentially
> very powerful, and is inherently consistent with the open source spirit
> of cooperativity and freedom.

Single system image clusters are hard enough where each node is the same 
  arch, and very hard, or almost impossible when dealing with mixed 
processor arch or 32/64 bit processors.

See OpenSSI and OpenMosix.

Mike
