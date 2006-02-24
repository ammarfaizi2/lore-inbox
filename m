Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWBXDYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWBXDYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 22:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWBXDYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 22:24:55 -0500
Received: from mx1.rowland.org ([192.131.102.7]:64268 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751280AbWBXDYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 22:24:54 -0500
Date: Thu, 23 Feb 2006 22:24:53 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Andi Kleen <ak@suse.de>
cc: sekharan@us.ibm.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] The idle notifier chain should be atomic
In-Reply-To: <p737j7l3ab7.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.44L0.0602232218280.19776-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Feb 2006, Andi Kleen wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > This patch (as658) makes the idle_notifier in x86_64 and idle_chain in
> > s390 into atomic notifier chains rather than blocking chains.  This is
> > necessary because they are called during IRQ handling as CPUs leave and
> > enter the idle state.
> 
> Actually they aren't. While the code is called from the interrupt
> handler logically it belong to the idle thread, not the interrupt handler.
> They are only called when the interrupt directly interrupts the idle 
> thread, so no atomicity needed.

In do_IRQ() there's a call to exit_idle(), which calls __exit_idle(), 
which runs the idle_notifier call chain.  Surely you're not saying that we 
can do a down_read() in this pathway?

And actually the chain's type doesn't seem to make much difference, since
at the moment there's nothing in the vanilla kernel that registers for the
idle_notifier chain.

> -Andi
> 
> P.S.: Please cc maintainers in the future.

Yes, I should have sent the patch to you too.  I apologize.

Alan Stern

