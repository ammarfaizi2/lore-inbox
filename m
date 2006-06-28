Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030476AbWF1H77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbWF1H77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWF1H77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:59:59 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:13525 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030476AbWF1H76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:59:58 -0400
Date: Wed, 28 Jun 2006 09:55:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Zou Nan hai <nanhai.zou@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] jbd commit code deadloop when installing Linux
Message-ID: <20060628075511.GA11948@elte.hu>
References: <1151470123.6052.17.camel@linux-znh> <20060627234005.dda13686.akpm@osdl.org> <20060628063859.GA9726@elte.hu> <20060627235500.8c2c290e.akpm@osdl.org> <1151473582.6052.28.camel@linux-znh> <20060628004029.efcc8a03.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628004029.efcc8a03.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5102]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > However I think cond_resched_lock and cond_resched_softirq also need fix
> > to make the semantic consistent.
> > 
> > Please check the following patch.
> > 
> 
> Ah.  I think the return value from these functions should mean 
> "something disruptive happened", if you like.
> 
> See, the callers of cond_resched_lock() aren't interested in whether 
> cond_resched_lock() actually called schedule().  They want to know 
> whether cond_resched_lock() dropped the lock.  Because if the lock was 
> dropped, the caller needs to take some special action, regardless of 
> whether schedule() was finally called.

indeed ...!

> So I think the patch I queued is OK, agree?

yeah.

i think the really-right-fix would be to get rid of that SYSTEM_BOOTING 
ugliness though ... I'm quite a bit uneasy about us doing different 
things for an initrd app than for fully booted apps.

	Ingo
