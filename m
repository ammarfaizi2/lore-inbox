Return-Path: <linux-kernel-owner+w=401wt.eu-S1753606AbWL0Quq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbWL0Quq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 11:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbWL0Quq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 11:50:46 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37232 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbWL0Qup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 11:50:45 -0500
Date: Wed, 27 Dec 2006 17:47:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061227164745.GA10077@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain> <20061216165738.GA5165@elte.hu> <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com> <20061217085859.GB2938@elte.hu> <20061217090943.GA9246@elte.hu> <20061217092828.GA14181@elte.hu> <20061217094143.GA15372@elte.hu> <b0943d9e0612270814m30fe8813mad20f22f9d188896@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0612270814m30fe8813mad20f22f9d188896@mail.gmail.com>
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


* Catalin Marinas <catalin.marinas@gmail.com> wrote:

> On 17/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> >it would be nice to record 1) the jiffies value at the time of
> >allocation, 2) the PID and the comm of the task that did the allocation.
> >The jiffies timestamp would be useful to see the age of the allocation,
> >and the PID/comm is useful for context.
> 
> Trying to copy the comm with get_task_comm, I get the lockdep report 
> below, caused by acquiring the task's alloc_lock. Any idea how to go 
> around this?

just memcpy p->comm without any locking. It's for the current task, 
right? That does not need any locking.

	Ingo
