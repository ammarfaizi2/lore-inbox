Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbSIYSIm>; Wed, 25 Sep 2002 14:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbSIYSIm>; Wed, 25 Sep 2002 14:08:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60429 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262045AbSIYSIl>; Wed, 25 Sep 2002 14:08:41 -0400
Date: Wed, 25 Sep 2002 11:16:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <Pine.LNX.4.44.0209251051190.6169-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0209251113530.1817-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, Ingo Molnar wrote:
>
> EIP is at sys_gettimeofday [kernel] 0x84
> Call Trace: [<c0112a40>] do_page_fault [kernel] 0x0
> [<c0107973>] syscall_call [kernel] 0x7

At a minimum, fix this to:

 - not print out that stupid "kernel" thing. Of _course_ it is the kernel. 
   Modules can put their module name to clarify, but the core kernel 
   certainly doesn't "clarify" anything by putting "kernel" there.

 - print out offset/length like the user-space ksymoops does. Without the 
   offset the thing is useless, since you still need the real address to 
   actually look up which instruction faulted.

		Linus

