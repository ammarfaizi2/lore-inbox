Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVDBPG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVDBPG4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 10:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVDBPG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 10:06:56 -0500
Received: from mx1.elte.hu ([157.181.1.137]:33156 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261165AbVDBPGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 10:06:54 -0500
Date: Sat, 2 Apr 2005 16:58:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, christoph@lameter.com, kenneth.w.chen@intel.com
Subject: Re: [RFC][PATCH] timers fixes/improvements
Message-ID: <20050402145809.GB12613@elte.hu>
References: <424D373F.1BCBF2AC@tv-sign.ru> <20050402020700.16221f6f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050402020700.16221f6f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Oleg Nesterov <oleg@tv-sign.ru> wrote:
> >
> > +void fastcall init_timer(struct timer_list *timer)
> >  +{
> >  +	timer->entry.next = NULL;
> >  +	timer->_base = &per_cpu(tvec_bases,
> >  +			__smp_processor_id()).t_base;
> >  +	timer->magic = TIMER_MAGIC;
> >  +}
> 
> __smp_processor_id() is not implemented on all architectures.  I'll switch
> this to _smp_processor_id().
> 
> The smp_processor_id() stuff is all rather a twisty maze (looks at Ingo).

_smp_processor_id() is fine in this case - we pick a CPU at init_timer() 
time, but we dont need to be non-preemptible when we do so.

	Ingo
