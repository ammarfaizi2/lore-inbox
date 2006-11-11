Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754854AbWKKSBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854AbWKKSBG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 13:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754857AbWKKSBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 13:01:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:726 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754854AbWKKSBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 13:01:05 -0500
Date: Sat, 11 Nov 2006 10:00:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>
Cc: "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
Message-Id: <20061111100038.6277efd4.akpm@osdl.org>
In-Reply-To: <200611111129.kABBTWgp014081@fire-2.osdl.org>
References: <200611111129.kABBTWgp014081@fire-2.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006 03:29:32 -0800
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=7495
> 
>            Summary: Kernel periodically hangs.
>     Kernel Version: Linux version 2.6.18.2 (root@pub) (gcc version 3.4.6)
>                     #13 SMP Fr
>             Status: NEW
>           Severity: blocking
>              Owner: other_other@kernel-bugs.osdl.org
>          Submitter: alex@hausnet.ru
> 
> 
> [42587.676000] BUG: unable to handle kernel NULL pointer dereference at 
> virtual address 0000003c
> [42587.680000]  printing eip:
> [42587.680000] 781610e7
> [42587.680000] *pde = 00000000
> [42587.680000] Oops: 0000 [#1]
> [42587.684000] SMP
> [42587.684000] Modules linked in: sata_promise sk98lin 8250_pnp 8250 
> i2c_nforce2 ehci_hcd serial_core sata_nv ahci i2c_core ohci_hcd forcedeth 
> libata
> [42587.688000] CPU:    1
> [42587.688000] EIP:    0060:[<781610e7>]    Not tainted VLI
> [42587.688000] EFLAGS: 00010286   (2.6.18.2 #13)
> [42587.692000] EIP is at clear_inode+0x96/0xce
> [42587.692000] eax: 00000000   ebx: c0102240   ecx: f7f278d4   edx: f510d400
> [42587.692000] esi: c0102384   edi: f7e6dec0   ebp: 00000070   esp: f7e6de98
> [42587.696000] ds: 007b   es: 007b   ss: 0068
> [42587.696000] Process kswapd0 (pid: 230, ti=f7e6c000 task=f7c03560 
> task.ti=f7e6c000)
> [42587.696000] Stack: c0102248 c0102240 7816116a da7b4af0 da7b4af8 00000000 
> 00000080 781614a2
> [42587.700000]        00000080 00000080 c01023f8 ef78dca8 00000000 00009858 
> 00000083 f7fee560
> [42587.700000]        781614c8 7813a643 00261600 00000000 00009858 00000005 
> 00000000 00000000
> [42587.700000] Call Trace:
> [42587.704000]  [<7816116a>] dispose_list+0x4b/0xc1
> [42587.708000]  [<781614a2>] prune_icache+0x17c/0x18e
> [42587.708000]  [<781614c8>] shrink_icache_memory+0x14/0x2b
> [42587.708000]  [<7813a643>] shrink_slab+0x130/0x18c
> [42587.712000]  [<7813b75a>] balance_pgdat+0x1ea/0x2dd
> [42587.712000]  [<7813b933>] kswapd+0xe6/0xe8
> [42587.716000]  [<781261dc>] kthread+0x7d/0xa1
> [42587.716000]  [<78100e05>] kernel_thread_helper+0x5/0xb

I've seen three or four reports of oopses like this in 2.6.18.  I have a
suspision we broke something.


> Kernel started with noapic option, cause it hands on load without this option.

Him and a million other people.  I know we broke APIC.  Around 2.6.9, I
think.

