Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbTGDTZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbTGDTZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:25:14 -0400
Received: from [213.39.233.138] ([213.39.233.138]:15285 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266134AbTGDTZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:25:01 -0400
Date: Fri, 4 Jul 2003 21:38:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030704193848.GG22152@wohnheim.fh-wedel.de>
References: <20030704174558.GC22152@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0307041217180.1748-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0307041217180.1748-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 July 2003 12:21:23 -0700, Linus Torvalds wrote:
> On Fri, 4 Jul 2003, Jörn Engel wrote:
> > 
> > This is the generic part of the signal stack fixes, it simply
> > introduces a new PF-flag that indicates whether we are using the
> > signal stack right now or not.
> 
> My reason for disliking this patch is that it adds user-space information 
> to the kernel - in a place where user space cannot get at it.

Which is the whole point of it.

> In particular, any traditional cooperative user-space threading package
> wants to switch its own stack around, and they all do it by just changing
> %esp directly. The whole point of such threading is that it's _fast_,
> since it doesn't need any kernel support (and since it's cooperative, you
> can avoid locking).
> 
> The old "optimization" that you didn't like was not an optimization at 
> all: it got the case of user space changing stacks _right_, while still 
> allowing yet another stack for signal handling and exiting the signal by 
> hand.

So some application has it's signal handler on the signal stack and
instead of returning to the kernel, it detect where it left off before
the signal, mangles the last two stack frames, and goes back directly?

If this is correct, it definitely saves a lot of time, but it also
means that the kernel has no way to ever detect a broken signal
handler, if it operates from the signal stack.

What is the point of the seperate signal stack anyway.  I like it,
because it allows me to handle signals, even when the normal stack is
broken for some reason.  So the point is robustness, not performance.
If that is the only point, I don't mind making the signal stack a bit
slower, but even more robust.

Jörn

-- 
I can say that I spend most of my time fixing bugs even if I have lots
of new features to implement in mind, but I give bugs more priority.
-- Andrea Arcangeli, 2000
