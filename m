Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWGJHpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWGJHpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 03:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGJHpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 03:45:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:56470 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751018AbWGJHpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 03:45:08 -0400
Date: Mon, 10 Jul 2006 09:40:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rc1-mm1
Message-ID: <20060710074039.GA26853@elte.hu>
References: <20060709021106.9310d4d1.akpm@osdl.org> <6bffcb0e0607090332i477d594fq9ef96721574ae91b@mail.gmail.com> <20060709035203.cdc3926f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709035203.cdc3926f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5010]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > This looks like a problem with cpufreq.
> > 
> > =======================================================
> > [ INFO: possible circular locking dependency detected ]
> > -------------------------------------------------------
> > cpuspeed/1426 is trying to acquire lock:
> >  (&inode->i_data.tree_lock){.+..}, at: [<c0151dc7>] find_get_page+0x12/0x70
> > 
> > but task is already holding lock:
> >  (&mm->mmap_sem){----}, at: [<c0116cab>] do_page_fault+0x10d/0x4ea
> > 
> > which lock already depends on the new lock.
> > 
> 
> rofl.  You broke lockdep.

ouch! the lock identifications look quite funny :-| Never saw that 
happen before, i'm wondering what's going on. Michal, did this happen 
straight during bootup? Or did you remove/recompile/reinsert any modules 
perhaps?

> Well.  I guess it's barely conceivable that you earlier took an oops 
> while holding tree_lock, so lockdep decided that mmap_sem nests inside 
> tree_lock.

Arjan is preparing a patch to turn off lockdep when we crash. Although i 
dont see any trace of an earlier oops in the dmesg.

	Ingo
