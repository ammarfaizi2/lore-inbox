Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754283AbWKMIRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283AbWKMIRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 03:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754284AbWKMIRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 03:17:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:8394 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1754227AbWKMIRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 03:17:12 -0500
Date: Mon, 13 Nov 2006 09:16:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061113081616.GA25604@elte.hu>
References: <20061111151414.GA32507@elte.hu> <200611111620.24551.ak@suse.de> <20061112175050.A17720@unix-os.sc.intel.com> <200611130332.07569.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611130332.07569.ak@suse.de>
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

> Now if it causes device driver issues that's different of course. I 
> wasn't aware of this before.

lets try my patch in -mm for a while.

Had i ever noticed this hack in the first place i would have NAK-ed it. 
There is a fundamental design friction of a high-level feature like 
HOTPLUG_CPU /requiring/ a fundamental change to the lowlevel IRQ 
delivery mode! Such a requirement is broken and just serves to hide a 
flaw in the hotplug design - which flaw would trigger on i386 /anyway/, 
because i386 still uses logical delivery mode for APIC IPIs. Also, i'd 
like to have a description of how to reproduce those CPU hotplug 
problems, so that i can try to fix it.

	Ingo
