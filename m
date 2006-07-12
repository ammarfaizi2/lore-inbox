Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWGLD4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWGLD4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWGLD4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:56:00 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:37618 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932406AbWGLDz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:55:59 -0400
Subject: Re: 2.6.17-mm6
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Keith Mannthey <kmannth@gmail.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20060705172545.815872b6.akpm@osdl.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	 <a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com>
	 <20060705155037.7228aa48.akpm@osdl.org>
	 <a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com>
	 <20060705164457.60e6dbc2.akpm@osdl.org>
	 <20060705164820.379a69ba.akpm@osdl.org>
	 <a762e240607051705h33952e5elf6bd09c1ccea8ab4@mail.gmail.com>
	 <20060705172545.815872b6.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 23:55:21 -0400
Message-Id: <1152676521.8309.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 17:25 -0700, Andrew Morton wrote:
> On Wed, 5 Jul 2006 17:05:49 -0700
> "Keith Mannthey" <kmannth@gmail.com> wrote:
> 
> > On 7/5/06, Andrew Morton <akpm@osdl.org> wrote:
> > > On Wed, 5 Jul 2006 16:44:57 -0700
> > > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > > I guess a medium-term fix would be to add a boot parameter to override
> > > > PERCPU_ENOUGH_ROOM - it's hard to justify increasing it permanently just
> > > > for the benefit of the tiny minority of kernels which are hand-built with
> > > > lots of drivers in vmlinux.
> > 

[snip]

> 
> So you've been hit by the expansion of NR_IRQS which bloats kernel_stat
> which gobbles per-cpu data.
> 
> In 2.6.17 NR_IRQS is 244.  In -mm (due to the x86_64 genirq conversion)
> NR_IRQS became (256 + 32 * NR_CPUS).  Hence the kstat "array" became
> two-dimensional.  It's now O(NR_CPUS^2).
> 
> I don't know what's a sane max for NR_CPUS on x86_64, but that'll sure be a
> showstopper if the ia64 guys try the same trick.
> 
> I guess one fix would be to de-percpuify kernel_stat.irqs[].  Or
> dynamically allocate it with alloc_percpu().

And people wondered why I'm fighting for the robust per_cpu variables.

http://marc.theaimsgroup.com/?l=linux-kernel&m=114785997413023&w=2

Yes there's still problems with this. But if I ever get some more time
to work on it, I would like to solve those issues.  Having that
PERCPU_ENOUGH_ROOM laying around in the kernel is just disgusting ;)

Sorry, for the noise, I have another 2288 more LKML emails to read :)

-- Steve


