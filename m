Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWEaOFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWEaOFQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 10:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWEaOFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 10:05:16 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:52691 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751618AbWEaOFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 10:05:13 -0400
Date: Wed, 31 May 2006 16:05:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531140533.GA11920@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com> <6bffcb0e0605310651u61b9756fpfce3515ab046bf42@mail.gmail.com> <20060531140201.GA11617@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531140201.GA11617@elte.hu>
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

> if it's easy to reproduce it once more, could you apply the patch below? 

please use the updated patch below - it adds more info so that we can 
see whether irqs were really disabled (from the eflags), and we can see 
whether it was userspace or kernelspace.

	Ingo

Index: linux/arch/i386/mm/fault.c
===================================================================
--- linux.orig/arch/i386/mm/fault.c
+++ linux/arch/i386/mm/fault.c
@@ -337,6 +338,8 @@ fastcall void __kprobes do_page_fault(st
 
 	/* get the address */
         address = read_cr2();
+	trace_special(regs->eip, address, error_code);
+	trace_special(regs->eflags, regs->xss, regs->esp);
 
 	tsk = current;
 
