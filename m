Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUFQNRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUFQNRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUFQNRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:17:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:51338 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266490AbUFQNOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:14:17 -0400
Date: Thu, 17 Jun 2004 15:15:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andi Kleen <ak@muc.de>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040617131530.GA26155@elte.hu>
References: <20040617121356.GA24338@elte.hu> <CBC4546BAB9F1Aindou.takao@soft.fujitsu.com> <20040617131016.GA25920@elte.hu> <20040617131140.GA26107@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617131140.GA26107@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > yes it can be done safely - just INIT_LIST_HEAD() all the timer list
> > heads - like init_timers_cpu() does.
> 
> obviously this only involves the dumping CPU - no other CPU will run
> any kernel code. On SMP you should also clear the timer spinlock of
> the dumping CPU's timer base, if the crash happened within the timer
> code.

put another way: you can consider 'safe dumping' to involve a simplified
bootup and initialization of the kernel's data structures that you need
during the dump, to create a barrier for any (possibly corrupted) kernel
data state prior the crash.

you need to 'boot up' your dumping data structures, the driver (and
hardware) you are going to use for dumping, and the timer code as well.

(total separation is not possible because e.g. the dumping code's
pagetable entries are a data structure too that could get corrupted - on
the other hand complete separation is not necessary because crash
statistics show that this is not a likely event - it is much more likely
to get failure due to hw errors.)

	Ingo
