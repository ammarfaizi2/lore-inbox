Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVHIJt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVHIJt7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVHIJt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:49:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49352 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932493AbVHIJt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:49:58 -0400
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, ncunningham@cyclades.com,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <42F877FF.9000803@yahoo.com.au>
References: <42F57FCA.9040805@yahoo.com.au>
	 <200508090710.00637.phillips@arcor.de>
	 <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au>
	 <20050809080853.A25492@flint.arm.linux.org.uk>
	 <1123576719.3839.13.camel@laptopd505.fenrus.org>
	 <42F877FF.9000803@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 11:49:44 +0200
Message-Id: <1123580985.3839.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Tue, 2005-08-09 at 19:31 +1000, Nick Piggin wrote:
> Arjan van de Ven wrote:
> > On Tue, 2005-08-09 at 08:08 +0100, Russell King wrote:
> 
> >>Can we straighten out the terminology so it's less confusing please?
> >>
> > 
> > 
> > and..... can we make a general page_is_ram() function that does what it
> > says? on x86 it can go via the e820 table, other architectures can do
> > whatever they need....
> > 
> 
> That would be very helpful. That should cover the remaining (ab)users
> of PageReserved.
> 
> It would probably be fastest to implement this with a page flag,
> however if swsusp and ioremap are the only users then it shouldn't
> be a problem to go through slower lookups (and this would remove the
> need for the PageValidRAM flag that I had worried about earlier).

if you want I have implementations of this for x86, x86_64 and iirc ia64
(not 100% sure about the later). None of these use a page flag, but use
the same information the kernel uses during bootup to find ram.


