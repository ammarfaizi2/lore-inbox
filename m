Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbTHYIPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTHYIPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:15:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60623 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261537AbTHYIPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:15:47 -0400
Date: Mon, 25 Aug 2003 10:13:37 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@hpce.nec.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, torvalds@osdl.org
Subject: Re: [patch 2.6.0t4] 1 cpu/node scheduler fix
In-Reply-To: <200308241913.24699.efocht@hpce.nec.com>
Message-ID: <Pine.LNX.4.56.0308251010020.6670@localhost.localdomain>
References: <200308241913.24699.efocht@hpce.nec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 24 Aug 2003, Erich Focht wrote:

> This simple patch is not meant as opposition to Andrew's attempt to
> NUMAize the whole scheduler. That one will definitely make NUMA coders'
> lives easier but I fear that it is a bit too complex for 2.6. The
> attached small incremental change is sufficient to solve the main
> problem. Besides, the change of the cross-node scheduling is compatible
> with Andrew's scheduler structure. I really don't like the timer-based
> cross-node balancing because it is too unflexible (no way to have
> different balancing intervals for each node) and I'd really like to get
> back to just one single point of entry for load balancing: the routine
> load_balance(), no matter whether we balance inside a timer interrupt or
> while the CPU is going idle.

your patch clearly simplifies things. Would you mind to also extend the
rebalance-frequency based balancing to the SMP scheduler, and see what
effect that has? Ie. to remove much of the 'tick' component from the SMP
scheduler as well, and make it purely frequency based.

I'm still afraid of balancing artifacts if we lose track of time (which
the tick thing is about, and which cache affinity is a function of), but
maybe not. It would certainly unify things more. If it doesnt work out
then we can still do your stuff for the cross-node balancing only.

	Ingo
