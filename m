Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbUAPKPu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 05:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUAPKPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 05:15:50 -0500
Received: from colin2.muc.de ([193.149.48.15]:20740 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265350AbUAPKPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 05:15:34 -0500
Date: 16 Jan 2004 11:16:31 +0100
Date: Fri, 16 Jan 2004 11:16:31 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-ID: <20040116101631.GB96037@colin2.muc.de>
References: <1bSHD-Xz-21@gated-at.bofh.it> <1e2sZ-rG-19@gated-at.bofh.it> <1e3Ih-1V0-1@gated-at.bofh.it> <1e7Cd-4qD-5@gated-at.bofh.it> <1einZ-64E-11@gated-at.bofh.it> <1ekpM-87C-1@gated-at.bofh.it> <1euyS-Eb-19@gated-at.bofh.it> <1euSb-U8-3@gated-at.bofh.it> <m3n08o1erp.fsf@averell.firstfloor.org> <20040116003520.3b55aa8e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116003520.3b55aa8e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  static inline void bitmap_complement(unsigned long *bitmap, int bits)
> >  {
> >         int k;
> > +       int max = BITS_TO_LONGS(bits);
> >  
> > -       for (k = 0; k < BITS_TO_LONGS(bits); ++k)
> > +       for (k = 0; k < max; ++k)
> >                 bitmap[k] = ~bitmap[k];
> 
> OK.  bitmap_and() and bitmap_or() were converted to this form a while back
> because they too were hitting the bug.  On ia32.  It might no longer
> happen now they're uninlined but whatever - you don't have to look
> at the code and think "gee, I hope the compiler moves that arith out
> of the loop".

BTW I think the original point of the inlining was that when you have bits ==
BITS_PER_LONG the function could collapse to a single ~ operation using
the compiler's optimizer. That would be the case with nodemasks on x86-64. 
As for the NUMA API i don't care particularly because there is no bitmap 
manipulation in any fast path. Avoiding miscompilations is definitely 
higher priority. 

-Andi
