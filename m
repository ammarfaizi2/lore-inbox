Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267096AbTAFSmA>; Mon, 6 Jan 2003 13:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267097AbTAFSmA>; Mon, 6 Jan 2003 13:42:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1296 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267096AbTAFSl7>; Mon, 6 Jan 2003 13:41:59 -0500
Date: Mon, 6 Jan 2003 10:49:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Luca Barbieri <ldb@ldb.ods.org>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Set TIF_IRET in more places
In-Reply-To: <20030106181737.GA6867@ldb>
Message-ID: <Pine.LNX.4.44.0301061046180.13284-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Jan 2003, Luca Barbieri wrote:
> 
> 1. vfork seems to not set any TIF_ flags so a ptracer setting regs
> while a vforking task is stopped in ptrace_notify called from vfork
> would result in clobbered %ecx and %edx.

vfork and clone do not work at all with sysenter due to user stack issues.
We should document that (it's already de-facto documented in glibc, but it 
should be explicitly documented somewhere).

Btw, the vfork/clone problems aren't sysenter-specific per se: they are 
really a generic problem with any non-inlined system call mechanism. In 
particular, vfork() really cannot afford to have a stack frame.

> 2. A ptracer could use %ecx or %edx to pass information to signal
> handlers and this would not work with the current [rt_]sigsuspend.

Yes. Although I don't see why it should matter, really. 

		Linus

