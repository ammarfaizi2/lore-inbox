Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUHBHq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUHBHq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 03:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUHBHq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 03:46:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9102 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266341AbUHBHqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 03:46:48 -0400
Date: Mon, 2 Aug 2004 09:47:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: lkml@lpbproduction.scom, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
Message-ID: <20040802074740.GC8332@elte.hu>
References: <20040713143947.GG21066@holomorphy.com> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <200408011644.06537.lkml@lpbproductions.com> <1091427964.1827.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091427964.1827.3.camel@teapot.felipe-alfaro.com>
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


* Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:

> > kernel/hardirq.c:51: error: conflicting types for 'generic_handle_IRQ_event'
> > include/linux/irq.h:78: error: previous declaration of 
> > 'generic_handle_IRQ_event' was here

> Try removing the "asmlinkage" from the definition of
> "generic_handle_IRQ_event" in file "kernel/hardirq.c".

i solved it by adding asmlinkage to irq.h - i've updated the -O2 patch
to include this fix. It needs to stay asmlinkage because e.g. the 4K
stacks code calls it from within an assembly section which assumes the
function follows the normal calling convention (and not e.g. regparm).

	Ingo
