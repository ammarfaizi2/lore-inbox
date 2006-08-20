Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWHTGgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWHTGgI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 02:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWHTGgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 02:36:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47500 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751667AbWHTGgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 02:36:06 -0400
Date: Sat, 19 Aug 2006 23:35:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Message-Id: <20060819233557.671a8ec6.akpm@osdl.org>
In-Reply-To: <20060820013121.GA18401@fieldses.org>
References: <20060820013121.GA18401@fieldses.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006 21:31:21 -0400
"J. Bruce Fields" <bfields@fieldses.org> wrote:

> As of 2.6.18-rc3, one of my test machines stopped booting.  I'm not
> seeing the whole OOPS (I could probably set up a serial console if
> necessary), but it ends in something like:
> 
> trace_hardirqs_on
> idesci_pc_intr
> ide_intr
> handle_IRQ_event
> __do_IRQ
> do_IRQ
> common_interrupt
> default_idle
> apm_cpu_idle
> cpu_idle
> rest_init
> start_kernel
> 0xc0100199
> DWARF2 unwinder stuck at 0xc0100199
> Leftover inexact backtrace:
>  =======================
>  BUG: unable to handle kernel paging request at virtual address 0000b034
>  printing eip:
> c0103712
> *pde = 00000000
> Recursive die() failure, output suppressed
>  <0>Kernel panic - not syncing: Fatal exception in interrupt
> 
> Bisecting, it looks like this starts happening after c97d20a...,
> "[PATCH] i386: Do backtrace fallback too", though it's a little tricky
> since the compile is broken near there for a little while.
> 
> Kernel config appended; let me know if anything else would be useful.

I think there were some unwinder fixes post-2.6.18-rc3.

We need to work out what's causing this oops asap, please.  Testing
2.6.8-r4-git1 (which should be available within the day) would be useful,
please.  If it crashes, it'll be serial console time.  
