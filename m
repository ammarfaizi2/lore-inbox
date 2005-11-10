Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVKJL2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVKJL2Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 06:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVKJL2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 06:28:24 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:38556 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750756AbVKJL2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 06:28:23 -0500
Date: Thu, 10 Nov 2005 12:28:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-ID: <20051110112833.GA32672@elte.hu>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com> <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com> <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com> <20051109185645.39329151.akpm@osdl.org> <20051109185859.03a8d2ac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109185859.03a8d2ac.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> >
> >  Well plan B is to kill spinlock_t.break_lock.
> 
> And plan C is to use a bit_spinlock() against page->flags.

please dont. Bit-spinlock is a PITA because it is non-debuggable and 
non-preempt-friendly. (In fact in -rt i have completely eliminated 
bit_spinlock(), because it's also such a PITA to type-encapsulate it 
sanely.)

	Ingo
