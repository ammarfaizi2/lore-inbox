Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265813AbUFOSRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265813AbUFOSRp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUFOSRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:17:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22400 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265813AbUFOSRm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:17:42 -0400
Date: Tue, 15 Jun 2004 14:15:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Dean Nelson <dcn@sgi.com>
cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: calling kthread_create() from interrupt thread
In-Reply-To: <20040615180525.GA17145@sgi.com>
Message-ID: <Pine.LNX.4.53.0406151412350.2353@chaos>
References: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com>
 <1087321777.2710.43.camel@laptop.fenrus.com> <20040615180525.GA17145@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2004, Dean Nelson wrote:

> On Tue, Jun 15, 2004 at 07:49:37PM +0200, Arjan van de Ven wrote:
> > On Tue, 2004-06-15 at 19:42, Dean Nelson wrote:
> > > I'm working on a driver that needs to create threads that can sleep/block
> > > for an indefinite period of time.
> > >
> > >     . Can kthread_create() be called from an interrupt handler?
> >
> > no
> >
> > >
> > >     . Is the cost of a kthread's creation/demise low enough so that one
> > >       can, as often as needed, create a kthread that performs a simple
> > >       function and exits?  Or is the cost too high for this?
> >
> > for that we have keventd in 2.4, work queues in 2.6
>
> As mentioned above, it is possible for this "simple" function to sleep/block
> for an indefinite period of time. I was under the impression that one
> couldn't block a work queue thread for an indefinite period of time. Am
> I mistaken?
>
> Thanks,
> Dean
>

If you make a kernel thread, it can sleep forever if it wants, you
can wake it up with wake_up_interruptible() from an interrupt after
you have laid out the work you want it to do. That kernel thread
has access to all your kernel data space, plus can spin-lock to
prevent an interrupt from changing things in critical sections,
etc.

It's the greatest thing since sliced bread.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


