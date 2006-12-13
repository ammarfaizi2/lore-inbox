Return-Path: <linux-kernel-owner+w=401wt.eu-S965071AbWLMUGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWLMUGS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWLMUGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:06:18 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51969 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965071AbWLMUGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:06:17 -0500
Date: Wed, 13 Dec 2006 21:04:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jim.houston@ccur.com,
       sunil.mushran@oracle.com
Subject: Re: [PATCH] Conditionally check expected_preempt_count in __resched_legal()
Message-ID: <20061213200422.GA992@elte.hu>
References: <20061213195537.GH6831@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213195537.GH6831@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Fasheh <mark.fasheh@oracle.com> wrote:

> Commit 2d7d253548cffdce80f4e03664686e9ccb1b0ed7 ("fix cond_resched() fix")
> introduced an 'expected_preempt_count' parameter to __resched_legal() to fix
> a bug where it was returning a false negative when called from
> cond_resched_lock() and preemption was enabled.
> 
> Unfortunately this broke things for when preemption is disabled.
> preempt_count() will always return zero, thus failing the check against
> any value of expected_preempt_count not equal to zero. cond_resched_lock()
> for example, passes an expected_preempt_count value of 1.
> 
> So fix the fix for the cond_resched() fix by skipping the check of
> preempt_count() against expected_preempt_count when preemption is disabled.
> 
> Credit should go to Sunil Mushran for spotting the bug during testing.
> 
> Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>

well spotted. I'm wondering whether this piece of code has the highest 
amount of fixes per line of code ratio in the whole kernel ...

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
