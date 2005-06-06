Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVFFHdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVFFHdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 03:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFFHdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 03:33:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:2437 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261188AbVFFHdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 03:33:07 -0400
Date: Mon, 6 Jun 2005 09:32:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, plist fixes
Message-ID: <20050606073229.GA9143@elte.hu>
References: <20050605082616.GA26824@elte.hu> <Pine.OSF.4.05.10506051044340.4252-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506051044340.4252-100000@da410.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Sorted lists works deterministicly O(1) on UP if no owner of the lock 
> blocks while having the lock. On SMP or worse if an owner blocks in 
> the lock, the wait list can grow very long. Thus insertion of new 
> elements takes a long time - with preemption disabled :-(

the wait list can grow only as long as the max # of RT tasks is. Sorted 
lists become 'O(1)' if we added some code that globally limits the 
number of RT tasks to say 50. E.g. /proc/sys/kernel/max_nr_RT_tasks. A 
user can override it if he needs more RT tasks. There can be an 
arbitrary number of SCHED_OTHER tasks.

(note that on Linux there is a RAM-dependent 'max # of tasks' ulimit 
which is never 'infinity', so theoretically the sorted lists are "O(1)" 
too. But this is nitpicking.)

> If this is supposed to be used for user-space PI as well I would say 
> it would have to be completely bounded, i.e. plists are certainly 
> needed. [...]

yes, it's supposed to be used for user-space PI too. What do you mean by 
'completely bounded'. Do you consider the current worst-case O(100) 
property of plists a 'completely bounded' solution?

i dont think fusyn's should be made available to non-RT tasks. If this 
restriction is preserved then fusyn's would become O(max_nr_RT_tasks) 
too.

	Ingo
