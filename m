Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWHYOFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWHYOFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWHYOFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:05:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38051 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932164AbWHYOFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:05:37 -0400
Date: Fri, 25 Aug 2006 15:58:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       len.brown@intel.com, akpm@osdl.org, jbarnes@virtuousgeek.org,
       dwalker@mvista.com, nickpiggin@yahoo.com.au
Subject: Re: [RFC] maximum latency tracking infrastructure (version 2)
Message-ID: <20060825135815.GA29706@elte.hu>
References: <1156504939.3032.26.camel@laptopd505.fenrus.org> <20060825133034.GC5205@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825133034.GC5205@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4998]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> > +#ifndef _INCLUDE_GUARD_LATENCY_H_
> > +#define _INCLUDE_GUARD_LATENCY_H_
> > +
> > +#include <linux/notifier.h>
> 
> Just
> 	struct notifier_block;

not really. Either use the #include, or if you want less stuff included, 
split notifier.h into notifier_types.h and notifier.h and move the data 
structure declarations to notifier_types.h and then #include 
notifier_types.h. (spinlock_types.h works like this.) This allows 
headers to be separated into pure 'data structure' and 'access methods' 
portions. Using explicit forward declarations is less cleaner.

	Ingo
