Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWGYVHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWGYVHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWGYVHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:07:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932479AbWGYVHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:07:14 -0400
Date: Tue, 25 Jul 2006 13:57:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
cc: Ingo Molnar <mingo@elte.hu>, Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: remove cpu hotplug bustification in cpufreq.
In-Reply-To: <1153855844.8932.56.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com> 
 <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>  <20060725185449.GA8074@elte.hu>
 <1153855844.8932.56.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Jul 2006, Arjan van de Ven wrote:
>
> so cpufreq_set_policy() takes policy->lock, and then calls into the
> userspace governer code
> (__cpufreq_set_policy->cpufreq_governor->cpufreq_governor_userspace)
> which calls __cpufreq_driver_target... which does lock_cpu_hotplug().

Yeah. I think the target should _not_ take the lock_cpu_hotplug(), since 
the call chain (much much earlier) should have done it. 

Ie we should probably do it at the "cpufreq_set_policy()" level.

>      Arjan -- who's just cleaned Linus' wall to prepare it for more head
> banging

It's not actually "my wall". I'll happily share it with anybody else.

Please. Take my wall.

		Linus
