Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVJFQ0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVJFQ0W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVJFQ0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:26:22 -0400
Received: from fmr21.intel.com ([143.183.121.13]:10388 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751129AbVJFQ0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:26:21 -0400
Date: Thu, 6 Oct 2005 09:25:28 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051006162528.GA6006@agluck-lia64.sc.intel.com>
References: <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com> <20051006084920.GB22397@elte.hu> <Pine.LNX.4.58.0510060544390.28535@localhost.localdomain> <200510061204.33045.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510061204.33045.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's a theoretical only issue for mainline right now. The only architectures 
> using the ACPI code are i386,x86-64,ia64. The first two are ok with 
> truncating. The IA64 PSR is longer than 32bit, but unless I'm misreading the 
> code they only care about the "i" bit which is also in the lower 32bit (Tony 
> can probably confirm/deny) 

Andi is right ... if you follow the "acpi_os_release_lock" trail, you
eventually get to include/asm-ia64/system.h with the following definition
for __local_irq_restore:

#define __local_irq_restore(x)  ia64_intrin_local_irq_restore((x) & IA64_PSR_I)

and the IA64_PSR_I bit is bit 14 ... safely in the low 32 bits.  So this is
a correct fix, but will have no effect on ia64.

-Tony
