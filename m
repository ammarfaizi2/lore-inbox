Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268593AbUH3RkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268593AbUH3RkT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUH3Riy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:38:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:955 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268593AbUH3Rhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:37:40 -0400
Date: Mon, 30 Aug 2004 19:37:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "K.R. Foley" <kr@cybsft.com>, Lee Revell <rlrevell@joe-job.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q4
Message-ID: <20040830173747.GA7319@elte.hu>
References: <1093727453.8611.71.camel@krustophenia.net> <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <1093762642.1348.3.camel@krustophenia.net> <20040829190655.GA8840@elte.hu> <4132793C.4030703@cybsft.com> <1093871169.30069.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093871169.30069.4.camel@localhost.localdomain>
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

> On Llu, 2004-08-30 at 01:47, K.R. Foley wrote:
> > Aug 29 09:32:50 daffy kernel: requesting new irq thread for IRQ1...
> > Aug 29 09:32:50 daffy kernel: atkbd.c: Spurious ACK on isa0060/serio1. 
> > Some program, like XFree86, might be trying access hardware directly.
> 
> This is a known bug in the ps/2 driver layer. The printk can be
> triggered by multiple quite valid situations. I've suggested it be
> removed several times. Also XFree86 is a trademark so it should be
> XFree86(tm) ;)

since the message was right during detection it was indication of deeper
trouble - and indeed it was caused by the IRQ1 thread being starved by
init and thus the handler not running at all - the 'spurious ACK' was a
weird (and probably buggy) way of the PS2 layer telling that the
expected IRQ never arrived ...

in any case, this was a bug in the hardirq redirection code.

	Ingo
