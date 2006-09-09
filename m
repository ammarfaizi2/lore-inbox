Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWIIFUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWIIFUd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 01:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWIIFUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 01:20:33 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12009 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932141AbWIIFUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 01:20:32 -0400
Date: Sat, 9 Sep 2006 07:12:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 2/3] FRV: Permit __do_IRQ() to be dispensed with
Message-ID: <20060909051211.GA6922@elte.hu>
References: <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com> <20060908153240.21015.67367.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908153240.21015.67367.stgit@warthog.cambridge.redhat.com>
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


* David Howells <dhowells@redhat.com> wrote:

> +#ifndef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ

> +#ifdef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ

> +#ifndef CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ

I think the myriad of arch switches and the resulting #ifdef noise, just 
to get rid of a _single_ unused global function, is pretty lame. (and 
that's of course not your fault)

The real solution would be to use gcc -ffunction-sections plus ld 
--gc-sections to automatically get rid of unused global functions, at 
link time. I'm wondering how hard it would be to enhance kbuild to do 
that - x86_64 already uses -ffunction-sections (if CONFIG_REORDER), so 
the big question is how usable is ld --gc-sections. Such a feature would 
be quite important for embedded systems (and for RAM footprint in 
general) as it would save a significant amount of .text and .data.

	Ingo
