Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267482AbUG2Q3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267482AbUG2Q3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUG2Q1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:27:11 -0400
Received: from nacho.alt.net ([207.14.113.18]:48068 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S267704AbUG2QWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:22:46 -0400
Date: Thu, 29 Jul 2004 09:22:40 -0700 (PDT)
To: Arjan van de Ven <arjanv@redhat.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
In-Reply-To: <20040729122107.GA1024@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0407290909410.30975-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004, Arjan van de Ven wrote:
> On Thu, Jul 29, 2004 at 07:57:55AM -0300, Marcelo Tosatti wrote:
> > On Thu, Jul 29, 2004 at 09:54:29AM +0200, Arjan van de Ven wrote:
> > > On Wed, Jul 28, 2004 at 11:27:41PM -0700, Chris Caputo wrote:
> > > > On Wed, 28 Jul 2004, Marcelo Tosatti wrote:
> > > > > Changing the affinity writes new values to the IOAPIC registers, I can't see
> > > > > how that could interfere with the atomicity of a spinlock operation. I dont
> > > > > understand why you think irqbalance could affect anything.
> > > > 
> > > > Because when I stop running irqbalance the crashes no longer happen.
> > > 
> > > what is the irq distribution when you do that?
> > > Can you run irqbalance for a bit to make sure there's a static distribution
> > > of irq's and then disable it and see if it survives ?
> > 
> > Chris, Yes I'm also running irqbalance. 
> > 
> > Arjan, what is an easy way for me to make irqbalance change the affinity
> > as crazy on the SMP 8way box, just for a test?
> 
> there is a sleep(10 seconds) in the code, if you change that to something
> really short and then cause irq burst rates on different devices...

I messed with that at one point and didn't have a noticible improvement in
getting the crash to happen.  I'd recommend not going lower than sleep(1)
since that still gives irqbalance some time to amass stats prior to the
next iteration.

On Thu, 29 Jul 2004, Arjan van de Ven wrote:
> what is the irq distribution when you do that?

You mean like what does "cat /proc/interrupts" show?  One thing I could do
is have a "watch -n 1 cat /proc/interrupts" running in one screen while
the tests are running, and then when the crash happens copy/paste the
results.  Would that be useful?

> Can you run irqbalance for a bit to make sure there's a static
> distribution of irq's and then disable it and see if it survives ?

I've had mixed results with this.  In theory the list corruption can
happen while irqbalance has been running, and then after stopping it, days
later the crash can happen when a corrupted list item is finally accessed.

Should I try the run-once/oneshot feature of irqbalance on boot, and then
leave it off and see if anything happens?

Thanks,
Chris


