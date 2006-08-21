Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWHUGsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWHUGsD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 02:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWHUGsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 02:48:03 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:2211 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1030278AbWHUGsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 02:48:02 -0400
Message-Id: <44E97353.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 21 Aug 2006 08:48:19 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
References: <20060820013121.GA18401@fieldses.org>
In-Reply-To: <20060820013121.GA18401@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> "J. Bruce Fields" <bfields@fieldses.org> 20.08.06 03:31 >>>
>As of 2.6.18-rc3, one of my test machines stopped booting.  I'm not
>seeing the whole OOPS (I could probably set up a serial console if
>necessary), but it ends in something like:
>
>trace_hardirqs_on
>idesci_pc_intr
>ide_intr
>handle_IRQ_event
>__do_IRQ
>do_IRQ
>common_interrupt
>default_idle
>apm_cpu_idle
>cpu_idle
>rest_init
>start_kernel
>0xc0100199
>DWARF2 unwinder stuck at 0xc0100199
>Leftover inexact backtrace:
> =======================
> BUG: unable to handle kernel paging request at virtual address 0000b034
> printing eip:
>c0103712
>*pde = 00000000
>Recursive die() failure, output suppressed
> <0>Kernel panic - not syncing: Fatal exception in interrupt
>
>Bisecting, it looks like this starts happening after c97d20a...,
>"[PATCH] i386: Do backtrace fallback too", though it's a little tricky
>since the compile is broken near there for a little while.
>
>Kernel config appended; let me know if anything else would be useful.

The 'stuck' unwinder issue at hand already has a fix, though planned to
be merged for 2.6.19 only. The crash after switching to the legacy
stack trace code is bad, though, but has little to do with the unwinder
additions/changes. The way that code reads the stack is just
inappropriate in contexts where things must be expected to be broken.

Finally, there is no visible correlation between the original problem (in
or from trace_hardirqs_on) and the unwinder - once that problem is
fixed, you're not likely to see the recursive die failure anymore either.

Jan
