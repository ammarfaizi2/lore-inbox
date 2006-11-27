Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756677AbWK0Eha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbWK0Eha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 23:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756681AbWK0Eha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 23:37:30 -0500
Received: from pool-71-111-72-250.ptldor.dsl-w.verizon.net ([71.111.72.250]:13655
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com") by vger.kernel.org
	with ESMTP id S1756677AbWK0Eh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 23:37:29 -0500
Date: Sun, 26 Nov 2006 20:33:23 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061127043323.GB5021@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.64.0611161414580.3349@woody.osdl.org> <Pine.LNX.4.44L0.0611162148360.24994-100000@netrider.rowland.org> <20061117065128.GA5452@us.ibm.com> <20061117092925.GT7164@kernel.dk> <20061119190027.GA3676@oleg> <20061123145910.GA145@oleg> <20061123204054.GA4533@us.ibm.com> <20061123214908.GB106@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123214908.GB106@oleg>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 12:49:08AM +0300, Oleg Nesterov wrote:
> On 11/23, Paul E. McKenney wrote:
> >
> >                            For general use, I believe that this has
> > difficulties with the sequence of events I sent out on November 20th, see:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=116397154808901&w=2
> >
> > ...
> >
> > I don't understand why an unlucky sequence of events mightn't be able
> > to hang this __wait_event().  Suppose we did the atomic_dec_and_test(),
> > then some other CPU executed xxx_read_unlock(), finding no one to awaken,
> > then we execute the __wait_event()?
> 
> Please note how ->ctr[] is initialized,
> 
> 	atomic_set(sp->ctr + 0, 1);	<---- 1, not 0
> 	atomic_set(sp->ctr + 1, 0);
> 
> atomic_read(sp->ctr + idx) == 0 means that this counter is inactive,
> nobody use it.

I definitely should have slept before commenting on the earlier version,
it would appear.  ;-)  Please accept my apologies for my confusion!

I will take a look at your later patch.

							Thanx, Paul
