Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424660AbWKPVdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424660AbWKPVdz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424661AbWKPVdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:33:55 -0500
Received: from mail.timesys.com ([65.117.135.102]:6614 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP
	id S1424660AbWKPVdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:33:54 -0500
Subject: Re: BUG: cpufreq notification broken
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <Pine.LNX.4.44L0.0611161625020.2460-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0611161625020.2460-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 22:36:34 +0100
Message-Id: <1163712994.10333.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 16:26 -0500, Alan Stern wrote:
> On Thu, 16 Nov 2006, Thomas Gleixner wrote:
> 
> > There is another issue with this SRCU change:
> > 
> > The notification comes actually after the real change, which is bad. We
> > try to make the TSC usable by backing it with pm_timer accross such
> > states, but this behaviour breaks the safety code.
> 
> I don't understand.  Sending notifications is completely separate from 
> setting up the notifier chain's head.  The patch you mentioned didn't 
> touch the code that sends the notifications.

Yeah, my bad. It just uses rcu based locking, but its still synchronous.

I have to dig deeper, why the change of the frequency happens _before_
the notifier arrives.

	tglx


