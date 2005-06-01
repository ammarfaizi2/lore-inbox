Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVFAPSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVFAPSD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVFAPSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:18:03 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13885
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261420AbVFAPRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:17:12 -0400
Date: Wed, 1 Jun 2005 17:17:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601151701.GM5413@g5.random>
References: <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com> <20050601135154.GF5413@g5.random> <20050601141919.GA9282@elte.hu> <20050601143202.GI5413@g5.random> <20050601144612.GJ5413@g5.random> <429DCD25.3010800@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429DCD25.3010800@grupopie.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 03:58:45PM +0100, Paulo Marques wrote:
> >providing a real time operating system for running real time tasks and 
> >components and non-real time tasks; 
> >providing a general purpose operating system as one of the non-real time 
> >tasks; 
> 
> This seems like the RTAI kind of nano-kernel approach and has nothing to 
> do with the way the RT-PREEMPT patch works, AFAICS.

Well I'm very happy to hear that.

The reason I raise this topic is that the fact spin_lock_irq wasn't
disabling irqs like it does in the non-RT configuration, sounded like
the technique described in the patent and it's one technique I always
considered not-usable. I possibly wrongly remembered that redefining the
disable-interrupt operation not to disable irqs, was the crucial point
of the patent. But as I've said I'm not a lawyer and so I may have
misunderstood completely the technique that the rtlinux patent is
covering (the way patents are written is not very readable to me).

Keep in mind that you wouldn't need to remove the cli from spin_lock_irq
if all the critical sections would be deterministic. But I definitely
agree this is much better.

Still the local_irq_disable isn't redefinined in the patch (only
spin_lock_irq isn't disabling irqs), and in turn calling
local_irq_disable will truly generate hangs, and every driver should be
audited in order to be as robust as RTAI. So there's less auditing to
do, but preempt-RT is still prone to break with every new kernel patch
that has some call to local_irq_disable.
