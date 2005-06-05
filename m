Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVFEIit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVFEIit (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 04:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVFEIit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 04:38:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55770 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261535AbVFEIds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 04:33:48 -0400
Date: Sun, 5 Jun 2005 10:26:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Daniel Walker <dwalker@mvista.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, plist fixes
Message-ID: <20050605082616.GA26824@elte.hu>
References: <1117930633.20785.239.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117930633.20785.239.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Gleixner <tglx@linutronix.de> wrote:

> + * (C) 2005 Thomas Gleixner <tglx@linutronix.de>
> + * Tested and made it functional. I'm still pondering if it is
> + * worth the trouble.

you had a long Saturday night debugging session i guess:

> Date: Sun, 05 Jun 2005 02:17:12 +0200

but i think the fundamental question remains even on Sunday mornings -
is the plist overhead worth it? Compared to the simple sorted list we 
exchange O(nr_RT_tasks_running) for O(nr_RT_levels_used) [which is in 
the 1-100 range], is that a significant practical improvement? By 
overhead i dont just mean cycle cost, but also architectural flexibility 
and maintainability.

in any case, i've added most of your fixes and cleanups (changed the
O(N) to O(K) and explained K) and have released the -47-17 patch.
Daniel, do agree with these changes (in particular the __plist_del()
changes?) and is there anything else missing? It looks like we might be
near the end of the tunnel and plists are really stabilizing.

	Ingo
