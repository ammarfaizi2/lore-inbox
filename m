Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVK0WD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVK0WD4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 17:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVK0WD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 17:03:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:33745 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751128AbVK0WD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 17:03:56 -0500
Date: Sun, 27 Nov 2005 14:03:29 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Keith Owens <kaos@sgi.com>, ak@suse.de, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       paulmck@us.ibm.com, Douglas_Warzecha@dell.com, Abhay_Salunke@dell.com,
       achim_leubner@adaptec.com, dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain
Message-ID: <20051127220329.GA17786@kroah.com>
References: <20051127172725.GJ20775@brahms.suse.de> <24158.1133113176@ocs3.ocs.com.au> <20051127115640.3073f8e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051127115640.3073f8e3.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 11:56:40AM -0800, Andrew Morton wrote:
> We're saying that kernel/sys.c:notifier_lock should be removed and that all
> callers of notifier_chain_register(), notifier_chain_unregister() and
> notifier_call_chain() should be changed to define and use their own lock.
> 
> So the _callers_ get to decide whether they're going to use down(),
> spin_lock(), down_read(), read_lock(), preempt_disable(), local_irq_disable()
> or whatever.

I completely agree.  I just watched in mute horror as Chandra and Alan
spun off into the rcu blackhole trying to create one-size-fits-all
notifiers.

Making the user do the locking it needs to do is simple and sane.

And the reason USB's notifiers are implemented correctly, is they don't
use the notifier core, but rather, reimplemented their own, due to the
locking mess.

thanks,

greg k-h
