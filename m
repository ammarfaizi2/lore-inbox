Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbULWQYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbULWQYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 11:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbULWQYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 11:24:43 -0500
Received: from apachihuilliztli.mtu.ru ([195.34.32.124]:57607 "EHLO
	Apachihuilliztli.mtu.ru") by vger.kernel.org with ESMTP
	id S261265AbULWQYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 11:24:36 -0500
Subject: Re: oops reiserfs / kernel
From: Vladimir Saveliev <vs@namesys.com>
To: Guillaume <g4ndalf@free.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <41CAA68E.30603@free.fr>
References: <41CAA68E.30603@free.fr>
Content-Type: text/plain
Message-Id: <1103819054.8067.142.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 23 Dec 2004 19:24:24 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, 2004-12-23 at 14:05, Guillaume wrote:
> The server has started to refuse all connections after several days of 
> functioning correctly. After a reboot it worked well during 5 hours 
> until it crashed in exactly the same manner and after analyzing the logs 
> I came accross the following message.
> 
> (This machine is a biprocessor AMD MP 2800+, motherboard tyan S2469 but 
> it has ECC RAM Registered (3Go) and SCSI hard drives)
> 
> At the moment the crash occured there was a heavy load on the postfix 
> mail queue
> 
> Dec 22 18:26:33 lanai kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000014
> Dec 22 18:26:33 lanai kernel:  printing eip:
> Dec 22 18:26:33 lanai kernel: c01c34fd
> Dec 22 18:26:33 lanai kernel: *pde = 00000000
> Dec 22 18:26:33 lanai kernel: Oops: 0000 [#1]
> Dec 22 18:26:33 lanai kernel: PREEMPT SMP
> Dec 22 18:26:33 lanai kernel: Modules linked in: 8250 serial_core unix
> Dec 22 18:26:33 lanai kernel: CPU:    1
> Dec 22 18:26:33 lanai kernel: EIP: 
> 0060:[create_virtual_node+1533/2000]    Not tainted
> Dec 22 18:26:33 lanai kernel: EFLAGS: 00010212   (2.6.8.1)
> Dec 22 18:26:33 lanai kernel: EIP is at create_virtual_node+0x5fd/0x7d0
> Dec 22 18:26:33 lanai kernel: eax: 0000f6ba   ebx: c931504c   ecx: 
> d6f95b0c   edx: 00000000
> Dec 22 18:26:33 lanai kernel: esi: c9315000   edi: d6f95b0c   ebp: 
> 00000000   esp: d6f95990
> Dec 22 18:26:33 lanai kernel: ds: 007b   es: 007b   ss: 0068
> Dec 22 18:26:33 lanai kernel: Process cleanup (pid: 1020, 
> threadinfo=d6f94000 task=f33e2370)
> Dec 22 18:26:33 lanai kernel: Stack: c9315000 c931504c 00000000 0000f6ba 
> d6f95a50 c01b4d6c 000000a8 e3eb5b3c
> Dec 22 18:26:33 lanai kernel:        00000007 f02fb018 00000000 d6f95b0c 
> 0001068a f02fb018 c01c54ea d6f95b0c
> Dec 22 18:26:33 lanai kernel:        00000000 00000000 00000000 00000003 
> 00000012 00000000 00000000 00000000
> Dec 22 18:26:33 lanai kernel: Call Trace:
> Dec 22 18:26:33 lanai kernel:  [do_balance+252/400] do_balance+0xfc/0x190
> Dec 22 18:26:33 lanai kernel:  [ip_check_balance+714/3200] 
> ip_check_balance+0x2ca/0xc80
> Dec 22 18:26:33 lanai kernel:  [reiserfs_cut_from_item+867/1840] 
> reiserfs_cut_from_item+0x363/0x730
> Dec 22 18:26:33 lanai kernel:  [fix_nodes+506/1424] fix_nodes+0x1fa/0x590
> Dec 22 18:26:33 lanai kernel:  [reiserfs_insert_item+437/848] 
> reiserfs_insert_item+0x1b5/0x350
> Dec 22 18:26:33 lanai kernel: 
> [reiserfs_allocate_blocks_for_region+3853/5936] 
> reiserfs_allocate_blocks_for_region+0xf0d/0x
> 1730
> Dec 22 18:26:33 lanai kernel: 
> [reiserfs_prepare_file_region_for_write+1552/2816] 
> reiserfs_prepare_file_region_for_write+0x
> 610/0xb00
> Dec 22 18:26:33 lanai kernel:  [reiserfs_file_write+1622/2384] 
> reiserfs_file_write+0x656/0x950
> Dec 22 18:26:33 lanai kernel:  [sock_aio_read+245/272] 
> sock_aio_read+0xf5/0x110
> Dec 22 18:26:33 lanai kernel:  [do_sync_read+132/176] do_sync_read+0x84/0xb0
> Dec 22 18:26:33 lanai kernel:  [do_sigaction+528/976] 
> do_sigaction+0x210/0x3d0
> Dec 22 18:26:33 lanai kernel:  [copy_from_user+66/128] 
> copy_from_user+0x42/0x80
> Dec 22 18:26:33 lanai kernel:  [reiserfs_file_write+0/2384] 
> reiserfs_file_write+0x0/0x950
> Dec 22 18:26:33 lanai kernel:  [vfs_write+184/304] vfs_write+0xb8/0x130
> Dec 22 18:26:33 lanai kernel:  [sys_socketcall+311/608] 
> sys_socketcall+0x137/0x260
> Dec 22 18:26:33 lanai kernel:  [sys_write+81/128] sys_write+0x51/0x80
> Dec 22 18:26:33 lanai kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Dec 22 18:26:33 lanai kernel: Code: ff 52 14 e9 af fc ff ff 83 f9 fe b8 
> 01 00 00 00 74 ca 83 f9
> 
> lanai:~# lsmod
> Module                  Size  Used by
> 8250                   23200  2
> serial_core            23936  1 8250
> unix                   26900  184
> lanai:~# lspci
> 0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP 
> [IGD4-2P] System Controller (rev 20)
> 0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP 
> [IGD4-2P] AGP Bridge
> 0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA 
> (rev 05)
> 0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] 
> IDE (rev 04)
> 0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI 
> (rev 03)
> 0000:00:0a.0 SCSI storage controller: Adaptec AIC-7902 U320 (rev 10)
> 0000:00:0a.1 SCSI storage controller: Adaptec AIC-7902 U320 (rev 10)
> 0000:00:0b.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet 
> Controller (Copper) (rev 01)
> 0000:00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI 
> (rev 05)
> 0000:02:07.0 VGA compatible controller: ATI Technologies Inc Rage XL 
> (rev 27)
> 0000:02:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 
> 100] (rev 10)
> 
> 

Which kernel are you using?

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

