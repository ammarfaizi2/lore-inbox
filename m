Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWE3XcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWE3XcR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWE3XcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:32:17 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:31266 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S964824AbWE3XcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:32:16 -0400
X-IronPort-AV: i="4.05,191,1146466800"; 
   d="scan'208"; a="1815782242:sNHT31487116"
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.17-rc5-mm1
X-Message-Flag: Warning: May contain useful information
References: <20060530022925.8a67b613.akpm@osdl.org>
	<adawtc34364.fsf@cisco.com> <20060530154521.d737cc65.akpm@osdl.org>
	<20060530224955.GA5500@elte.hu> <20060530225254.GA5681@elte.hu>
	<20060530225808.GA5836@elte.hu>
	<1149030330.20582.45.camel@localhost.localdomain>
	<20060530231446.GA6504@elte.hu>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 30 May 2006 16:32:13 -0700
In-Reply-To: <20060530231446.GA6504@elte.hu> (Ingo Molnar's message of "Wed, 31 May 2006 01:14:46 +0200")
Message-ID: <adaslmr3x8i.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 May 2006 23:32:15.0695 (UTC) FILETIME=[48DEF5F0:01C68441]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > then i guess a quick solution would be to do:
 > 
 > 	if (!irq_desc[irq].irq_handler)
 > 		__do_IRQ(irq, regs);
 > 	else
 > 		generic_handle_irq(irq, regs);
 > 
 > in arch/x86_64/kernel/irq.c [and in arch/i386/kernel/irq.c], and 
 > __do_IRQ() should handle the old-style irq-type MSI code just fine.

Indeed (fixing ".irq_handler" to be ".handle_irq"), with that change
MSI-X works fine with ib_mthca on my system.  The only slightly funny
quirk is that the IRQ type is shown as "PCI-MSI-X-<NULL>", I guess
because it's printing handle_irq_name(NULL).

However (as BenH pointed out) there's definitely some work to do to
untangle MSI...

 - R.
