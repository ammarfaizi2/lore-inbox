Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWIKFlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWIKFlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWIKFlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:41:44 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:22490 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964857AbWIKFln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:41:43 -0400
Date: Mon, 11 Sep 2006 07:33:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org, Marcelo Tosatti <marcelo@kvack.org>,
       kai@germaschewski.name, sam@ravnborg.org
Subject: Re: [PATCH 2/3] FRV: Permit __do_IRQ() to be dispensed with
Message-ID: <20060911053320.GB11269@elte.hu>
References: <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com> <20060908153240.21015.67367.stgit@warthog.cambridge.redhat.com> <20060909051211.GA6922@elte.hu> <1157898878.3516.2.camel@c-67-169-176-11.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157898878.3516.2.camel@c-67-169-176-11.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> On Sat, 2006-09-09 at 07:12 +0200, Ingo Molnar wrote:
> 
> > The real solution would be to use gcc -ffunction-sections plus ld 
> > --gc-sections to automatically get rid of unused global functions, at 
> > link time. I'm wondering how hard it would be to enhance kbuild to do 
> > that - x86_64 already uses -ffunction-sections (if CONFIG_REORDER), so 
> > the big question is how usable is ld --gc-sections. Such a feature would 
> > be quite important for embedded systems (and for RAM footprint in 
> > general) as it would save a significant amount of .text and .data.
> 
> A patch to do this was submitted already by Marcelo Tosatti ..
> 
> http://lkml.org/lkml/2006/6/4/169

ah, i missed that patch in the June lock validator frenzy. The results 
are astounding:

>> vmlinux shrinks from 1090389 to 983933 bytes, or 106k (~= 10%).

Andrew, Linus, Kai, Sam: a must-have feature! This saves more kernel 
kernel image RAM than all the other kernel shrinking efforts of the past 
2 years combined - at zero cost.

	Ingo
