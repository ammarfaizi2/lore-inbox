Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267133AbSLDWfa>; Wed, 4 Dec 2002 17:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbSLDWf3>; Wed, 4 Dec 2002 17:35:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18698 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267133AbSLDWf1>; Wed, 4 Dec 2002 17:35:27 -0500
Date: Wed, 4 Dec 2002 14:42:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: "David S. Miller" <davem@redhat.com>, <dan@debian.org>,
       <sfr@canb.auug.org.au>, <linux-kernel@vger.kernel.org>,
       <anton@samba.org>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <3DEE822D.385D2664@mvista.com>
Message-ID: <Pine.LNX.4.44.0212041435550.1745-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Dec 2002, george anzinger wrote:
> 
> On the PARISC I did this (a long time ago in a far away
> place) by unwinding the stack to pick up the registers that
> were saved along the way.  Is this at all feasible?

No. Alpha (and apparently sparc) simply do not save the registers that the
signal handling wants on the stack _at_all_. There are too many registers 
to save at each system call entry point, and 99% of all system calls never 
need it.

The system call return that checks for signals anyway will end up saving a
special stack frame when needed. As will the special signal-related system
calls (sigsuspend() and friends). All of this is not only architecture-
dependent, it is literally coded in assembly language for the
architectures.  See "do_switch_stack()" for alpha.

Anyway, if you wondered why Linux beats every other Unix out there on 
system call overhead, now you know.  And yes, this is important.

		Linus

