Return-Path: <linux-kernel-owner+w=401wt.eu-S965061AbWLMTpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWLMTpT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWLMTpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:45:18 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56399 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965061AbWLMTpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:45:17 -0500
Date: Wed, 13 Dec 2006 20:43:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it possible to have restricted irqs
Message-ID: <20061213194332.GA29185@elte.hu>
References: <1166018020.27217.805.camel@laptopd505.fenrus.org> <m1lklbport.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1lklbport.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> In addition the cases I can think of allowed_affinity is the wrong 
> name.  suggested_affinity sounds like what you are trying to implement 
> and when it is merely a suggestion and not a hard limit it doesn't 
> make sense to export like this.

well, there are interrupts that must be tied to a single CPU and must 
never be moved away. For example per-CPU clock-events-source interrupts 
are such. So allowed_affinity very much exists.

also there might be hardware that can only route a given IRQ to a subset 
of CPUs. While setting set_affinity allows the irqbalance-daemon to 
'probe' this mask, it's a far from optimal API.

	Ingo
