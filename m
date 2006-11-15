Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030752AbWKORdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030752AbWKORdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030753AbWKORdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:33:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14780 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030752AbWKORdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:33:43 -0500
Date: Wed, 15 Nov 2006 18:32:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Eric Dumazet <dada1@cosmosbay.com>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
Message-ID: <20061115173252.GA24062@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <1158047806.2992.7.camel@laptopd505.fenrus.org> <200611151227.04777.dada1@cosmosbay.com> <200611151232.31937.ak@suse.de> <20061115172003.GA20403@elte.hu> <455B4E2F.7040408@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455B4E2F.7040408@goop.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> > Eric's test shows a 5% slowdown. That's far from cheap.
> 
> It seems like an absurdly large difference.  PDA references aren't all 
> that common in the kernel; for the %gs prefix on PDA accesses to be 
> causing a 5% overall difference in a test like this means that the 
> prefixes would have to be costing hundreds or thousands of cycles, 
> which seems absurd.  Particularly since Eric's patch doesn't touch 
> head.S, so the %gs save/restore is still being executed.

i said this before: using segmentation tricks these days is /insane/. 
Segmentation is not for free, and it's not going to be cheap in the 
future. In fact, chances are that it will be /more/ expensive in the 
future, because sane OSs just make no use of them besides the trivial 
"they dont even exist" uses.

so /at a minimum/, as i suggested it before, the kernel's segment use 
should not overlap that of glibc's. I.e. the kernel should use %fs, not 
%gs.

	Ingo
