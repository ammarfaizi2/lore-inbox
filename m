Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbVL1VRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVL1VRK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 16:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbVL1VRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 16:17:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5840 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964912AbVL1VRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 16:17:09 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
In-Reply-To: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
References: <20051228114637.GA3003@elte.hu>
	 <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 22:17:01 +0100
Message-Id: <1135804621.8976.1.camel@laptopd505.fenrus.org>
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

On Wed, 2005-12-28 at 13:02 -0800, Linus Torvalds wrote:
> 
> On Wed, 28 Dec 2005, Arjan van de Ven wrote:
> > 
> > yup that's why the patch only does it for gcc4, in which the inlining
> > heuristics finally got rewritten to something that seems to resemble
> > sanity...
> 
> Is that actually true of all gcc4 versions? I seem to remember gcc-4.0 
> being a real stinker.

it is... if you disable unit-at-a-time for sure.
But I'm not entirely sure when this got in, if it was 4.0 or 4.1

> > (unit-at-a-time allows gcc to look at the entire .c file, eg things like
> > number of callers etc etc, disabling that tells gcc to do the .c file as
> > single pass top-to-bottom only)
> 
> I'd still prefer to see numbers with -funit-at-a-time only. I think it's 
> an independent knob, and I'd be much less worried about that, because we 
> do know that unit-at-a-time has been enabled on x86-64 for a long time 
> ("forever"). So that's less of a change, I feel. 

the only effect I expect is more inlining actually, since we on the one
hand tie gcc's hands via the forced inline, and one the other hand now
give it more room to inline more. But yeah it's worth to look at for
sure, even if it is to see it's getting bigger ;) 

