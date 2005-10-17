Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVJQHUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVJQHUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVJQHUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:20:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932095AbVJQHUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:20:11 -0400
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8
	bits
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20051017000343.782d46fc.akpm@osdl.org>
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
	 <1129035658.23677.46.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org>
	 <434BDB1C.60105@cosmosbay.com>
	 <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org>
	 <434BEA0D.9010802@cosmosbay.com>  <20051017000343.782d46fc.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 09:20:03 +0200
Message-Id: <1129533603.2907.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 00:03 -0700, Andrew Morton wrote:
> Eric Dumazet <dada1@cosmosbay.com> wrote:
> >
> >  2) The unlock sequence is not anymore inlined. It appears twice or three times 
> >  in the kernel.
> 
> Is that intentional though?  With <randon .config> my mm/swapfile.i has an
> unreferenced
> 
> static inline void __raw_spin_unlock(raw_spinlock_t *lock)
> {
> 	__asm__ __volatile__(
> 		"movb $1,%0" :"=m" (lock->slock) : : "memory" 
> 	);
> }
> 
> which either a) shouldn't be there or b) should be referenced.
> 
> Ingo, can you confirm that x86's spin_unlock is never inlined?  If so,
> what's my __raw_spin_unlock() doing there?

I would really want this one inlined! 
A movb is a much shorter code sequence than a call (esp if you factor in
argument setup). De-inlining to save space is nice and all, but it can
go too far....



