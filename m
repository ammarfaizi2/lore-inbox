Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWJETrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWJETrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWJETrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:47:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750886AbWJETq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:46:58 -0400
Date: Thu, 5 Oct 2006 12:46:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
Message-Id: <20061005124601.94ed7194.akpm@osdl.org>
In-Reply-To: <18975.1160058127@warthog.cambridge.redhat.com>
References: <20061002132116.2663d7a3.akpm@osdl.org>
	<20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	<20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	<18975.1160058127@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2006 15:22:07 +0100
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > These should just use __get_cpu_var().
> 
> Done.
> 
> > And could we please remove the irq_regs macro?
> 
> Done.
> 
> > I think the change is good.  But I don't want to maintain this whopper
> > out-of-tree for two months!  If we want to do this, we should just smash it
> > in and grit our teeth.  But I am a bit concerned about the non-x86
> > architectures.  I assume they'll continue to compile-and-work?
> 
> Well, it seems that IA64 and MIPS don't build as of 2.6.19-rc1 without my
> having to do anything.  i386, x86_64, powerpc and frv build for at least one
> configuration each.  The other archs I haven't touched, so will definitely
> break.
> 
> Can those arch maintainers give me patches?
> 
> 
> Anyway, I've made a GIT tree with just IRQ my patches in.  It can be browsed
> at:
> 
> 	http://git.infradead.org/?p=users/dhowells/irq-2.6.git;a=shortlog
> 
> Or pulled from:
> 
> 	git://git.infradead.org/~dhowells/irq-2.6.git
> 
> David
> 
> ---
> The following changes since commit d223a60106891bfe46febfacf46b20cd8509aaad:
>   Linus Torvalds:
>         Linux 2.6.19-rc1
> 
> are found in the git repository at:
> 
>   git://git.infradead.org/~dhowells/irq-2.6.git
> 

A quick survey of the wreckage:

- Dmitry's input git tree breaks a bit

- five of Greg's USB patches need fixing

- a few random -mm patches need touchups

- The hrtimer+dynticks i386 patch takes rather a hit and will need redoing.

So, not too bad at all.  It's a bit rough on the poor old arch maintainers,
but it's pretty simple stuff.

I'd say let's do it...
