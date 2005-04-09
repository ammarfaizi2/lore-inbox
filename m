Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVDIJAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVDIJAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 05:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVDIJAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 05:00:09 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:57831 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261187AbVDIJAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 05:00:04 -0400
Date: Sat, 9 Apr 2005 10:56:45 +0200 (CEST)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Francois Romieu <romieu@fr.zoreil.com>, <linux-kernel@vger.kernel.org>,
       <dipankar@in.ibm.com>, <antonb@au1.ibm.com>, <davej@codemonkey.org.uk>,
       <hpa@zytor.com>, <len.brown@intel.com>, <andmike@us.ibm.com>,
       <rth@twiddle.net>, <rusty@au1.ibm.com>, <schwidefsky@de.ibm.com>,
       <jgarzik@pobox.com>
Subject: Re: [RFC,PATCH 3/4] Change synchronize_kernel to _rcu and _sched
In-Reply-To: <20050408010949.GB1299@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0504091047510.18763-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Jeff added to cc list - it's a network driver question]

On Thu, 7 Apr 2005, Paul E. McKenney wrote:

> > >
> > >  	/* Give a racing hard_start_xmit a few cycles to complete. */
> > > -	synchronize_kernel();
I haven't read the whole driver, but what about
	spin_unlock_wait(&dev->xmit_lock);
?
hard_start_xmit is called under dev->xmit_lock, waiting until the lock is
free would guarantee that all running instances of hard_start_xmit have
completed.

Jeff: Is that still correct?

--
	Manfred

