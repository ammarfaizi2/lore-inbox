Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbSJYMTk>; Fri, 25 Oct 2002 08:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSJYMTk>; Fri, 25 Oct 2002 08:19:40 -0400
Received: from kim.it.uu.se ([130.238.12.178]:9922 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261374AbSJYMTj>;
	Fri, 25 Oct 2002 08:19:39 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15801.14413.909403.323948@kim.it.uu.se>
Date: Fri, 25 Oct 2002 14:25:49 +0200
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 performance counters driver 3.0-pre2 for 2.5.44: [2/4] x86 support
In-Reply-To: <m3wuo7omzg.fsf@averell.firstfloor.org>
References: <200210241500.RAA03585@kim.it.uu.se>
	<m3wuo7omzg.fsf@averell.firstfloor.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > Mikael Pettersson <mikpe@csd.uu.se> writes:
 > 
 > > +struct per_cpu_cache {	/* roughly a subset of perfctr_cpu_state */
 > > +	union {
 > > +		unsigned int p5_cesr;
 > > +		unsigned int id;	/* cache owner id */
 > > +	} k1;
 > > +	struct {
 > > +		/* NOTE: these caches have physical indices, not virtual */
 > > +		unsigned int evntsel[18];
 > > +		unsigned int escr[0x3E2-0x3A0];
 > > +		unsigned int pebs_enable;
 > > +		unsigned int pebs_matrix_vert;
 > > +	} control;
 > > +} __attribute__((__aligned__(SMP_CACHE_BYTES)));
 > > +static struct per_cpu_cache per_cpu_cache[NR_CPUS] __cacheline_aligned;
 > 
 > This should use per cpu data (asm/percpu.h) to save memory.

Yes you're right. I didn't do this before because previous versions
needed to support 2.2/2.4 kernels and building it as a module.

For what values of cpu is per_cpu(var,cpu) valid? For those where
cpu_online(cpu) is true, or those where cpu_possible(cpu) is true?
(I need to convert a memset() on the per_cpu_cache[] array to the
per_cpu(,) framework.)

I'll fix this and announce a new version later today.

/Mikael
