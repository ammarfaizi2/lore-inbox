Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUFCIwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUFCIwe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 04:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUFCIwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 04:52:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1470 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261914AbUFCIwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 04:52:21 -0400
Date: Thu, 3 Jun 2004 10:53:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040603085328.GB16374@elte.hu>
References: <20040602205025.GA21555@elte.hu> <1086221461.29390.327.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086221461.29390.327.camel@bach>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> You want to replace the arch-specific module_alloc() function for
> this. Or even better, reset the NX bit only on executable sections (in
> the arch-specific module_finalize(), using mod->core_text_size and
> mod->init_text_size).  No generic changes necessary.

this reminds me of another issue: x86_64 currently seems to manually map
the whole module via PAGE_KERNEL_EXEC. Andi, we could change it to use
vmalloc_exec(), right?

and yet another sub-topic: when building modules we should align .rodata
(the first non-executable section) to page boundary. This adds ~2K to
the module size but it's not an issue i think. Data section overflows do
happen and if it has a function pointer that can be used as a trampoline
then we want the whole data section to be non-executable.

	Ingo
