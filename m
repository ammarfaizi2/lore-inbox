Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbUKOJWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbUKOJWq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 04:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUKOJWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 04:22:46 -0500
Received: from aun.it.uu.se ([130.238.12.36]:62104 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261561AbUKOJTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 04:19:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16792.29804.831349.369201@alkaid.it.uu.se>
Date: Mon, 15 Nov 2004 10:18:36 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6.10-rc1-mm4][3/4] perfctr x86 driver updates
In-Reply-To: <1100480985.7381.18.camel@localhost.localdomain>
References: <200411110937.iAB9b7Ir028763@alkaid.it.uu.se>
	<1100480985.7381.18.camel@localhost.localdomain>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:
 > On Thu, 2004-11-11 at 10:37 +0100, Mikael Pettersson wrote:
 > > Part 3/4 of the perfctr interrupt fixes:
 > ...
 > >  	} control;
 > > +#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 > > +	unsigned int interrupts_masked;
 > > +#endif
 > >  } ____cacheline_aligned;
 > >  static DEFINE_PER_CPU(struct per_cpu_cache, per_cpu_cache);
 > 
 > While you're here, does this really have to be cacheline aligned?  I
 > wouldn't think so, since it's in the per-cpu section anyway.

The ____cacheline_aligned is a left-over from the [NR_CPUS] days;
it's probably not needed any more. I'll submit a patch to delete
it and also move the interrupts_masked field nearer the head of the
struct (to reduce # of cache lines touched in the common case).

/Mikael
