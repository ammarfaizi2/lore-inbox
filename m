Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVFAPJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVFAPJZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVFAPHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:07:42 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4163
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261407AbVFAPFh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:05:37 -0400
Date: Wed, 1 Jun 2005 17:05:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601150527.GL5413@g5.random>
References: <20050601143202.GI5413@g5.random> <Pine.OSF.4.05.10506011640360.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506011640360.1707-100000@da410.phys.au.dk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 04:45:57PM +0200, Esben Nielsen wrote:
> the implementation of the former spinlock, now a mutex, is using a
> raw_spin_lock, which disables interrupts.

It's not _raw_spin_lock that disables irq. It's spin_lock_irq that does
that and it has been redefinined into an operation that doesn't disable
irq.

The patent text goes like this "providing a software emulator to disable
and enable interrupts from the general purpose operating system; 

marking interrupts as "soft disabled" and not "soft enabled" in response
to requests from the general purpose operating system to disable
interrupts; ".

I'm not a lawyer and I hope to be wrong, but I sure wouldn't bet the
farm on it. You should ask a lawyer to make sure that non-GPL code is
not infringing IMHO. This assuming that this could be a problem. It was
a problem for RTAI users, people is used to the fact userland doesn't
need to be GPL. Note that LGPL and BSD code will infringe too (i.e. no
glibc etc..).
