Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266565AbUGKLOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266565AbUGKLOu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 07:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266568AbUGKLOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 07:14:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:6806 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266565AbUGKLOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 07:14:46 -0400
Date: Sun, 11 Jul 2004 04:13:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-Id: <20040711041329.22f637d1.akpm@osdl.org>
In-Reply-To: <20040711105936.GA13956@devserv.devel.redhat.com>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<20040711093209.GA17095@elte.hu>
	<20040711024518.7fd508e0.akpm@osdl.org>
	<20040711095039.GA22391@elte.hu>
	<20040711025855.08afbca1.akpm@osdl.org>
	<20040711103020.GA24797@elte.hu>
	<20040711034258.796f8c6a.akpm@osdl.org>
	<20040711105936.GA13956@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> On Sun, Jul 11, 2004 at 03:42:58AM -0700, Andrew Morton wrote:
> > > We do not want to enable preempt for Fedora yet because it
> > > breaks just too much stuff
> > 
> > What stuff?
> 
> just look over all the "fix preempt" stuff that got added to the kernel in
> the last 6 months. Sometimes subtle sometimes less so. From a distribution
> POV I don't want a potential slew of basically impossible to reproduce
> problems, especially this young in 2.6, there are plenty of other problems
> already (and before you ask "which", just look at how many bugs got fixed in
> the last X weeks for any value of X, and look at say acpi issues). 
> Yes I understand this puts you into a bit of a bad position, several distros
> not enabling preempt means that it gets less testing than it should.
> However.. there's only so much issues distros can take and with 2.6 still
> quite fresh...
> 

IOW: "we haven't found any such stuff".  Sounds fuddy to me.
 
> > > (Long-term i'd like to see preempt be used unconditionally - at which
> > > point the 10-line CONFIG_VOLUNTARY_PREEMPT Kconfig and kernel.h change
> > > could go away.)
> > 
> > And "stuff" is already broken on SMP, yes?
> 
> That's the classic preempt "myth"; it's true if you ignore per cpu stuff and
> some other subtle issues ;)

?

Sticking a WARN_ON(!in_atomic()) if CONFIG_PREEMPT into smp_processor_id()
should catch any missed fixes.

> And even then, yes a lot of our drivers are not
> quite SMP safe. Take ISDN or any of the other declared SMP-broken drivers.
> Not to speak of the ones that aren't declared as such yet still are.
> Regardless of Hyperthreading, smp is still quite rare while crappy
> hardware/drivers are not.
> 

Oh I can buy the make-the-bugs-less-probable practical argument, but
sheesh.  If you insist on going this way we can stick the patch in after
2.7 has forked.  I spose.  The patch will actually slow the rate of
improvement of the kernel :(

