Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbULFOiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbULFOiB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbULFOhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:37:40 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:23267 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261219AbULFOh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:37:27 -0500
Date: Mon, 6 Dec 2004 07:33:53 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>, rusty@au1.ibm.com, ak@suse.de,
       gareth@valinux.com, davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Strange code in cpu_idle()
In-Reply-To: <20041206110246.GA5303@in.ibm.com>
Message-ID: <Pine.LNX.4.61.0412060727310.4242@montezuma.fsmlabs.com>
References: <20041204231149.GA1591@us.ibm.com> <Pine.LNX.4.61.0412060244350.1036@montezuma.fsmlabs.com>
 <20041206110246.GA5303@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Dipankar Sarma wrote:

> > > So I would say that the rcu_read_lock() in cpu_idle() is having no
> > > effect, because any timer interrupt from cpu_idle() will mark a
> > > quiescent state notwithstanding.  What am I missing here?
> > 
> > What about the hardirq_count check since we're coming in from the timer 
> > interrupt?
> 
> Look at the hardirq_count check closely - it only checks for reentrant
> hardirqs. If the idle task gets interrupted by a timer interrupt,
> the RCU quiscent state counter for the cpu will get incremented.
> So, rcu_read_lock() in cpu_idle() is bogus.

Ah crafty, the only reason it 'works' right now then is because we exit 
the pm_idle callback shortly after processing the timer interrupt which 
marks the processor as quiescent.

Thanks for pointing that out,

	Zwane

