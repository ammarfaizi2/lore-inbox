Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030822AbWKOSbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030822AbWKOSbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030826AbWKOSbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:31:01 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60635 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030822AbWKOSan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:30:43 -0500
Date: Wed, 15 Nov 2006 19:29:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
Message-ID: <20061115182915.GA2705@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <45075829.701@goop.org> <20060913095942.GA10075@elte.hu> <45082F1C.8000003@goop.org> <20061115182613.GA2227@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115182613.GA2227@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0835]
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > My test program does the same thing, except using GDT entries 6 and 
> > 7 (selectors 0x33 and 0x3b).
> 
> no, that's not what it does. It measures 50000000 switches of the 
> _same_ selector value, without using any of the selectors in the loop 
> itself. I.e. no mixing at all! But when the kernel and userspace uses 
> %gs, it's the cost of switching between two selector values of %gs 
> that has to be measured. Your code does not measure that at all, 
> AFAICS.

for example, your test_fs() code does:

        for(i = 0; i < COUNT; i++) {
                asm volatile("push %%fs; mov %1, %%fs; addl $1, %%fs:%0; popl %%fs"
                             : "+m" (*offset): "r" (seg) : "memory");
                sync();
        }

that loads (and uses) a single selector value for %fs, and doesnt do any 
mixed use as far as i can see.

	Ingo
