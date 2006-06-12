Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752208AbWFLTX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbWFLTX3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbWFLTX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:23:29 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46819 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752208AbWFLTX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:23:28 -0400
Date: Mon, 12 Jun 2006 21:22:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Message-ID: <20060612192227.GA5497@elte.hu>
References: <20060611111815.8641.7879.stgit@localhost.localdomain> <20060611112156.8641.94787.stgit@localhost.localdomain> <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com> <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com> <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI> <20060612105345.GA8418@elte.hu> <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5002]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Catalin Marinas <catalin.marinas@gmail.com> wrote:

> On 12/06/06, Ingo Molnar <mingo@elte.hu> wrote:
> >What i'd like to see though are clear explanations about why an
> >allocation is not considered a leak, in terms of comments added to the
> >code. That will also help us reduce the number of annotations later on.
> 
> I'll document them in both Documentation/kmemleak.txt and inside the 
> code. If I implement the "any pointer inside the block" method, all 
> the memleak_padding() false positives will disappear.

i dont know - i feel uneasy about the 'any pointer' method - it has a 
high potential for false negatives, especially for structures that 
contain strings (or other random data), etc.

did you consider the tracking of the types of allocated blocks 
explicitly? I'd expect that most blocks dont have pointers embedded in 
them that point to allocated blocks. For the ones that do, the 
allocation could be extended with the type information. For each 
affected type, we could annotate the structures themselves with offset 
information. How intrusive would such a method be?

	Ingo
