Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWDRRdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWDRRdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 13:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWDRRdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 13:33:49 -0400
Received: from thunk.org ([69.25.196.29]:51872 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750951AbWDRRds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 13:33:48 -0400
Date: Tue, 18 Apr 2006 12:35:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rddunlap@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
Subject: Re: irqbalance mandatory on SMP kernels?
Message-ID: <20060418163539.GB10933@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Lee Revell <rlrevell@joe-job.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	"Robert M. Stockmann" <stock@stokkie.net>,
	linux-kernel@vger.kernel.org, Randy Dunlap <rddunlap@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Andre Hedrick <andre@linux-ide.org>,
	Manfred Spraul <manfreds@colorfullife.com>,
	Alan Cox <alan@redhat.com>, Kamal Deen <kamal@kdeen.net>
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net> <4443A6D9.6040706@mbligh.org> <1145286094.16138.22.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145286094.16138.22.camel@mindpipe>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 11:01:33AM -0400, Lee Revell wrote:
> > There is an in-kernel IRQ balancer. Redhat just choose to turn it
> > off, and do it in userspace instead. You can re-enable it if you
> > compile your own kernel.
> 
> Round-robin IRQ balancing is inefficient anyway.  You'd get better cache
> utilization letting one CPU take them all.

IIRC, Van Jacobsen at his Linux.conf.au presentation made a pretty
strong argument that irq balancing was never a good idea, describing
them as a George Bush-like policy.  "Ooh, interrupts are hurting one
CPU --- let's hurt them **all** and trash everybody's cache!"

Which brings up an interesting question --- why do we have an IRQ
balancer in the kernel at all?  Maybe the scheduler's load balancer
should take this into account so that processes that have the
misfortune of getting assigned to the wrong CPU don't get hurt too
badly (or maybe if we have enough cores/CPU's we can afford to
dedicate one or two CPU's to doing nothing but handling interrupts);
but spreading IRQ's across all of the CPU's doesn't seem like it's
ever the right answer.

						- Ted
