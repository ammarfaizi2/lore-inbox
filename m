Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUHPEZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUHPEZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 00:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267416AbUHPEZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 00:25:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27568 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267415AbUHPEZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 00:25:28 -0400
Date: Mon, 16 Aug 2004 06:26:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816042653.GA14738@elte.hu>
References: <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de> <1092622121.867.109.camel@krustophenia.net> <20040816024314.GA8960@elte.hu> <20040816030818.GA10685@elte.hu> <1092629953.810.23.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092629953.810.23.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > > just to check this theory, could you make __check_and_rekey() an empty
> > > function? This should still produce a working random driver, albeit at
> > > much reduced entropy. If these latencies have a relationship to the
> > > mlockall() issue then this change should have an effect.
> > 
> > hm, could you disable the random driver in the .config rather? It seems
> > that adding to the entropy pool (from hardirq context) alone is quite
> > expensive too.
> > 
> 
> Can this be disabled in the .config?  I can't find an option for it.

oh well, indeed it cannot be disabled. Then i'd suggest to return early
from extract_entropy(), without doing anything. That is the function
that seems to introduce the worst overhead.

	Ingo
