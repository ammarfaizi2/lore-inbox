Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWIJNn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWIJNn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWIJNn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:43:56 -0400
Received: from ns1.suse.de ([195.135.220.2]:11473 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932159AbWIJNnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:43:55 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
Date: Sun, 10 Sep 2006 15:55:51 +0200
User-Agent: KMail/1.9.1
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
References: <20060908011317.6cb0495a.akpm@osdl.org> <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu>
In-Reply-To: <20060910132614.GA29423@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609101555.52211.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 September 2006 15:26, Ingo Molnar wrote:
> * Andi Kleen <ak@suse.de> wrote:
> > > Basically, non-atomic setup of basic architecture state _is_ going to
> > > be a nightmare, lockdep or not, especially if it uses common
> > > infrastructure like 'current', spin_lock() or even something as simple
> > > as C functions. (for example the stack-footprint tracer was once hit by
> > > this weakness of the x86_64 code)
> >
> > I disagree with that.  The nightmare is putting stuff that needs so
> > much infrastructure into the most basic operations.
>
> ugh, "having a working current" is "so much infrastructure" ??

Together with stacktrace the infrastructure needed is quite
considerable.

>
> the i686 PDA patches introduce tons of early_current() uses. While i
> like the new PDA code, its bootstrap (like x86_64's PDA bootstrap) is
> too fragile in my opinion, and it will regularly hit instrumenting
> patches.

Or the instrumentation patches just always need to check
some global variable. Maybe system_state could be extended or something.

>
> Perhaps the early setup code (if we really want to do it all in C)

Sorry but moving it into assembler would be just crazy.

> should be moved into 32-bit early boot userspace code (like
> compressed/misc.c) and it will thus not depend on any kernel
> infrastructure.

Ok I guess it would make sense to add a i386_start_kernel to i386 and
initialize the boot PDA there. I would also move early_cpu_init
into there because that also avoids quite some mess later.

-Andi
