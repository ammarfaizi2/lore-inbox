Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWKMIo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWKMIo4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 03:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbWKMIo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 03:44:56 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:5515 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751678AbWKMIo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 03:44:56 -0500
Date: Mon, 13 Nov 2006 09:43:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061113084315.GB25604@elte.hu>
References: <20061111151414.GA32507@elte.hu> <200611111620.24551.ak@suse.de> <20061112175050.A17720@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061112175050.A17720@unix-os.sc.intel.com>
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


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> There is an issue of using clustered mode along with cpu hotplug. More 
> details are at the below link.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113261865814107&w=2

ok, to make sure i understand this right: it is not safe to switch any 
local APIC in the system into clustered APIC mode on the E850x chipset 
/at all/, because if one of the CPUs gets an INIT/startup IPI message 
its local APIC will default to logical flat mode and might confuse the 
chipset?

on large systems that have their APIC IDs set up to group CPUs amongst 
different clusters and hence triggered cluster mode, the chipset does 
not get confused by this, correct?

	Ingo
