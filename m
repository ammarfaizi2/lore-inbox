Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVATQdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVATQdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVATQau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:30:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:61612 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262270AbVATQ25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:28:57 -0500
Date: Thu, 20 Jan 2005 17:28:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, Peter Chubb <peterc@gelato.unsw.edu.au>,
       Tony Luck <tony.luck@intel.com>,
       Darren Williams <dsw@gelato.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ia64 Linux <linux-ia64@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH RFC] 'spinlock/rwlock fixes' V3 [1/1]
Message-ID: <20050120162836.GA14726@elte.hu>
References: <20050116230922.7274f9a2.akpm@osdl.org> <20050117143301.GA10341@elte.hu> <20050118014752.GA14709@cse.unsw.EDU.AU> <16877.42598.336096.561224@wombat.chubb.wattle.id.au> <20050119080403.GB29037@elte.hu> <16878.9678.73202.771962@wombat.chubb.wattle.id.au> <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com> <20050120023445.GA3475@taniwha.stupidest.org> <Pine.LNX.4.58.0501200812300.8178@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501200812300.8178@ppc970.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> And it probably should be in <asm-i386/rwlock.h>, since that is where
> the actual implementation is, and <asm-i386/spinlock.h> doesn't really
> have any clue what the rules are, and shouldn't act like it has.

historically spinlock.h had the full implementation of both spinlock
variants: spinlocks and rwlocks. (hey, you implemented it first and put
it there! :-) Then came Ben's rwsems that wanted pieces of rw-spinlocks,
so rwlock.h was created with the shared bits.

one thing i was thinking about was to move most but the assembly to
asm-generic/spinlock.h. Almost every architecture shares the spinlock
type definitions and shares most of the non-assembly functions.

	Ingo
