Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933004AbWFXK1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbWFXK1l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 06:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933381AbWFXK1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 06:27:41 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:35476 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933004AbWFXK1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 06:27:40 -0400
Date: Sat, 24 Jun 2006 12:22:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Message-ID: <20060624102248.GA23277@elte.hu>
References: <20060611111815.8641.7879.stgit@localhost.localdomain> <20060611112156.8641.94787.stgit@localhost.localdomain> <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com> <b0943d9e0606240320h1727639cv36a4fe399dddd767@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0606240320h1727639cv36a4fe399dddd767@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Catalin Marinas <catalin.marinas@gmail.com> wrote:

> My opinion is not to implement the "anywhere inside a block" method as 
> it would increase the risk of false negatives with a little benefit 
> (removing some false positive notifications, probably less than 30).

agreed.

> To the other extreme is Ingo's suggestion of using exact type 
> identification but I don't think this would be acceptable for the 
> kernel as it would to modify all the memory alloc calls in the kernel 
> to either pass an additional parameter (the type id) or another 
> post-allocation call to kmemleak to update the id.

passing in the type ID wouldnt be that bad and it would have other 
advantages as well: for example we could do strict type-checking of 
allocation size versus type-we-use-it-for.

As long as the conversion is gradual i think we could try this. I.e. 
we'd default to 'no ID passed', and in that case we would fall back to 
the size-based method and generate an ID out of the structure size.

> Anyway, the current implementation (I'll update it for 2.6.17) detects 
> real memory leaks. I suspect that a wide range of leaks would be 
> covered if it is used on different platforms and different conditions.

btw., what leaks were found so far? I know about the ACPI one - any 
other ones?

	Ingo
