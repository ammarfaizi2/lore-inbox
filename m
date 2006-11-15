Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030846AbWKOSoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030846AbWKOSoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030851AbWKOSoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:44:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55701 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030846AbWKOSoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:44:13 -0500
Date: Wed, 15 Nov 2006 19:43:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
Message-ID: <20061115184315.GA5078@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <45075829.701@goop.org> <20060913095942.GA10075@elte.hu> <45082F1C.8000003@goop.org> <20061115182613.GA2227@elte.hu> <455B5ED8.5090005@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455B5ED8.5090005@goop.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0589]
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Ingo Molnar wrote:
> > no, that's not what it does. It measures 50000000 switches of the _same_ 
> > selector value, without using any of the selectors in the loop itself. 
> > I.e. no mixing at all! But when the kernel and userspace uses %gs, it's 
> > the cost of switching between two selector values of %gs that has to be 
> > measured. Your code does not measure that at all, AFAICS.
> >   
> I think you're misreading it.  This is the inner loop:
> 
>         for(i = 0; i < COUNT; i++) {
>                 asm volatile("push %%gs; mov %1, %%gs; addl $1, %%gs:%0; popl %%gs"
>                              : "+m" (*offset): "r" (seg) : "memory");
>                 sync();
>         }
>         return "gs";
> 
> On entry, %gs will contain the normal usermode TLS selector.  "seg" is 
> another selector allocated with set_thread_area().  The asm pushes the 
> old %gs, loads the new one, uses a memory address via the new segment, 
> then restores the previous %gs.

but it does not actually use the 'normal usermode TLS selector' - it 
only loads it.

a meaningful test would be to allocate two selector values and load and 
read+write memory through both of them.

	Ingo
