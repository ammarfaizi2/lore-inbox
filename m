Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbWGEXfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWGEXfz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWGEXfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:35:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965067AbWGEXfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:35:54 -0400
Date: Wed, 5 Jul 2006 16:35:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: arjan@infradead.org, torvalds@osdl.org, tglx@linutronix.de, mingo@elte.hu,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
Message-Id: <20060705163530.bfe5a8f0.akpm@osdl.org>
In-Reply-To: <20060705162425.547f3d3f.rdunlap@xenotime.net>
References: <1151885928.24611.24.camel@localhost.localdomain>
	<20060702173527.cbdbf0e1.akpm@osdl.org>
	<Pine.LNX.4.64.0607031007421.12404@g5.osdl.org>
	<1151947627.3108.39.camel@laptopd505.fenrus.org>
	<20060705162425.547f3d3f.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 16:24:25 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Mon, 03 Jul 2006 19:27:07 +0200 Arjan van de Ven wrote:
> 
> > On Mon, 2006-07-03 at 10:13 -0700, Linus Torvalds wrote:
> > >         #ifndef xyzzy
> > >         #define zyzzy() /* empty */
> > >         #endif
> > > 
> > 
> > now if you write it as
> > 
> > #define zyzzy() do { ; } while (0)
> > 
> > it even works in a
> > 
> > if (foo())
> > 	zyzzy();
> > bar();
> > 
> > scenario 
> > 
> > (I know you know that, just pointing that out before people copy your
> > example :-)
> 
> OK, I'll bite.  What part of Linus's macro doesn't work.
> I compiled your foo/zyzzy/bar example with both his "empty"
> macro and the do-while macro.  Same code produced both ways,
> no compile warnings/errors.
> 

	if (foo())
		;

will generate `warning: empty body in an if-statement' when compiled with -W.

We go round this loop regularly.  Maybe someone should write it up.  Meanwhile,
use do{}while(0) and be happy and secure.
