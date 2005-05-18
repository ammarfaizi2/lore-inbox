Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVERILO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVERILO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 04:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVERILO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 04:11:14 -0400
Received: from aun.it.uu.se ([130.238.12.36]:63701 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262129AbVERIHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 04:07:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17034.63435.196130.708395@alkaid.it.uu.se>
Date: Wed, 18 May 2005 10:07:39 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2.6.12-rc4-mm2] perfctr: x86 update with K8 multicore
 fixes, take 2
In-Reply-To: <m164xh7aqe.fsf@muc.de>
References: <200505172044.j4HKiMTY026776@alkaid.it.uu.se>
	<m164xh7aqe.fsf@muc.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > Mikael Pettersson <mikpe@csd.uu.se> writes:
 > 
 > > +#ifdef CONFIG_SMP
 > > +static void __init k8_multicore_init(void)
 > > +{
 > > +	cpumask_t non0cores;
 > > +	int i;
 > > +
 > > +	cpus_clear(non0cores);
 > > +	for(i = 0; i < NR_CPUS; ++i) {
 > > +		cpumask_t cores = cpu_core_map[i];
 > > +		int core0 = first_cpu(cores);
 > > +		if (core0 >= NR_CPUS)
 > > +			continue;
 > > +		cpu_clear(core0, cores);
 > > +		cpus_or(non0cores, non0cores, cores);
 > > +	}
 > > +	if (cpus_empty(non0cores))
 > > +		return;
 > > +	k8_is_multicore = 1;
 > 
 > That is still far too complicated. Just use current_cpu_data->x86_num_cores > 1 
 > That is simple enough that you don't need the ugly variable.

Right now you're right, but if you read the big comment just above
this code you'll see that once chips w/o the RevE erratum are
released, I'll make more serious use of the non0cores cpumask.
I consider _that_ the intended design (for the shared NB issue),
and the current code (just the k8_is_multicore flag) a workaround
for the NB clobber erratum in the 1st gen chips.

/Mikael
