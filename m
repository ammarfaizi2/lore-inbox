Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272811AbTG3I0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272812AbTG3I0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:26:22 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10209
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272811AbTG3I0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:26:21 -0400
Date: Wed, 30 Jul 2003 10:28:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linas@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730082848.GC23835@dualathlon.random>
References: <20030730073458.GA23835@dualathlon.random> <Pine.LNX.4.44.0307300932560.433-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307300932560.433-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 09:34:40AM +0200, Ingo Molnar wrote:
> 
> On Wed, 30 Jul 2003, Andrea Arcangeli wrote:
> 
> > The thing triggered simply by running setitimer in one function, while
> > the it_real_fn was running in the other cpu. I don't see how 2.6 can
> > have fixed this, it_real_fun can still trivially call add_timer while
> > you run inside do_setitimer in 2.6 too. [...]
> 
> This is not a race that can happen. itimer does this:
> 
> 	del_timer_sync();
> 	add_timer();
> 
> how can the add_timer() still happen while it_real_fn is still running on 
> another CPU?

it's not add_timer against add_timer in this case, it's del_timer_sync
against add_timer.


	cpu0			cpu1
	------------		--------------------

	do_setitimer
				it_real_fn
	del_timer_sync		add_timer	-> crash

Andrea
