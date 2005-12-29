Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVL2OyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVL2OyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVL2OyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:54:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750747AbVL2OyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:54:15 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
In-Reply-To: <20051229143846.GA18833@infradead.org>
References: <20051228114637.GA3003@elte.hu>
	 <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051229143846.GA18833@infradead.org>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 15:54:09 +0100
Message-Id: <1135868049.2935.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't care too much whether we put always_inline or inline at the function
> we _really_ want to inline.  But all others shouldn't have any inline marker.
> So instead of changing the pretty useful redefinitions we have to keep the
> code a little more readable what about getting rid of all the stupid inlines
> we have over the place? 

just in drivers/ there are well over 6400 of those. Changing most of
those is going to be a huge effort. The reality is, most driver writers
(in fact kernel code writers) tend to overestimate the gain of inline in
THEIR code, and to underestimate the cumulative cost of it. Despite what
akpm says, I think gcc can make a better judgement than most of these
authors (probably including me :). We can remove 6400 now, but a year
from now, another 1000 have been added back again I bet.

You describe a nice utopia where only the most essential functions are
inlined.. but so far that hasn't worked out all that well ;) Turning
"inline" back into the hint to the compiler that the C language makes it
is maybe a cop-out, but it's a sustainable approach at least.

> I think many things we have static inline in headers
> now should move to proper out of line functions.

I suspect the biggest gains aren't the ones in the headers; those tend
to be quite small and often mostly optimize away due to constant
arguments (there may be a few exceptions of course), and also have been
attacked by various people in the 2.5/2.6 series before. It's the local
functions that got too many "inline" hints.



