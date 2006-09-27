Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031185AbWI0Wuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031185AbWI0Wuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031186AbWI0Wuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:50:39 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61070
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1031180AbWI0Wuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:50:37 -0400
Date: Wed, 27 Sep 2006 15:50:35 -0700 (PDT)
Message-Id: <20060927.155035.74747595.davem@davemloft.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: ebiederm@xmission.com, ak@suse.de, benh@kernel.crashing.org,
       greg@kroah.com, mingo@elte.hu, tglx@linutronix.de, tony.luck@intel.com
Subject: Re: +
 msi-refactor-and-move-the-msi-irq_chip-into-the-arch-code.patch added to
 -mm tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <200609272215.k8RMFbuH018967@shell0.pdx.osdl.net>
References: <200609272215.k8RMFbuH018967@shell0.pdx.osdl.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: akpm@osdl.org
Date: Wed, 27 Sep 2006 15:15:37 -0700

> Subject: msi: refactor and move the msi irq_chip into the arch code
> From: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> It turns out msi_ops was simply not enough to abstract the architecture
> specific details of msi.  So I have moved the resposibility of constructing
> the struct irq_chip to the architectures, and have two architecture specific
> functions arch_setup_msi_irq, and arch_teardown_msi_irq.
> 
> For simple architectures those functions can do all of the work.  For
> architectures with platform dependencies they can call into the appropriate
> platform code.
> 
> With this msi.c is finally free of assuming you have an apic, and this
> actually takes less code.
> 
> The helpers for the architecture specific code are declared in the linux/msi.h
> to keep them separate from the msi functions used by drivers in linux/pci.h
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Andi Kleen <ak@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg KH <greg@kroah.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Eric, thanks so much for doing this work.

Once this goes in I'll try to add support for MSI on sparc64
Niagara boxes.  I suppose the PowerPC folks can make use of
this as well.

