Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030812AbWKOS1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030812AbWKOS1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030813AbWKOS1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:27:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41669 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030812AbWKOS1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:27:13 -0500
Date: Wed, 15 Nov 2006 19:26:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
Message-ID: <20061115182613.GA2227@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <45075829.701@goop.org> <20060913095942.GA10075@elte.hu> <45082F1C.8000003@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45082F1C.8000003@goop.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Ingo Molnar wrote:
> >well, the most important thing i believe you didnt test: the effect of 
> >mixing two descriptors on the _same_ selector: one %gs selector value 
> >loaded and used by glibc, and another %gs selector value loaded and used 
> >by the kernel, intermixed. It's the mixing that causes the descriptor 
> >cache reload. (unless i missed some detail about your testcase)
> 
> But it doesn't mix different descriptors on the same selector; the GDT 
> is initialized when the CPU is brought up, and is unchanged from then 
> on.  The PDA descriptor is GDT entry 27 and the userspace TLS entries 
> are 6-8, so in the typical case %gs will alternate between 0x33 and 
> 0xd8 as it enters and leaves the kernel.
> 
> My test program does the same thing, except using GDT entries 6 and 7 
> (selectors 0x33 and 0x3b).

no, that's not what it does. It measures 50000000 switches of the _same_ 
selector value, without using any of the selectors in the loop itself. 
I.e. no mixing at all! But when the kernel and userspace uses %gs, it's 
the cost of switching between two selector values of %gs that has to be 
measured. Your code does not measure that at all, AFAICS.

	Ingo
