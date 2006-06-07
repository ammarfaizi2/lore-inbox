Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWFGNW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWFGNW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 09:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWFGNW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 09:22:27 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:55702 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750852AbWFGNW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 09:22:26 -0400
Date: Wed, 7 Jun 2006 15:21:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       paulus@samba.org
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
Message-ID: <20060607132155.GB14425@elte.hu>
References: <20060604135011.decdc7c9.akpm@osdl.org> <1149652378.27572.109.camel@localhost.localdomain> <20060606212930.364b43fa.akpm@osdl.org> <1149656647.27572.128.camel@localhost.localdomain> <20060606222942.43ed6437.akpm@osdl.org> <1149662671.27572.158.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149662671.27572.158.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> during boot). In addition to that, archs need to add something to their
> actual interrupt entry:
> 
> 	if (no_irq_boot) {
> 		local_irq_disable();
> 		return;
> 	}

that just moves the suckage from the mutex-debugging slowpath to the 
irq-handling hotpath. (at which point i still prefer to have that in the 
mutex-debugging path)

a better solution would be to install boot-time IRQ vectors that just do
nothing but return. They dont mask, they dont ACK nor EOI - they just
return. The only thing that could break this is a screaming interrupt,
and even that one probably just slows things down a tiny bit until we
get so far in the init sequence to set up the PIC.

	Ingo
