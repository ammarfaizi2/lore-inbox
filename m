Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751942AbWFLNNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbWFLNNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 09:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbWFLNNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 09:13:05 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:49603 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751942AbWFLNNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 09:13:04 -0400
Date: Mon, 12 Jun 2006 15:12:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Message-ID: <20060612131209.GB17463@elte.hu>
References: <20060611111815.8641.7879.stgit@localhost.localdomain> <20060611112156.8641.94787.stgit@localhost.localdomain> <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com> <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com> <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI> <20060612105345.GA8418@elte.hu> <Pine.LNX.4.58.0606121404080.7129@sbz-30.cs.Helsinki.FI> <20060612113637.GA14136@elte.hu> <Pine.LNX.4.58.0606121446130.7129@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0606121446130.7129@sbz-30.cs.Helsinki.FI>
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


* Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:

> > >   - arch/i386/kernel/setup.c:
> > >     False positive because res pointer is stored in a global instance of
> > >     struct resource.
> > 
> > there's no good way around this one but to annotate it in one way or 
> > another.
> 
> Scanning bss and data sections is too expensive, I guess.  I would 
> prefer we create a separate section for gc roots but what you're 
> suggesting is ok as well.

kmemleak does scan global data sections. I dont know why we dont 
discover this particular pointer though: the resource pointer ought to 
be accessible via the iomem_resource.parent/sibling/child sorted list. 
Hm.

	Ingo
