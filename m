Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293035AbSCRX7V>; Mon, 18 Mar 2002 18:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293027AbSCRX7L>; Mon, 18 Mar 2002 18:59:11 -0500
Received: from [202.135.142.194] ([202.135.142.194]:21521 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S293035AbSCRX6z>; Mon, 18 Mar 2002 18:58:55 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas 
In-Reply-To: Your message of "Mon, 18 Mar 2002 08:35:11 BST."
             <20020318083511.A19810@wotan.suse.de> 
Date: Tue, 19 Mar 2002 11:02:09 +1100
Message-Id: <E16n74r-00024V-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020318083511.A19810@wotan.suse.de> you write:
> On Sun, Mar 17, 2002 at 06:17:32PM +1100, Rusty Russell wrote:
> > On Fri, 15 Mar 2002 10:13:09 +0100
> > Andi Kleen <ak@suse.de> wrote:
> > 
> > > On Fri, Mar 15, 2002 at 03:07:27PM +1100, Rusty Russell wrote:
> > > > They must return an lvalue, otherwise they're useless for 50% of cases
> > > > (ie. assignment).  x86_64 can still use its own mechanism for
> > > > arch-specific per-cpu data, of course.
> > > 
> > > Assignment should use an own macro (set_this_cpu()) or use per_cpu().
> > 
> > So, we'd have "get_this_cpu(x)" and "set_this_cpu(x, y)".  So far, so good.
> > 
> > 	struct myinfo
> > 	{
> > 		int x;
> > 		int y;
> > 	};
> > 
> > 	static struct myinfo mystuff __per_cpu_data;
> > 
> > Now how do we set mystuff.x on this CPU?
> 
> set_this_cpu(mystuff.x, y) could be eventually supported properly, it just
> needs compiler work (and before that can use address calculation & reference)

I think the effort would be better spent on teaching the compiler
about these special variables, and how to do efficient assignments on
them.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
