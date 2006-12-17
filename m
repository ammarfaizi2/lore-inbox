Return-Path: <linux-kernel-owner+w=401wt.eu-S1751347AbWLQNbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWLQNbM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 08:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbWLQNbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 08:31:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33946 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbWLQNbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 08:31:11 -0500
Date: Sun, 17 Dec 2006 14:28:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061217132840.GA15892@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain> <20061216165738.GA5165@elte.hu> <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com> <20061217085859.GB2938@elte.hu> <20061217090943.GA9246@elte.hu> <20061217092828.GA14181@elte.hu> <b0943d9e0612170358r2b1ff36bi31270806b5ce1b53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0612170358r2b1ff36bi31270806b5ce1b53@mail.gmail.com>
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
> >one more thing: after bootup i need to access the /debug/memleak file 
> >twice to get any output from it - is that normal? The first 'cat 
> >/debug/memleak' gives no output (but there's the usual scanning 
> >delay, so memleak does do its work).
> 
> Yes, this is normal. Especially on SMP, I get some transient reports, 
> probably caused by pointers hold in registers (even more visible on 
> ARM due to the bigger number of registers per CPU). Reporting a leak 
> only if it was seen at least once before greatly reduces the false 
> positives (this is configurable as well but I'll drop the 
> configuration option). Without this, you could see that, at every 
> scan, the reported pointers are different.
> 
> Some people testing kmemleak used to read the /debug/memleak file 
> periodically from a script and this wasn't noticeable. It would be 
> even better if, as you suggested, I schedule a periodic memory 
> scanning.

yeah. You could also use the allocation timestamp to exclude too young 
entries. (if something really leaked then it will be a leak in 10 
minutes too)

	Ingo
