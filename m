Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUHTIRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUHTIRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267698AbUHTIRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:17:34 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2273 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264531AbUHTINi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:13:38 -0400
Date: Fri, 20 Aug 2004 10:14:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Lynch <nathanl@austin.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: 2.6.8.1-mm2
Message-ID: <20040820081458.GA4949@elte.hu>
References: <20040819014204.2d412e9b.akpm@osdl.org> <1092964083.4946.7.camel@biclops.private.network> <20040819181603.700a9a0e.akpm@osdl.org> <1092987650.28849.349.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092987650.28849.349.camel@bach>
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


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> +	/* Delayed cleanup on death of task with uncaring parent. */
> +	struct list_head death;

> +/* Keventd handles tasks whose parent won't ever release_task them. */
> +static DEFINE_PER_CPU(struct list_head, unreleased_tasks);
> +static DEFINE_PER_CPU(struct work_struct, release_task_work);

no! this removes the whole performance optimization of self-reaping and
re-introduces the context-switches. Just measure the
creation/destruction performance of threads. Strong NACK.

	Ingo
