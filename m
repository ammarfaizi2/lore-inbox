Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVFAPrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVFAPrB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVFAPps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:45:48 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31002
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261438AbVFAPoA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:44:00 -0400
Date: Wed, 1 Jun 2005 17:43:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: john cooper <john.cooper@timesys.com>
Cc: Paulo Marques <pmarques@grupopie.com>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601154349.GP5413@g5.random>
References: <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com> <20050601135154.GF5413@g5.random> <20050601141919.GA9282@elte.hu> <20050601143202.GI5413@g5.random> <20050601144612.GJ5413@g5.random> <429DCD25.3010800@grupopie.com> <20050601151701.GM5413@g5.random> <429DD553.3080509@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429DD553.3080509@timesys.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 11:33:39AM -0400, john cooper wrote:
> FWIW the decoupling of interrupt mask levels from
> spinlocks is a technique which predates the patent
> under discussion by a decade or so.  And yes IANAL
> as well but it seems the patent would/should not
> have been awarded if it conflicted/overlapped with
> preexisting usage.  I'd hazard this is a non-issue.

Ok, I'm glad we're allowed to redefine spin_lock_irq not to do a
hard-irq disable. I'm sorry for the annoyance, but I guess the end
result is even better now than it was before addressing this topic.

So to me the only obvious complain that remains is that every new driver
that calls local_irq_disable is a threat to the worst case latency, and
hence preempt-RT still deserve the "metal hard" definition, since
auditing all drivers calling local_irq_disable is hardly feasible.
