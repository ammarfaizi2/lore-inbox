Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbTBQCxY>; Sun, 16 Feb 2003 21:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbTBQCxJ>; Sun, 16 Feb 2003 21:53:09 -0500
Received: from dp.samba.org ([66.70.73.150]:52690 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266041AbTBQCxF>;
	Sun, 16 Feb 2003 21:53:05 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Werner Almesberger <wa@almesberger.net>, kuznet@ms2.inr.ac.ru,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org,
       torvalds@tranmseta.com
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-reply-to: Your message of "Fri, 14 Feb 2003 13:49:04 BST."
             <Pine.LNX.4.44.0302141334560.1336-100000@serv> 
Date: Mon, 17 Feb 2003 12:59:43 +1100
Message-Id: <20030217030304.5C9AD2C2D3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302141334560.1336-100000@serv> you write:
> Rusty, I'm asking all these questions on purpose, I want to help you to 
> understand the complete problem and how limited your solutions are. So 
> either please answer my questions or point out the mistakes in my 
> argumentation.

There were two major changes in the module code.  The first was to
simplify the userland interface, from:

	sys_create_module(name, size)
	sys_query_module(...) (a 5-way multiplexed syscall)
	sys_init_module(name, ptr)

to:
	sys_init_module(ptr, len, userargs)

To argue against this change is a demonstration of lack of
understanding, or a complete lack of taste.

The second change was the speed up one system of module locking in the
kernel which wasn't racy, and deprecate the other system which was
racy in 99% of its uses.  That is all.

Did it solve all the races in the kernel?  Of course not.  But it's
simple to use, already well understood in the kernel, and avoids
massive changes.  It also allows connection tracking to be properly
modularized, which was my long-lost original purpose.

I've repeated this enough now, I think.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
