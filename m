Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWIHTNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWIHTNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWIHTNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:13:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751047AbWIHTNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:13:22 -0400
Date: Fri, 8 Sep 2006 12:13:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brandon Philips <brandon@ifup.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc6-mm1 2.6.18-rc5-mm1 Kernel Panic on X60s
Message-Id: <20060908121319.11a5dbb0.akpm@osdl.org>
In-Reply-To: <20060908174437.GA5926@plankton.ifup.org>
References: <20060908174437.GA5926@plankton.ifup.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006 12:44:37 -0500
Brandon Philips <brandon@ifup.org> wrote:

> Under both 2.6.18-rc6-mm1 and 2.6.18-rc5-mm1 my Thinkpad X60s[1] crashes
> almost immediatly on boot with the following stack trace (typed by
> hand):
> 
> Code: Bad EIP value.
> EIP: [<00000000>] run_init_process+0x3feffc9c/0x19 SS:ESP 0068:c0345f74
>  <0>Kernel panic - not syncing: Fatal exception in interrupt
>  BUG: warning at arch/i386/kernel.smp.c:547/smp_call_function()
>  [<c01107e8>] smp_call_function+0x50/0x101
>  [<c01172c2>] bug_spinlocks+0x3d/0x46
>  [<c01108a9>] smp_send_stop+0x10/0x1b
>  [<c0110a20>] stop_this_cpu+0x0/0x2e
>  [<c011eefe>] panic+0x4d/0xe7
>  [<c0104072>] die+0x26e/0x2a3
>  [<c011772f>] do_page_fault+0x43d/0x50a
>  [<c01172f2>] do_page_fault+0x0/0x50a
>  [<c02a7a8f>] error_code+0x3f/0x44
>  [<c01100d8>] acpi_copy_wakeup_routine+0x78/0x9a
>  [<c01051ae>] do_IRQ+0x53/0x65
>  [<c01036bf>] common_interrupt+0x23/0x28
>  [<f883e714>] acpi_processor_idle+0x1f4/0x3b0 [processor]
>  [<c0101c0e>] cpu_idle+0x9e/0xb7
>  [<c034a711>] start_kernel+0x367/0x36d

Looks like we have an IRQ handler which is screwed up.

> 2.6.18-rc4-mm3 boots ok.
> 
> I will try and bisect the problem later tonight-
>

Thanks.  First, try disabling CONFIG_PCI_MSI.
