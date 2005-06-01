Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVFAVU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVFAVU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVFAUo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:44:58 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59967
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261152AbVFAUcX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:32:23 -0400
Date: Wed, 1 Jun 2005 22:32:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bill Huey <bhuey@lnxw.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601203212.GZ5413@g5.random>
References: <20050601192224.GV5413@g5.random> <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk> <20050601195905.GX5413@g5.random> <20050601201754.GA27795@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601201754.GA27795@nietzsche.lynx.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 01:17:54PM -0700, Bill Huey wrote:
> stop asking FUD enabling questions until you look at the patch.

I'm reading the patch.

> with in the patch. The use of those function isn't SMP safe in drivers,

You don't know very much about local_irq_disable if you think it isn't
smp safe in drivers.

local_irq_disable is perfectly safe in drivers, infact it's _needed_
sometime to avoid race conditions with irqs.

> so any use of those functions and spin-waiting so far has already been
> reviewed and dealt with in the patch.

Even if the code after patching would be right, it _can_ break as soon
as you load a module out of the kernel, or as soon as a non-RT developer
submits a patch to the mainline.

All the problems would be solved with a "ruby hard" hard-RT appraoch
like rtlinux or RTAI, that simply does a soft-cli when cli is called.

Now tell me what do you gain by keeping premept-RT "metal hard" and
prone to break anytime somebody changes a device driver or some
networking subsystem when you can do the "ruby hard" thing like RTAI and
rtlinux do for years?

> Some of that stuff has been moved into work queues that are used to
> defer processing out-of-line, so that it doesn't effect that path.
> 
> Just about all you've been saying has been handled by the patch and I
> ask you to stop asking stupid question until you've looked at it..

The patch doesn't remove any local_irq_disable from drivers, nor it
outlaws it.

It's you who has learn what local_irq_disable does, why it's obviously
the _most_smp-safe_ function in the whole kernel (so much that it's the
only one you can use to avoids locks around per-cpu data structures to
get full scalability), and to grep for it in drivers and verify they're
still there after applying the patch, and subject to modifications and
brekages in future upgrades of the kernel.
