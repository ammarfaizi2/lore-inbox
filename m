Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269400AbUINPGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269400AbUINPGZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269379AbUINPDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:03:04 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59046 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269380AbUINO7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:59:25 -0400
Date: Tue, 14 Sep 2004 17:00:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: fix scheduling latencies in mtrr.c
Message-ID: <20040914150012.GB13113@elte.hu>
References: <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914132536.GA9742@elte.hu> <1095167722.16845.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095167722.16845.5.camel@localhost.localdomain>
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


* Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2004-09-14 at 14:25, Ingo Molnar wrote:
> > caveat: one of the wbinvd() removals is correct i believe, but the other
> > one might be problematic. It doesnt seem logical to do a wbinvd() at
> > that point though ...
> 
> See the intel ppro manual volume 3 page 11-25. Its quite specific
> about the sequence, so unless anything changes with AMD or later
> processors the change seems to match the description.
> 
> IRQs are required to be off far longer than this sequence according to
> the docs however, and PGE is supposed to be cleared too.

the problem is, we've had IRQs on in all of the 2.6 kernels so any
argument about extra wbinvd brings the obvious question: 'why did it
work so far'?

the only wbinvd that makes sense is the one you quote:

> Step 11: set CD flag
> Step 12: wbinvd
> Step 13: set pge in CR4 if previously cleared

and i agree that the pge thing should be fixed too.

	Ingo
