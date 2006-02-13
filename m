Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWBMKHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWBMKHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWBMKHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:07:45 -0500
Received: from ns.suse.de ([195.135.220.2]:14750 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751225AbWBMKHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:07:44 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: Linux 2.6.16-rc3 - x86_64 specific outstanding bugs.
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	<20060212190520.244fcaec.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 13 Feb 2006 11:07:40 +0100
In-Reply-To: <20060212190520.244fcaec.akpm@osdl.org>
Message-ID: <p73irrj4ln7.fsf_-_@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

[Note to people who find this using google in some archive.
This list is for an old kernel and totally obsolete. Don't email me
about asking about it. Use a newer kernel.]

> We still have some serious bugs, several of which are in 2.6.15 as well:

>From the x86-64 side for 2.6.16:

- Still oopses with mbind in some setups that I need to fix.
Problem at least understood now. Should be fixed. Related to
GFP_DMA32

- mbind can currently cause a local dos by starting the OOM killer
early. Christoph Lameter has patches that should be added.

- Doesn't boot on Opterons with nodes in the middle unpopulated.
I can reproduce on SimNow, but still need to fix (unfortunately
it completely changes when I add any debugging code) 

- kg_crashme causes do_exit be called with interrupts disabled.
Need to fix that.

- logical cpu hot replug on multiprocessor opterons hangs the machine.
Prime suspect is the powernow-k8 driver.

- Nested kprobes are broken and cause a stack overflow on the int3 
stack.  Impossible to fix fully, but should support nesting for 
a few levels at least. The systemtap testsuite triggers this apparently.

- The ATI timer fix using the local APIC timer breaks on many AMD
laptops who don't run the APIC timer in C2.  Latest plan is to switch
to the RTC interrupt on these machines, but still needs to be implemented.

Also some other not well researched timer issue on the usual suspects
(mainly nforce3 laptops which seem to have all kind of broken timing),
but some of that might be related to the completely different timer
code in -mm* which seems to miss all the latest fixes.

-Andi

