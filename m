Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270184AbUJTIhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270184AbUJTIhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 04:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270243AbUJTIhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:37:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64710 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270184AbUJTIcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 04:32:43 -0400
Date: Wed, 20 Oct 2004 10:33:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, torvalds@osdl.org, anton@samba.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Fix PREEMPT_ACTIVE definition
Message-ID: <20041020083358.GB23396@elte.hu>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16758.3807.954319.110353@cargo.ozlabs.ibm.com>
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


* Paul Mackerras <paulus@samba.org> wrote:

> When the generic IRQ stuff went in, it seems that HARDIRQ_BITS got
> bumped from 9 (for ppc64) up to 12.  Consequently, the PREEMPT_ACTIVE
> bit is now within HARDIRQ_MASK, and I get in_interrupt() falsely
> returning true when PREEMPT_ACTIVE is set, and thus a BUG_ON tripping
> in arch/ppc64/mm/tlb.c.

indeed! The reason why this problem didnt trigger on the other
architectures is that the in_atomic() test is separate and excludes
PREEMPT_ACTIVE.

> The patch below fixes this by changing PREEMPT_ACTIVE to 0x10000000. I
> have changed the PREEMPT_ACTIVE definitions for each of the
> architectures that define CONFIG_GENERIC_HARDIRQS (i386, ppc, ppc64,
> x86_64) and fixed the comment in include/linux/hardirq.h.  We could
> perhaps move the PREEMPT_ACTIVE definition to include/linux/hardirq.h
> - I don't know why it is still per-arch.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
