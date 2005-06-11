Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVFKOFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVFKOFl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 10:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVFKOFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 10:05:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:6278 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261704AbVFKOFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 10:05:36 -0400
Date: Sat, 11 Jun 2005 15:51:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050611135111.GB31025@elte.hu>
References: <1118449247.27756.47.camel@dhcp153.mvista.com> <Pine.OSF.4.05.10506111455240.2917-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506111455240.2917-100000@da410.phys.au.dk>
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


i've done two more things in the latest patches:

- decoupled the 'soft IRQ flag' from the hard IRQ flag. There's
  basically no need for the hard IRQ state to follow the soft IRQ state. 
  This makes the hard IRQ disable primitives a bit faster.

- for raw spinlocks i've reintroduced raw_local_irq primitives again.
  This helped get rid of some grossness in sched.c, and the raw
  spinlocks disable preemption anyway. It's also safer to just assume
  that if a raw spinlock is used together with the IRQ flag that the
  real IRQ flag has to be disabled.

these changes dont really impact scheduling/preemption behavior, they 
are cleanup/robustization changes.

	Ingo
