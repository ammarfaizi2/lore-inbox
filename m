Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUFCIrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUFCIrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 04:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUFCIrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 04:47:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:25788 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261907AbUFCIqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 04:46:35 -0400
Date: Thu, 3 Jun 2004 10:47:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040603084746.GA16374@elte.hu>
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

does the .exit.text section have to be taken into account as well? This 
is the normal section order of x86 .ko objects:

  .text
  .init.text
  .exit.text
  .rodata
  .modinfo
  .rodata.str1.1
  .data
  __obsparm
  .gnu.linkonce.this_module
  .comment
  .gnu_debuglink

we load the module up including the .data section? Or do we load the
whole thing?

	Ingo
