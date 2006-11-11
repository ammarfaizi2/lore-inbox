Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424013AbWKKP3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424013AbWKKP3K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 10:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424014AbWKKP3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 10:29:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:62416 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1424013AbWKKP3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 10:29:07 -0500
Date: Sat, 11 Nov 2006 16:27:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061111152757.GA2407@elte.hu>
References: <20061111151414.GA32507@elte.hu> <200611111620.24551.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611111620.24551.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Saturday 11 November 2006 16:14, Ingo Molnar wrote:
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > this patch fixes a couple of inconsistencies/problems i found while 
> > reviewing the x86_64 genapic code (when i was chasing mysterious eth0 
> > timeouts that would only trigger if CPU_HOTPLUG is enabled):
> > 
> >  - AMD systems defaulted to the slower flat-physical mode instead
> >    of the flat-logical mode. The only restriction on AMD systems
> >    is that they should not use clustered APIC mode.
> 
> This will open a race on CPU hotunplug unfortunately (common for multi 
> core suspend)

Note that i386 still defaults to logical flat mode, so whatever hotplug 
CPU races there are, they need to be fixed! Given how rare CPU hotplug 
systems are i have no problem with having these races in the kernel for 
a while until it's fixed.

Also, distro kernels enable CPU_HOTPLUG frequently. It is just ugly 
beyond recognition to switch the programming of the IRQ hardware on 
non-hotplug hardware just because a mostly-software feature (hotplug) is 
enabled ...

if hotplug breaks suspend then fix it, dont hack it around (on one 
platform) by slowing down the system [and causing other problems] ...

	Ingo
