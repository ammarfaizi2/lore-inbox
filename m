Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUGBUA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUGBUA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 16:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUGBUA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 16:00:27 -0400
Received: from nacho.alt.net ([207.14.113.18]:45232 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S264911AbUGBUAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 16:00:24 -0400
Date: Fri, 2 Jul 2004 13:00:19 -0700 (PDT)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
In-Reply-To: <20040625121743.GA24896@logos.cnet>
Message-ID: <Pine.LNX.4.44.0407021231040.22597-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, Marcelo Tosatti wrote:
> On Wed, Jun 23, 2004 at 06:50:48PM -0700, Chris Caputo wrote:
> > Is it safe to assume that the x86 version of atomic_dec_and_lock(), which
> > iput() uses, is well trusted?  I figure it's got to be, but doesn't hurt
> > to ask.
> 
> Pretty sure it is, used all over. You can try to use non-optimize version 
> at lib/dec_and_lock.c for a test.

Hi Marcelo.  Just an update...

I normally run irqbalance on these systems which are experiencing the
inode_unused list corruption problem.

I disabled irqbalance on two servers which have experienced the
inode_unused list corruption problem and they have now been running
without crashing for considerably longer than they had been before.  The
length of run time without problem is not yet conclusive, but I wanted to
give you a heads-up on my progress.

My current theory is that occasionally when irqbalance changes CPU
affinities that the resulting set_ioapic_affinity() calls somehow cause
either inter-CPU locking or cache coherency or ??? to fail.

I CC'ed Arjan because this involves irqbalance, although I'd expect the
fix will be needed in set_ioapic_affinity() or related kernel code.

Any insights welcome.  I am not sure what to do next except wait and see
if these servers with irqbalance disabled continue to stay up.

Chris

