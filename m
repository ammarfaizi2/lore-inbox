Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269523AbUINRCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269523AbUINRCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269580AbUINQ5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:57:09 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:10413 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S269589AbUINQcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:32:31 -0400
Date: Tue, 14 Sep 2004 18:31:43 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       Ray Bryant <raybry@sgi.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914163143.GQ4180@dualathlon.random>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914155103.GR9106@holomorphy.com> <20040914160531.GP4180@dualathlon.random> <200409140916.48786.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409140916.48786.jbarnes@engr.sgi.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 09:16:48AM -0700, Jesse Barnes wrote:
> the readprofile times, I'd say per-cpu would be the way to go just because it 
> retains the simplicity of the current approach while allowing it to work on 
> large machines (as well as limiting the performance impact of builtin 
> profiling in general).  wli's approach seems like a reasonable tradeoff 
> though, assuming what you suggest doesn't work.

per-cpu certainly sounds simple enough conceptually, so if you can
notice any slowdown even with idle loop ruled out, per-cpu is sure
better.

This bouncing is likely to hurt smaller SMP too (but once the cpu is
idle normally it's not a too bad thing since it only hurted reschedule
latency, since we remain stuck in the timer irq for a bit longer than we
should), but duplicating the ram of the array there doesn't look as nice
as it would be on the altix, not all SMP have tons of ram. So an
intermediate solution for this problem still sound worthwhile for the
normal smp case.
