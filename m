Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTAOEdf>; Tue, 14 Jan 2003 23:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTAOEdf>; Tue, 14 Jan 2003 23:33:35 -0500
Received: from dp.samba.org ([66.70.73.150]:35714 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261463AbTAOEde>;
	Tue, 14 Jan 2003 23:33:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [MODULES] fix weak symbol handling 
In-reply-to: Your message of "Tue, 14 Jan 2003 17:12:50 -0800."
             <20030114171250.C5751@twiddle.net> 
Date: Wed, 15 Jan 2003 15:39:43 +1100
Message-Id: <20030115044228.BD6C02C04D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030114171250.C5751@twiddle.net> you write:
> On Tue, Jan 14, 2003 at 07:39:44PM +1100, Rusty Russell wrote:
> > After that's reverted, here's my implementation.  Richard?
> 
> Nope.  Doesn't handle undef weak.  Handling of defined weak
> I'm not sure is necessary at all; I can't think of any good
> use for it in the kernel.

I didn't know about undefined weak symbols.  I was thinking:

int nosupport_function(void)
{
	return -ENOSYS;
}

extern int support_function(void)
	__attribute__((alias("nosupport_function"), weak));

....

int init(void)
{
	/* Or you could simply call it... */
	if (support_function == nosupport_function)
		...


Of course, you can use symbol_get and symbol_put, too, but they don't
work if !CONFIG_MODULES: I chose to implement that case as simply a
reference, so you'll get a link failure: see linux/module.h.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
