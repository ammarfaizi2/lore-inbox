Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265156AbTLZJ7N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 04:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265160AbTLZJ7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 04:59:13 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:60833 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265156AbTLZJ7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 04:59:12 -0500
Subject: Re: Page aging broken in 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: arjanv@redhat.com
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>
In-Reply-To: <1072430500.5222.2.camel@laptop.fenrus.com>
References: <1072423739.15458.62.camel@gaston>
	 <20031225234023.20396cbc.akpm@osdl.org>
	 <1072430500.5222.2.camel@laptop.fenrus.com>
Content-Type: text/plain
Message-Id: <1072432706.15477.66.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Dec 2003 20:58:27 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-26 at 20:21, Arjan van de Ven wrote:
> > > And we never flush the TLB entry. 
> > > 
> > > I don't know if x86 (or other archs really using page tables) will
> > > actually set the referenced bit again in the PTE if it's already set
> > > in the TLB, if not, then x86 needs a flush too.
> > 
> > x86 needs a flush_tlb_page(), yes.
> 
> it does? Are you 100% sure ?
> 
> Afaik x86 is very very slow in setting the A and D bits (like 2000 to
> 3000 cycles) *because* it doesn't need a TLB flush....

How does this work ? If x86 always update those bits even when the
TLB copy has them already set, then it will keep writing to the PTEs
on every access... which I doubt it does ;) Or does it snoop accesses
to the PTE to "catch" somebody clearing the bits ?

Ben.


