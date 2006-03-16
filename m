Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWCPJBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWCPJBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 04:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbWCPJBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 04:01:54 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:38071
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751159AbWCPJBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 04:01:54 -0500
Subject: Re: [patch 5/8] hrtimer remove state field
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0603152055380.16802@scrub.home>
References: <20060312080316.826824000@localhost.localdomain>
	 <20060312080332.274315000@localhost.localdomain>
	 <Pine.LNX.4.64.0603121302590.16802@scrub.home>
	 <1142169010.19916.397.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121422180.16802@scrub.home>
	 <1142170505.19916.402.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121444530.16802@scrub.home>
	 <1142172917.19916.421.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121523320.16802@scrub.home>
	 <1142175286.19916.459.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121608440.17704@scrub.home>
	 <1142178108.19916.475.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121650230.16802@scrub.home>
	 <1142180796.19916.497.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603152055380.16802@scrub.home>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 10:01:53 +0100
Message-Id: <1142499713.29968.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman,

> I have an idea what might have happened. You don't advance the pending 
> state, if the signal isn't queued, so that the pending state is screwed up 
> afterwards. Although I don't see how it could crash the kernel (it has 
> only the potential to mess up the timer queue via hrtimer_forward() a 
> bit), but I don't know what other patches were applied.

Good catch, but I dont see how it would trigger the bug.

> For example no current user restarts an active timer, which could be used 
> to simplify the locking.

How does this simplify the locking ? It just removes the
hrtimer_cancel() call in hrtimer_start() and makes the
switch_hrtimer_base() code a bit simpler. 

The general locking rules would be still the same and I dont see
increased flexibility at all.

> If we tightened a bit what a user is allowed to 
> do, we could gain flexibility on the other side, e.g. allow drivers to 
> create timer sources or how to integrate cpu timer.

-ENOPARSE. Can you please explain what "allow drivers to create timer
sources" means and why the above locking is in the way ?

	tglx


