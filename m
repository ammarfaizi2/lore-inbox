Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268594AbUI2PGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268594AbUI2PGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268592AbUI2PGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:06:35 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:32203 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268594AbUI2Oxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:53:53 -0400
Date: Wed, 29 Sep 2004 16:53:44 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20040929145344.GA22008@dualathlon.random>
References: <20040925162252.GN3309@dualathlon.random> <1096272553.6572.3.camel@laptop.fenrus.com> <20040927130919.GE28865@dualathlon.random> <20040928194351.GC5037@devserv.devel.redhat.com> <20040928221933.GG4084@dualathlon.random> <20040929060521.GA6975@devserv.devel.redhat.com> <20040929141151.GJ4084@dualathlon.random> <20040929142521.GB22928@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929142521.GB22928@devserv.devel.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 04:25:21PM +0200, Arjan van de Ven wrote:
> the patch posted recently on this list reduced it to 1Mb.

I must have overlooked that post, sorry (I was just reading latest
kernel CVS).

> > > MAP_FIXED is to be used only on things YOU mmaped before. 
> > 
> > where is that written?
> 
> it's basic common sence 

that sounds a bit overoptimistic assumption to me, especially if it was
not written anywhere. Plus applications do use MAP_FIXED, and myself,
the only place I would use it, is slightly below the 1G mark. that's the
safest place if you can find today, especially if you do heavy mmaps
(normally the brk never gets as high as 1G, no matter what the app is
doing, while you can easily reach the stack, or easily go below 1G with
topdown).

> I know you can write a testcase, one can write a testcase even for your
> proposed patch showing breakage.

my patch, will never genrate random mm corruption that will make the app
behave randomly at runtime.

The only testcase you can write for my patch, is a testcase that will
get a sigsegv and it'll get killed gracefully, like it happened to java
in the past. that's a bit different than random mm corruption. And the
only application where this testcase was suprios todate was java, which
got fixed meanwhile, and nothing wrong could ever happen with a spurious
sigsegv. if an application can't handle sigsegv gracefully, then the
application itself is broken, since any software bug can always generate
the sigsegv.

if the overridden mmap with MAP_FIXED would be guaranteed to generate a
sigsegv I wouldn't be talking about that right now.

> You are wrong; the default is 8Mb stack limit in the kernel; I absolutely do
> not see where you claim from "most people run with unlimited stack" comes
> from.

maybe I'm biased because I do run with unlimited stack? And I'm not
going to change that since I really like recursion. I want a stack-gap
instead, to be sure to get a sisgsegv if the recursion overflows on the
heap ;)

> I am aware of 2 applications breaking. Both did

oh, so you see, I wasn't *that* wrong if you're already aware of 2 apps
breaking.

Frankly I don't see the need of these kind of 32bit hacks that may break
stuff, when people is finally moving x86-64.
