Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUFQNMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUFQNMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUFQNMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:12:05 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18626 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266485AbUFQNK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:10:28 -0400
Date: Thu, 17 Jun 2004 15:11:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andi Kleen <ak@muc.de>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040617131140.GA26107@elte.hu>
References: <20040617121356.GA24338@elte.hu> <CBC4546BAB9F1Aindou.takao@soft.fujitsu.com> <20040617131016.GA25920@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617131016.GA25920@elte.hu>
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

> * Takao Indoh <indou.takao@soft.fujitsu.com> wrote:
> 
> > It sounds good because change of timer/tasklet code is not needed.
> > But, I wonder whether this method is safe. For example, if kernel
> > crashes because of problem of timer, clearing lists may be dangerous
> > before dumping. Is it possible to clear all timer lists safely?
> 
> yes it can be done safely - just INIT_LIST_HEAD() all the timer list
> heads - like init_timers_cpu() does.

obviously this only involves the dumping CPU - no other CPU will run any
kernel code. On SMP you should also clear the timer spinlock of the
dumping CPU's timer base, if the crash happened within the timer code.

	Ingo
