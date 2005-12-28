Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVL1VCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVL1VCi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 16:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVL1VCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 16:02:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964909AbVL1VCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 16:02:37 -0500
Date: Wed, 28 Dec 2005 13:02:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <1135798495.2935.29.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
References: <20051228114637.GA3003@elte.hu>  <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
 <1135798495.2935.29.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Dec 2005, Arjan van de Ven wrote:
> 
> yup that's why the patch only does it for gcc4, in which the inlining
> heuristics finally got rewritten to something that seems to resemble
> sanity...

Is that actually true of all gcc4 versions? I seem to remember gcc-4.0 
being a real stinker.

> > Also, the inlining patch apparently makes code larger in some cases, 
> > so it's not even a unconditional win.
> 
> .... as long as you give the inlining algorithm enough information. 
> -fno-unit-at-a-time prevents gcc from having the information, and the 
> decisions it makes are then less optimal...
> 
> (unit-at-a-time allows gcc to look at the entire .c file, eg things like
> number of callers etc etc, disabling that tells gcc to do the .c file as
> single pass top-to-bottom only)

I'd still prefer to see numbers with -funit-at-a-time only. I think it's 
an independent knob, and I'd be much less worried about that, because we 
do know that unit-at-a-time has been enabled on x86-64 for a long time 
("forever"). So that's less of a change, I feel. 

			Linus
