Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWGXLVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWGXLVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 07:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWGXLVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 07:21:39 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:24515 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932114AbWGXLVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 07:21:39 -0400
Date: Mon, 24 Jul 2006 13:15:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Message-ID: <20060724111554.GA5286@elte.hu>
References: <20060611111815.8641.7879.stgit@localhost.localdomain> <20060611112156.8641.94787.stgit@localhost.localdomain> <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com> <b0943d9e0606240320h1727639cv36a4fe399dddd767@mail.gmail.com> <20060624102248.GA23277@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624102248.GA23277@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > To the other extreme is Ingo's suggestion of using exact type 
> > identification but I don't think this would be acceptable for the 
> > kernel as it would to modify all the memory alloc calls in the 
> > kernel to either pass an additional parameter (the type id) or 
> > another post-allocation call to kmemleak to update the id.
> 
> passing in the type ID wouldnt be that bad and it would have other 
> advantages as well: for example we could do strict type-checking of 
> allocation size versus type-we-use-it-for.
> 
> As long as the conversion is gradual i think we could try this. I.e. 
> we'd default to 'no ID passed', and in that case we would fall back to 
> the size-based method and generate an ID out of the structure size.

update: there's also a neat gcc extension trick suggested by Arjan: 
__builtin_classify_type(). This converts types into integers!

	Ingo
