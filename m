Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753586AbWKGXkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbWKGXkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 18:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbWKGXkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 18:40:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56020 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1753586AbWKGXku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 18:40:50 -0500
Date: Wed, 8 Nov 2006 00:39:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Eric Sandeen <sandeen@sandeen.net>,
       Srinivasa DS <srinivasa@in.ibm.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061107233938.GA2498@elte.hu>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061107122837.54828e24.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061107122837.54828e24.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> If so, it's a bit sad to switch to semaphore just because of some 
> errant debugging code.  Perhaps it would be better to create a new 
> mutex_unlock_stfu() which suppresses the warning?

the code was not using semaphores as a pure mutex thing. For example 
unlocking by non-owner is not legal. AFAICS the code returns to 
userspace with a held in-kernel mutex. That makes it hard for the kernel 
to determine for example whether the lock has been 'forgotten', or kept 
like that intentionally. Alasdair, what is the motivation for doing it 
like that?

	Ingo
