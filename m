Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbTH2RHJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbTH2RHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:07:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:37543 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261445AbTH2RFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:05:00 -0400
Date: Fri, 29 Aug 2003 09:48:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mario Lang <mlang@delysid.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: JVC MP-XP7210 hangs on boot with 2.6.0-test4
Message-Id: <20030829094851.066ce7c2.akpm@osdl.org>
In-Reply-To: <87k78wsip0.fsf@lexx.delysid.org>
References: <87k78wsip0.fsf@lexx.delysid.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Lang <mlang@delysid.org> wrote:
>
> I just tried 2.6.0-test4 on my Laptop (JVC MP-XP7210, 256MB RAM, IDE).
> However, it hangs on boot.  I tried booting with acpi=off and also
> with "acpi=off noapic".  Both options seem to help nothing,
> and the same output appears on all attempts to boot.
> 
> I compiled the kernel with gcc 3.3.2.
> 
> Here is the output I get:
> 
> [<c0 10 92 69>] Kernel_thread_helper+0x5/0xc
> Code: 0f ba 6e 24 00 c7 44 24 04 00 00 00 00 89 34 24 e8 25 fa ff
> <0> Kernel Panic: Fatal Exception in Interrupt
> in interrupt handler - not syncing

There must have been more output than that?  Please transcribe some more of
the backtrace and send it.  Don't worry about all the hex numbers: the
important parts are these:

 EIP is at i810fb_cursor+0x1da/0x240 [i810fb]

 Call Trace:
 [<...>] apic_timer_interrupt+0x1a/0x20
 [<...>] bh_lru_install+0xb5/0x100
 [<...>] __find_get_block+0x73/0xf0
 [<...>] __getblk+0x2b/0x60
 [<...>] is_tree_node+0x6b/0x70
 [<...>] search_by_key+0x6f9/0xf30
 [<...>] search_for_position_by_key+0x1be/0x3d0
 [<...>] apic_timer_interrupt+0x1a/0x20

Also, try stripping your kernel down by unconfiguring drivers and features
which are not needed for a successful boot.  This will help identify the
buggy component.

Also, try adding the string `initcall_debug' to the kernel boot command
line.  Watch out for the messages "calling initcall 0xNNNNNNNN".  Take a
note of the final address which is printed before the crash and look it up
in the 2.6 kernel's System.map file.

Thanks.
