Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVFBQUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVFBQUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVFBQU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:20:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26524 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261189AbVFBQTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:19:51 -0400
Date: Thu, 2 Jun 2005 18:16:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Ingo Oeser <ioe-lkml@axxeo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] [patch] consolidate/clean up spinlock.h files
Message-ID: <20050602161633.GA12616@elte.hu>
References: <20050602144004.GA31807@elte.hu> <200506021749.15206.ioe-lkml@axxeo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506021749.15206.ioe-lkml@axxeo.de>
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


* Ingo Oeser <ioe-lkml@axxeo.de> wrote:

> Hi Ingo,
> you wrote:
> 
> > --- linux/lib/spinlock_debug.c.orig
> > +++ linux/lib/spinlock_debug.c
> > +#define SPIN_BUG_ON(cond, lock, msg) \
> > +		if (unlikely(cond)) spin_bug(lock, __FILE__, __LINE__, msg)
> > +#define RWLOCK_BUG_ON(cond, lock, msg) \
> > +		if (unlikely(cond)) rwlock_bug(lock, __FILE__, __LINE__, msg)
> 
> I would suggest propagating the __FILE__ and __LINE__ from the CALLERS 
> of those functions in lib/spinlock_debug.c into these macros, to make 
> this info more useful. At the moment you just know, that the bug 
> happend on some spinlock/rwlock, but not who caused this.

the real call site info comes from dump_stack(). Maybe i should remove 
the __FILE__,__LINE__ info altogether. (albeit a bit redundancy wont 
hurt) I dont think we want to pass in __FILE__,__LINE__ all the way from 
the main APIs.

	Ingo
