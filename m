Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSHTTVZ>; Tue, 20 Aug 2002 15:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSHTTVZ>; Tue, 20 Aug 2002 15:21:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58635 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317181AbSHTTVY>; Tue, 20 Aug 2002 15:21:24 -0400
Date: Tue, 20 Aug 2002 12:29:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Luca Barbieri <ldb@ldb.ods.org>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (re-xmit): kprobes for i386
In-Reply-To: <1029844464.1745.49.camel@ldb>
Message-ID: <Pine.LNX.4.44.0208201227490.14734-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20 Aug 2002, Luca Barbieri wrote:
> How about checking %cs in assembly and branching off for the kernel-mode
> case?
> 
> Something like this:
> ENTRY(debug)
> 	testl $0x3, 4(%esp)
> 	jz handle_kernel_mode_debug

That's not correct, you can have the low bits of CS clear even from user 
mode if the thing is in vm86 mode. 

See the full test at the top of "ret_from_intr" (the "mix EFLAGS and CS" 
thing - it's a bit funky).

		Linus

