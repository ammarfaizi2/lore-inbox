Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbVLaOqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbVLaOqG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 09:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVLaOqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 09:46:06 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:48793 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964933AbVLaOqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 09:46:01 -0500
Date: Sat, 31 Dec 2005 15:45:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051231144534.GA5826@elte.hu>
References: <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org> <20051229224839.GA12247@elte.hu> <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de> <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051231143800.GJ3811@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> On Fri, Dec 30, 2005 at 08:49:16AM +0100, Ingo Molnar wrote:
> > 
> > * Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> > 
> > > What about the previous suggestion to remove inline from *all* static 
> > > inline functions in .c files?
> > 
> > i think this is a way too static approach. Why go from one extreme to 
> > the other, when my 3 simple patches (which arguably create a more 
> > flexible scenario) gives us savings of 7.7%?
> 
> This point only discusses the inline change, which were (without 
> unit-at-a-time) in your measurements 2.9%.
> 
> Your patch might be simple, but it also might have side effects in 
> cases where we _really_ want the code forced to be inlined. How simple 
> is it to prove that your uninline patch doesn't cause a subtle 
> breakage somewhere?

it's quite simple: run the latency tracer with stack-trace debugging 
enabled, and it will measure the worst-case stack footprint that is 
triggered on that system. Obviously any compiler version change or 
option change can cause problems, there's nothing new about it - and 
it's not realistic to wait one year for changes like that. If you have 
to wait that long, you are testing it the wrong way.

	Ingo
