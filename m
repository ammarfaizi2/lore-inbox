Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946170AbWKJJ2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946170AbWKJJ2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946203AbWKJJ2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:28:20 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:31888 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1946170AbWKJJ2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:28:18 -0500
Date: Fri, 10 Nov 2006 10:27:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, rdreier@cisco.com
Subject: Re: locking hierarchy based on lockdep
Message-ID: <20061110092710.GA20035@elte.hu>
References: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com> <20061106200529.GA15370@elte.hu> <Pine.LNX.4.64.0611071833450.22572@dhcp83-20.boston.redhat.com> <20061107235342.GA5496@elte.hu> <Pine.LNX.4.64.0611081254150.18340@dhcp83-20.boston.redhat.com> <20061109091554.GB23876@elte.hu> <Pine.LNX.4.64.0611091354060.17915@dhcp83-20.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611091354060.17915@dhcp83-20.boston.redhat.com>
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


* Jason Baron <jbaron@redhat.com> wrote:

> > but ... the locks_after list should really only include locks that 
> > are taken immediately after. I.e. there should only be 'distance 1' 
> > locks.
> 
> hmmm...that's not how i read the lockdep code...and the little piece 
> of code that i added to add a distance measurement to links, found 
> mostly distance 1 links but there were a number of 2 and 3 links as 
> well (i don't think i saw any greater than 3).

hm, indeed, the current code does this. In theory we should not need to 
add every lock to every held lock's dependency, because all the 
dependency-conflict discovery algorithms can walk the full graph. The 
"necessary minimum" would be to only add it to the previous non-trylock 
held lock's dependency list.

ok, i like your latest patch as-is - it's simpler than to complicate the 
current dependency logic. the 'distance' field is only added to the list 
entry structure, so while it increases that structure's size, it at 
least doesnt directly increase lock sizes.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
