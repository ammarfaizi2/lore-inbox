Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268575AbUJTQdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268575AbUJTQdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268490AbUJTQbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:31:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:47503 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268588AbUJTQ1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:27:49 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Lee Revell <rlrevell@joe-job.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@novell.com>,
       Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <Pine.LNX.4.53.0409121133480.2297@montezuma.fsmlabs.com>
References: <593560000.1094826651@[10.10.2.4]>
	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
	 <20040910151538.GA24434@devserv.devel.redhat.com>
	 <20040910152852.GC15643@x30.random>
	 <20040910153421.GD24434@devserv.devel.redhat.com>
	 <20040912141701.GA21626@nocona.random> <622230000.1095001434@[10.10.2.4]>
	 <Pine.LNX.4.53.0409121133480.2297@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1098289667.1429.52.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 12:27:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-12 at 11:45, Zwane Mwaikambo wrote:
> yOn Sun, 12 Sep 2004, Martin J. Bligh wrote:
> 
> > --Andrea Arcangeli <andrea@novell.com> wrote (on Sunday, September 12, 2004 16:17:01 +0200):
> > 
> > > On Fri, Sep 10, 2004 at 05:34:21PM +0200, Arjan van de Ven wrote:
> > >> disabling is actually not a bad idea; hard irq handlers run for a very short
> > > 
> > > you mean hard irq handlers "should run" for a very short time. There can
> > > be slow hardware that needs a long time, and fast hardware that needs a
> > > short time, and in turn it makes perfect sense to allow nesting to give
> > > low latency to the "fast" onces, like it has always happened so far (not
> > > only in linux AFIK). Disabling nesting completely sounds a very bad
> > > idea to me, when "limiting nesting" can be achieved easily as confirmed
> > > by Alan too.
> > 
> > IIRC, what we did in PTX was have 16 SPL levels, each interrupt was assigned
> > a prio, and higher prio interrupts could interrupt lower prio ones (but not
> > the same prio or higher). There's some support for that in the APIC, I think,
> > something like the high nybble is prio, and the low nybble is just an index.
> 
> Currently we do use priorities on i386/APIC, albeit unintentionally by 
> assigning higher IRQs higher vectors resulting in a higher priority.

Are these really "priorities" in real life?  I am not being facetious,
this is actually a common myth among users, that you will get better
performance by putting the device you care about on a "high priority"
irq or tweaking the priorities in your local APIC.  My impression was
that this is pointless because it only determines which interrupt the
CPU sees first if they fire at _exactly_ the same time.  Since we allow
interrupt to nest this does not matter in practice, right?

Lee 

