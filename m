Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVJCPZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVJCPZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVJCPZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:25:26 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:52873 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932283AbVJCPZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:25:25 -0400
Date: Mon, 3 Oct 2005 08:26:02 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       dipankar@in.ibm.com, vatsa@in.ibm.com, rusty@au1.ibm.com, mingo@elte.hu,
       manfred@colorfullife.com
Subject: Re: [PATCH] RCU torture testing
Message-ID: <20051003152602.GD1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051001182056.GA1613@us.ibm.com> <20051002210549.GA8503@elf.ucw.cz> <20051003143009.GB1300@us.ibm.com> <1128350188.17024.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128350188.17024.14.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 04:36:28PM +0200, Arjan van de Ven wrote:
> On Mon, 2005-10-03 at 07:30 -0700, Paul E. McKenney wrote:
> > On Sun, Oct 02, 2005 at 11:05:49PM +0200, Pavel Machek wrote:
> > > Can you just run the tests from time to time inside IBM?
> > 
> > In principle, I could, but in practice it is appropriate for non-IBMers to
> > be able to test the RCU infrastructure easily and thoroughly when they
> > work on it.
> 
> how hard would it be to make the few parameters just be module
> options... and then fail module load if the test fails or something?
> (and spew loudly in dmesg :)

Good point -- all I really need for module parameters is the number
of readers.  I should be able to have module load start the test and
module unload stop it (any problems with this approach?).  And doing
a module should remove the intrusions into rcupdate.c and rcupdate.h,
which would be good.

I would rather avoid dmesg.  But perhaps a read-only debugfs for output
(as Greg suggested) combined with module parameters for input could make
this straightforward.

> I'd be all in favor of having such a module in the kernel; in fact it
> would be nice if we roughly could standardize on an way to load/start
> and then find the result, I'd love to have a "make runtests" or
> something that would load such modules one by one

Which would mean that each test needs to give unambiguous machine-readable
indication of failure.  I guess I will nominate the string "!!!".  ;-)

> (and no that's not the task of ltp, ltp should test userspace; things
> that test in kernel code should really be part of the kernel)

I agree that there is definitely a need for both user-level and in-kernel
testing.  User-level testing is needed to make sure that user programs get
what they need, but there is no substitute for in-kernel testing when you
need to apply maximum conceiveable stress on some kernel component.

							Thanx, Paul
