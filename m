Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030896AbWKOTHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030896AbWKOTHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030900AbWKOTHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:07:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:20096 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030896AbWKOTH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:07:29 -0500
Date: Wed, 15 Nov 2006 20:06:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Eric Dumazet <dada1@cosmosbay.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
Message-ID: <20061115190606.GB9303@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <1158047806.2992.7.camel@laptopd505.fenrus.org> <200611151227.04777.dada1@cosmosbay.com> <200611151232.31937.ak@suse.de> <20061115172003.GA20403@elte.hu> <455B4E2F.7040408@goop.org> <1163613702.31358.145.camel@laptopd505.fenrus.org> <455B5B55.20803@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455B5B55.20803@goop.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0020]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Arjan van de Ven wrote:
> > segment register accesses really are not cheap. 
> > Also really it'll be better to use the register userspace is not using,
> > but we had that discussion before; could you remind me why you picked 
> > %gs in the first place?
> >   
> 
> To leave open the possibility of using the compiler's TLS support in 
> the kernel for percpu.  I also measured the cost of reloading %gs vs 
> %fs, and found no difference between reloading a null selector vs a 
> non-null selector.

what point would there be in using it? It's not like the kernel could 
make use of the thread keyword anytime soon (it would need /all/ 
architectures to support it) ... and the kernel doesnt mind how the 
current per_cpu() primitives are implemented, via assembly or via C. In 
any case, it very much matters to see the precise cost of having the pda 
selector value in %gs versus %fs.

	Ingo
