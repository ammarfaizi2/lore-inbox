Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTKHRQL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 12:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTKHRQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 12:16:11 -0500
Received: from mid-1.inet.it ([213.92.5.18]:54737 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S261868AbTKHRQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 12:16:04 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: test9 and bluetooth
Date: Sat, 8 Nov 2003 18:15:43 +0100
User-Agent: KMail/1.5.4
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200311021853.47300.cova@ferrara.linux.it> <200311062240.38099.cova@ferrara.linux.it> <20031106231545.GN3345@conectiva.com.br>
In-Reply-To: <20031106231545.GN3345@conectiva.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200311081815.43327.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 00:15, venerdì 07 novembre 2003, Arnaldo Carvalho de Melo ha scritto:
> > I've wrote down the message (by hand, so errors are possible) , hoping
> > that this can help. If it's possible to get the full message, please let
> > me know, a part of it has scrolled out of the screen (i can use a serial
> > port terminal, if needed).
>
> That would be good indeed.

I've captured the kernel messages via serial console; I get them whenever I 
unplug USB bluetooth dongle. The system is a:
2.6.0-test9 #9 SMP, P4 HT

Unable to handle kernel paging request at virtual address 80000234
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<f897c3ed>]    Tainted: P
EFLAGS: 00010046
EIP is at uhci_remove_pending_qhs+0x95/0xfa [uhci_hcd]
eax: 80000234   ebx: 00000093   ecx: 80000200   edx: f488a4fc
esi: f7c25e0c   edi: c03fe000   ebp: f7c25e18   esp: c03fff00
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03fe000 task=c03818e0)
Stack: 00000286 f7c25e0c f7c25c00 00000000 f7c25c00 0000c000 c03fff9c f897c4b9 
       f7c25c00 c03818e0 c18d2c80 f7c25c00 00000001 00000000 c03fff9c c02b87b2
       f7c25c00 c03fff9c f7c55620 04000001 c010b627 00000013 f7c25c00 c03fff9c 
Call Trace:
 [<f897c4b9>] uhci_irq+0x67/0x1ca [uhci_hcd]
 [<c02b87b2>] usb_hcd_irq+0x36/0x5f
 [<c010b627>] handle_IRQ_event+0x3a/0x64
 [<c010b9e8>] do_IRQ+0xb8/0x196
 [<c0105000>] rest_init+0x0/0x64
 [<c0109d30>] common_interrupt+0x18/0x20
 [<c0106ebe>] default_idle+0x0/0x2c
 [<c0105000>] rest_init+0x0/0x64
 [<c0106ee7>] default_idle+0x29/0x2c
 [<c0106f4b>] cpu_idle+0x2e/0x3c
 [<c040088e>] start_kernel+0x179/0x197
 [<c0400449>] unknown_bootoption+0x0/0x10d

Code: 89 69 34 89 45 04 89 02 89 50 04 8b 54 24 08 c6 82 14 02 00
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

I've got a kernel oops at shutdown also, here is the trace of one of them, the 
process is often different, anyway..:

Unable to handle kernel paging request at virtual address 2cc44002
 printing eip:
c018e380
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c018e380>]    Tainted: P
EFLAGS: 00010246
EIP is at proc_match+0x10/0x42
eax: 00000000   ebx: f7511ab0   ecx: 0000000c   edx: 2cc44000
esi: 0000000c   edi: 2cc44000   ebp: f5154000   esp: f5155e94
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 28665, threadinfo=f5154000 task=ec227310)
Stack: 0000000c 2cc44000 c018f249 0000000c f7df40b0 2cc44000 f7df4000 f7df40b0
       0000000c f6ef4c00 f7df4000 f897ca5d f7df40b0 f7511a80 f6c6c000 36c6c000
       f6ef4c00 f7df4054 c02b519f f6ef4c00 f897d5cc f7df40b0 00000001 00000000
Call Trace:
 [<c018f249>] remove_proc_entry+0x55/0x144
 [<f897ca5d>] release_uhci+0xdf/0x121 [uhci_hcd]
 [<c02b519f>] usb_hcd_pci_remove+0xbc/0x1a0
 [<c0213851>] pci_device_remove+0x35/0x37
 [<c0257117>] device_release_driver+0x64/0x66
 [<c0257139>] driver_detach+0x20/0x2e
 [<c0257371>] bus_remove_driver+0x3e/0x77
 [<c0257711>] driver_unregister+0x10/0x24
 [<c0213a05>] pci_unregister_driver+0x13/0x20
 [<f897d4d6>] uhci_hcd_cleanup+0xf/0x76 [uhci_hcd]
 [<c0137d76>] sys_delete_module+0x13a/0x15d
 [<c014e000>] do_munmap+0xa8/0x1ed
 [<c014e18a>] sys_munmap+0x45/0x66
 [<c01093c3>] syscall_call+0x7/0xb

Code: 0f b7 4a 02 3b 4c 24 0c 74 0b 8b 34 24 8b 7c 24 04 83 c4 08





-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

