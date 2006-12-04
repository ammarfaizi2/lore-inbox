Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937065AbWLDQYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937065AbWLDQYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937084AbWLDQYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:24:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54681 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937065AbWLDQYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:24:13 -0500
Date: Mon, 4 Dec 2006 17:23:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in	latency_trace.c (take 3)
Message-ID: <20061204162300.GA23800@elte.hu>
References: <200611132252.58818.sshtylyov@ru.mvista.com> <457326A2.2020402@ru.mvista.com> <20061204095131.GE7872@elte.hu> <4574149B.5070602@ru.mvista.com> <20061204153949.GA9350@elte.hu> <45744AF5.2040508@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45744AF5.2040508@ru.mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> > 	/* check for buggy clocks, handling wrap for 32-bit clocks */
> >-	if (TYPE_EQUAL(cycles_t, unsigned long)) {
> >+	if (TYPE_EQUAL(cycle_t, unsigned long)) {
> > 		if (time_after((unsigned long)T1, (unsigned long)T2))
> > 			printk("bug: %08lx < %08lx!\n",
> > 				(unsigned long)T2, (unsigned long)T1);
> 
>    This earlier fix by Kevin woulnd't have sense anymore with cycle_t...

yeah, indeed - i've zapped this one too.

basically, what i'd like is the 32-bit clocks/cycles be handled 
intelligently, and not adding to the cruft that already is in 
kernel/latency_tracing.c.

	Ingo
