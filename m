Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVJCGaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVJCGaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 02:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVJCGaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 02:30:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:52666 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932161AbVJCGaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 02:30:24 -0400
Date: Mon, 3 Oct 2005 08:30:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, dipankar@in.ibm.com, vatsa@in.ibm.com, rusty@au1.ibm.com,
       manfred@colorfullife.com
Subject: Re: [PATCH] RCU torture testing
Message-ID: <20051003063038.GB23241@elte.hu>
References: <20051001182056.GA1613@us.ibm.com> <20051002210549.GA8503@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002210549.GA8503@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> > The attached patch adds CONFIG_RCU_TORTURE_TEST, which enables a /proc-based
> > intense torture test of the RCU infrastructure.  This is needed due to the
> > continued changes to RCU infrastructure to accommodate dynamic ticks, CPU
> > hotplug, and so on.  Most of the code is in a separate file that is compiled
> > only if the CONFIG variable is set.  Documentation on how to run the test
> > and interpret the output is also included.
> > 
> > This code has been tested on i386 and ppc64, and an earlier version of the
> > code has seen extensive testing on a number of architectures as part of the
> > PREEMPT_RT patchset.
> > 
> > Signed-off-by: <paulmck@us.ibm.com>
> 
> Can you just run the tests from time to time inside IBM?

actually, i think RCU_TORTURE_TEST is a prime example of why this should 
be in the main kernel. The torture-test found RCU bugs that never popped 
up during normal use, and RCU bugs are hillariously hard to debug.  
Having that code outside of the main kernel will most certainly result 
in a degradation of the test - while it's role for the development of 
new architectures (and changes to the rcu code) is very important. I 
agree it should move to debugfs, and maybe in the future we'll need some 
better framework for a 'in-kernel integrated testsuite'. I think we 
should encourage such testsuites. I was thinking about writing something 
similar for spinlocks and rwlocks and semaphores. (we occasionally break 
them and they are hard to debug too)

	Ingo
