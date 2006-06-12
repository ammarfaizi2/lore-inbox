Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751851AbWFLKyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWFLKyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWFLKyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:54:40 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:21955 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751851AbWFLKyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:54:39 -0400
Date: Mon, 12 Jun 2006 12:53:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Message-ID: <20060612105345.GA8418@elte.hu>
References: <20060611111815.8641.7879.stgit@localhost.localdomain> <20060611112156.8641.94787.stgit@localhost.localdomain> <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com> <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com> <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
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

> On Mon, 12 Jun 2006, Catalin Marinas wrote:
> > I thought about this as well (I think that's how Valgrind works) but
> > it would increase the chances of missing real leaks.
> 
> Yeah but that's far better than adding bunch of 'not a leak' 
> annotations around the kernel which is very impractical to maintain.  
> I would like to see your leak detector in the kernel so we can finally 
> get rid of all those per-subsystem magic allocators.  This patch, 
> however, is unacceptable for inclusion IMHO.

While it's always good to reduce the amount of false positives, i dont 
think it's unacceptable for inclusion right now. A few dozen annotations 
out of 7000+ allocation call sites isnt a big maintainance problem - and 
the benefits of automatic leak-checking are really huge. The impact only 
appears to be large because the patch is trying to cover an initial 7+ 
million lines of codebase. The followup per-kernel-release overhead will 
be minimal, and will be offset by the quality increase of the kernel and 
by the productivity increase that comes due to developers not having to 
do long searches for kernel memory leaks. The debugging cost of a single 
leak found can far outweigh the cost of 10 annotations (or more).

What i'd like to see though are clear explanations about why an 
allocation is not considered a leak, in terms of comments added to the 
code. That will also help us reduce the number of annotations later on.

	Ingo
