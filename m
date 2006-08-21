Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWHUCgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWHUCgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 22:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWHUCgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 22:36:25 -0400
Received: from mother.openwall.net ([195.42.179.200]:21718 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750809AbWHUCgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 22:36:24 -0400
Date: Mon, 21 Aug 2006 06:32:17 +0400
From: Solar Designer <solar@openwall.com>
To: Julio Auto <mindvortex@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop.c: kernel_thread() retval check
Message-ID: <20060821023217.GA23416@openwall.com>
References: <20060819234629.GA16814@openwall.com> <1156097717.4051.26.camel@localhost.localdomain> <20060820223442.GA21960@openwall.com> <1156115468.4051.80.camel@localhost.localdomain> <20060820225823.GD602@1wt.eu> <18d709710608201859o7f1c8075wab0e71cd85814967@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18d709710608201859o7f1c8075wab0e71cd85814967@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 10:59:41PM -0300, Julio Auto wrote:
> On 8/20/06, Willy Tarreau <w@1wt.eu> wrote:
> >I think I will be starting to ask for forward porters for the fixed to 2.4
> >that need to be ported to 2.6 too.
> 
> Well, actually I'd be glad to help. In fact, with this particular 2.4
> patch at hand, fixing 2.6 seems incredbly straight-forward (or am I
> getting ahead of myself?)

You need to make sure that the cleanup code added with the patch matches
the loop device initialization preceding the kernel_thread() call.  You
should not blindly take the cleanup code out of the 2.4 patch and apply
it to 2.6 - it might not be correct for 2.6.

> However, I wasn't able to reproduce the bug in my system just by
> running losetup under strace. Maybe 2.6.15-1.2054_FC5 has it patched?

No.  But you won't be able to reproduce this with strace on 2.6 since
2.6's kernel_thread() uses CLONE_UNTRACED instead of failing on ptrace.
You'll probably need to temporarily replace the kernel_thread() call in
loop.c with -EAGAIN to comfortably test your cleanup code without
forcing the system to run out of resources.

Alexander
