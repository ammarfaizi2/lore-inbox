Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVF3HLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVF3HLn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 03:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbVF3HLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 03:11:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10661 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262883AbVF3HLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 03:11:38 -0400
Date: Thu, 30 Jun 2005 09:11:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: eliad lubovsky <eliadl@013.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Handle kernel page faults using task gate
Message-ID: <20050630071101.GB26239@elte.hu>
References: <1119997135.4074.106.camel@localhost.localdomain> <20050629130901.GA29776@elte.hu> <20050629192740.GA5940@elte.hu> <1120114635.3422.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120114635.3422.2.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* eliad lubovsky <eliadl@013.net> wrote:

> How do I clear the 'busy' bit?
> I set my TSS descriptor with
> __set_tss_desc(cpu, GDT_ENTRY_PAGE_FAULT_TSS, &pagefault_tss);

i suspect you have to clear the busy bit in the pagefault handler 
itself. The CPU marks it as busy upon fault. I guess it would be OK to 
just do the above __set_tss_desc() for _every_ pagefault, that too will 
clear the busy bit, but you are probably better off just clearing that 
bit manually:

    cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;

	Ingo
