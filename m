Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbUBWUzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbUBWUzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:55:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:42956 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261874AbUBWUzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:55:50 -0500
Date: Mon, 23 Feb 2004 12:57:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: torvalds@osdl.org, piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix shmat
Message-Id: <20040223125730.18a8ed5d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0402232127250.13421-100000@dbl.q-ag.de>
References: <Pine.LNX.4.58.0402231035280.3005@ppc970.osdl.org>
	<Pine.LNX.4.44.0402232127250.13421-100000@dbl.q-ag.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> On Mon, 23 Feb 2004, Linus Torvalds wrote:
> >
> > Please. Maybe it might even be worth-while renaming it to "do_sys_shmat()"
> > to make it clear that it's not a "sys_xxx()" at all.
> >
> 
> Below is a patch that renames sys_shmat to do_shmat. Additionally, I've
> replaced the cond_syscall with a conditional inline function.

It doesn't update arch/mips/kernel/scall64-64.S and
arch/mips/kernel/scall64-n32.S?

I'd be inclined to leave it as sys_shmat().  It is logically a syscall, and
the fact that everyone except mips (and ia64) sticks a multiplexer in front
of it is a sad historical note.

It's simply a matter of getting the appropriate prototype in scope for all
the C callers.  For now, I'd be inclined to bung the prototype in kernel.h,
because Randy's syscalls.h patches will fix all this for real in a week or
two.
