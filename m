Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267948AbTBSDZI>; Tue, 18 Feb 2003 22:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267956AbTBSDZH>; Tue, 18 Feb 2003 22:25:07 -0500
Received: from dp.samba.org ([66.70.73.150]:62907 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267948AbTBSDY1>;
	Tue, 18 Feb 2003 22:24:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module changes 
In-reply-to: Your message of "Tue, 18 Feb 2003 16:56:11 BST."
             <15954.22427.557293.353363@gargle.gargle.HOWL> 
Date: Wed, 19 Feb 2003 09:24:00 +1100
Message-Id: <20030219033429.990F62C0CA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15954.22427.557293.353363@gargle.gargle.HOWL> you write:
> Rusty Russell writes:
>  > D: This adds percpu support for modules.  A module cannot have more
>  > D: percpu data than the base kernel does (on my kernel 5636 bytes).
> 
> This limitation is quite horrible.
> 
> Does the implementation have to be perfect? The per_cpu API can easily
> be simulated using good old NR_CPUS arrays:

The problem is that then you have to have to know whether this is a
per-cpu thing created in a module, or not, when you use it 8(

There are two things we can use to alleviate the problem.  The first
would be to put a minimal cap on the per-cpu data size (eg. 8k).  The
other possibility is to allocate on an object granularity, in which
case the rule becomes "no single per-cpu object can be larger than
XXX", but the cost is to write a mini allocator.

I agree with you (and John) about disliking the limitation, but is it
worse than the current no per-cpu stuff in modules at all?

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
