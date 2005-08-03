Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVHCH7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVHCH7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 03:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVHCH65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 03:58:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58805 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262138AbVHCH6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 03:58:32 -0400
Date: Wed, 3 Aug 2005 09:59:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jack Steiner <steiner@sgi.com>
Subject: Re: [patch 2/2] sched: reduce locking in periodic balancing
Message-ID: <20050803075916.GB6013@elte.hu>
References: <42EF65A9.1060408@yahoo.com.au> <42EF65FF.2000102@yahoo.com.au> <42EF6628.4070102@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EF6628.4070102@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> During periodic load balancing, don't hold this runqueue's lock while
> scanning remote runqueues, which can take a non trivial amount of time
> especially on very large systems.
> 
> Holding the runqueue lock will only help to stabalise ->nr_running,

s/stabalise/stabilise/

> however this isn't doesn't do much to help because tasks being woken 

s/isn't //

> will simply get held up on the runqueue lock, so ->nr_running would 
> not provide a really accurate picture of runqueue load in that case 
> anyway.
> 
> What's more, ->nr_running (and possibly the cpu_load averages) of
> remote runqueues won't be stable anyway, so load balancing is always
> an inexact operation.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>

btw., holding the runqueue lock during the initial scanning portion of 
load-balancing is one of the top PREEMPT_RT critical paths on SMP. (It's 
not bad, but it's one of the factors that makes SMP latencies higher.)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
