Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVL2Oiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVL2Oiu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVL2Oiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:38:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39402 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750731AbVL2Oit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:38:49 -0500
Date: Thu, 29 Dec 2005 14:38:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229143846.GA18833@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Matt Mackall <mpm@selenic.com>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228214845.GA7859@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> another thing: i wanted to decrease the size of -Os 
> (CONFIG_CC_OPTIMIZE_FOR_SIZE) kernels, which e.g. Fedora uses too (to 
> keep the icache footprint down).
> 
> I think gcc should arguably not be forced to inline things when doing 
> -Os, and it's also expected to mess up much less than when optimizing 
> for speed. So maybe forced inlining should be dependent on 
> !CONFIG_CC_OPTIMIZE_FOR_SIZE?

I don't care too much whether we put always_inline or inline at the function
we _really_ want to inline.  But all others shouldn't have any inline marker.
So instead of changing the pretty useful redefinitions we have to keep the
code a little more readable what about getting rid of all the stupid inlines
we have over the place?  I think many things we have static inline in headers
now should move to proper out of line functions.  This is more work, but also
more useful than just flipping a bit.

