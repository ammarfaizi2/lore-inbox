Return-Path: <linux-kernel-owner+w=401wt.eu-S1750699AbWLMUWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWLMUWG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWLMUWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:22:06 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39487 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbWLMUWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:22:03 -0500
Date: Wed, 13 Dec 2006 21:19:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it possible to have restricted irqs
Message-ID: <20061213201944.GA3784@elte.hu>
References: <1166018020.27217.805.camel@laptopd505.fenrus.org> <m1lklbport.fsf@ebiederm.dsl.xmission.com> <20061213194332.GA29185@elte.hu> <m1ejr3pnm3.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ejr3pnm3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> > also there might be hardware that can only route a given IRQ to a 
> > subset of CPUs. While setting set_affinity allows the 
> > irqbalance-daemon to 'probe' this mask, it's a far from optimal API.
> 
> I agree, I am just arguing that adding another awkward interface to 
> the current situation does not really make the situation better, and 
> it increases our support burden.

well, please suggest a better interface then.

> For a bunch of this it is arguable that the way to go is simply to 
> parse the irq type in /proc/interrupts.  All of the really weird cases 
> will have a distinct type there.  This certainly captures the MSI-X 
> case.  There is still a question of how to handle the NUMA case but...

... so parsing /proc/interrupts should be that interface? That is a 
historically very volatile interface. It's mostly human-parsed, and we 
frequently twiddle it - genirq changed it too. In v2.6.19 we had fasteio 
instead of fasteoi there.

	Ingo
