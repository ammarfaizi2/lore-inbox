Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVL3KPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVL3KPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 05:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVL3KPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 05:15:13 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:9129 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751236AbVL3KPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 05:15:11 -0500
Date: Fri, 30 Dec 2005 11:14:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Jakub Jelinek <jakub@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230101443.GA13072@elte.hu>
References: <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051229143846.GA18833@infradead.org> <1135868049.2935.49.camel@laptopd505.fenrus.org> <20051229153529.GH3811@stusta.de> <20051229154241.GY22293@devserv.devel.redhat.com> <p73oe2zexx9.fsf@verdi.suse.de> <20051230094045.GA5799@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051230094045.GA5799@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > I'm not quite sure I buy Ingo's original argument also.  If he's only 
> > looking at text size then with the above fixed then he ideally would 
> > like to not inline anything (because except these exceptions above 
> > .text usually near always shrinks when not inlining). But that's not 
> > necessarily best for performance.
> 
> well, i think the numbers talk for themselves. Here are my latest 
> results:

i now have x86 allyesconfig numbers too:

    text     data     bss      dec  filename
 24190215 6737902 1775592 32703709  vmlinux-allyes-speed-orig
 20096423 6758758 1775592 28630773  vmlinux-allyes-orig
 19223511 6844002 1775656 27843169  vmlinux-allyes-inline+units+fixes+capable

i.e. enabling CONFIG_CC_OPTIMIZE_FOR_SIZE gives a 20.4% size reduction, 
and adding my latest debloating-queue ontop of gives an additional 4.5% 
of reduction. The queue is at:

  http://redhat.com/~mingo/debloating-patches/

note: my focus is still mostly on CC_OPTIMIZE_FOR_SIZE (which is only 
offered if CONFIG_EMBEDDED is enabled) - if you want a larger kernel 
optimized for speed, do not enable it.

	Ingo
