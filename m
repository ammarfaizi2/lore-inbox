Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbVL2H7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbVL2H7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 02:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbVL2H7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 02:59:53 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:3780 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932586AbVL2H7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 02:59:53 -0500
Date: Thu, 29 Dec 2005 08:59:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229075936.GC20177@elte.hu>
References: <20051228114637.GA3003@elte.hu> <20051229043835.GC4872@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229043835.GC4872@stusta.de>
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

> > unit-at-a-time still increases the kernel stack footprint somewhat (by 
> > about 5% in the CC_OPTIMIZE_FOR_SIZE case), but not by the insane degree 
> > gcc3 used to, which prompted the original -fno-unit-at-a-time addition.
> >...
> 
> Please hold off this patch.
> 
> I do already plan to look at this after the smoke has cleared after 
> the 4k stacks issue. I want to avoid two different knobs both with 
> negative effects on stack usage (currently CONFIG_4KSTACKS=y, and 
> after your patch gcc >= 4.0) giving a low testing coverage of the 
> worst cases.

this is obviously not 2.6.15 stuff, so we've got enough time to see the 
effects. [ And what does "I do plan to look at this" mean? When 
precisely, and can i thus go to other topics without the issue being 
dropped on the floor indefinitely? ]

also note that the inlining patch actually _reduces_ average stack 
footprint by ~3-4%:
                                            orig        +inlining
        # of functions above 256 bytes:      683              660
               total stackspace, bytes:   148492           142884

it is the unit-at-a-time patch that increases stack footprint (by about 
7-8%, which together with the inlining patch gives a net ~5%).

	Ingo
