Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWKMTFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWKMTFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755334AbWKMTFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:05:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42182 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1755333AbWKMTFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:05:50 -0500
Date: Mon, 13 Nov 2006 20:04:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061113190452.GA29109@elte.hu>
References: <20061111151414.GA32507@elte.hu> <200611131529.46464.ak@suse.de> <20061113150415.GA20321@elte.hu> <200611131710.13285.ak@suse.de> <20061113163216.GA3480@elte.hu> <20061113100352.C17720@unix-os.sc.intel.com> <20061113184255.GA25528@elte.hu> <20061113103051.D17720@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113103051.D17720@unix-os.sc.intel.com>
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

> On Mon, Nov 13, 2006 at 07:42:56PM +0100, Ingo Molnar wrote:
> > * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> > > Not really. That chipset belongs to a MP platform and with your 
> > > proposed patch, we will endup using clustered APIC mode and will hit 
> > > the issue(in the presence of cpu hotplug) mentioned in that URL.
> > 
> > hm, why does it end up in clustered mode? Cluster mode should only 
> > trigger if the APIC IDs go beyond 16.
> 
> go beyond '8' not 16. With Dual-core+HT these MP platforms will have 
> 16 logical cpus.

yes - then the APIC ids will go beyond 15.

> > but i'd be fine with never going into cluster mode, instead always 
> > using physical flat mode when having more than 8 APICs (independent 
> > of the presence of CPU hotplug). On small systems, logical flat mode 
> > is what is the best-tested variant (it's also slightly faster).
> 
> Ok.

ok, that's really good. Is there any 'weird' platform that you are aware 
of that absolutely needs clustered APIC mode (because it has no physical 
delivery mode or something)?

	Ingo
