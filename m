Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWFNME3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWFNME3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWFNME3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:04:29 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58808 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751245AbWFNME3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:04:29 -0400
Date: Wed, 14 Jun 2006 14:03:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Message-ID: <20060614120326.GA23337@elte.hu>
References: <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com> <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI> <20060612105345.GA8418@elte.hu> <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com> <20060612192227.GA5497@elte.hu> <Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI> <20060613072646.GA17978@elte.hu> <b0943d9e0606130349s24614bbcia6a650342437d3d1@mail.gmail.com> <20060614040707.GA7503@elte.hu> <448FA476.8000705@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448FA476.8000705@goop.org>
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


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> This seems pretty over-engineered.  I wouldn't go this far unless 
> you're actually seeing performance/correctness problems, and a simple 
> with/without pointers flag isn't enough.  It also doesn't address the 
> most troublesome source of false pointers: stacks.  There is all sorts 
> of junk lying around on stacks, and you can have an old dead pointer 
> sitting there pinning old dead memory for a long time.

in an earlier thread i suggested to not scan kernel stacks at all, but 
to delay the registration of new blocks to return-from-syscall time (via 
having a per-task list of newly allocated but not yet registered 
blocks). That way we dont get false positives for stuff that is on the 
kernel stack temporarily and then freed, and we correctly register newly 
allocated blocks as well.

	Ingo
