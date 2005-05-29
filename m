Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVE2GGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVE2GGR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 02:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVE2GGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 02:06:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16025 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261259AbVE2GGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 02:06:13 -0400
Date: Sun, 29 May 2005 08:01:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
Message-ID: <20050529060127.GA31186@elte.hu>
References: <4293420C.8080400@yahoo.com.au> <20050524150537.GA11829@elte.hu> <42934748.8020501@yahoo.com.au> <20050524152759.GA15411@elte.hu> <20050524154230.GA17814@elte.hu> <20050525052400.46bccf26.akpm@osdl.org> <20050525135130.GA27088@elte.hu> <20050528173241.C4711@flint.arm.linux.org.uk> <20050528185123.GA13961@elte.hu> <42993F71.2080501@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42993F71.2080501@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >it's not really a bug in any architecture - it's a scheduler setup 
> >detail that i changed, and which i initially thought would be best 
> >handled in cpu_idle(), but which is easier to do in rest_init().
> 
> Hmm, what has changed is that secondary CPUs haven't got need_resched 
> set in their idle routines. Whether or not it is possible to a task on 
> their runqueue at that stage, I didn't bother looking - I assume you 
> did.

the idle thread is the first thing that gets on the runqueue of 
secondary CPUs. It's really just the boot process that has this 
inevitable 'we do some stuff before the scheduler has been set up' 
sequence. Secondary CPUs _must not be active_ before their idle thread 
has been set up. (which would be the source of other bugs as well.)

> However, Ingo - instead of calling schedule() at the end of 
> rest_init(), why not just set need_resched instead?

it's slightly smaller code.

	Ingo
