Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVERBLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVERBLS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 21:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVERBLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 21:11:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:2534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262045AbVERBJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 21:09:37 -0400
Date: Tue, 17 May 2005 18:08:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: dedekind@infradead.org
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-scsi@vger.kernel.org
Subject: Re: [OOPS] 2.6.12-rc4 oops
Message-Id: <20050517180847.6fb0e204.akpm@osdl.org>
In-Reply-To: <1116345116.8079.12.camel@sauron.oktetlabs.ru>
References: <1116345116.8079.12.camel@sauron.oktetlabs.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Artem B. Bityuckiy" <dedekind@infradead.org> wrote:
>
> When I copied a lot of data (>10GB) from ext3 partition to reiserfs
>  partition and compiled linux on the ext3 partition at the same time i
>  got the following oops:
> 
>  ata1: command 0x25 timeout, stat 0xd0 host_stat 0x21
>  ata1: status=0xd0 { Busy }
>  end_request: I/O error, dev sda, sector 49947775
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  ATA: abnormal status 0xD0 on port 0xEFE7
> ...
>  ata1: command 0x25 timeout, stat 0xd0 host_stat 0x21
>  ata1: status=0xd0 { Busy }
>  end_request: I/O error, dev sda, sector 53178303
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  ata1: command 0x25 timeout, stat 0xd0 host_stat 0x21
>  ata1: status=0xd0 { Busy }
>  end_request: I/O error, dev sda, sector 2621519
>  EXT3-fs error (device sda1): ext3_get_inode_loc: unable to read inode
>  block - inode=161624, block=327682
>  Aborting journal on device sda1.
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  ata1: command 0x25 timeout, stat 0xd0 host_stat 0x21
>  ata1: status=0xd0 { Busy }
>  end_request: I/O error, dev sda, sector 2621535
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  EXT3-fs error (device sda1): ext3_get_inode_loc: unable to read inode
>  block - inode=161685, block=327684
>  ata1: command 0x25 timeout, stat 0xd0 host_stat 0x21
>  ata1: status=0xd0 { Busy }
>  end_request: I/O error, dev sda, sector 2967775
>  EXT3-fs error (device sda1): ext3_find_entry: reading directory #181451
>  offset 0
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  ATA: abnormal status 0xD0 on port 0xEFE7
>  Unable to handle kernel paging request at virtual address d3562eac
>   printing eip:
>  e0853769
>  *pde = 00000000
>  Oops: 0002 [#1]
>  PREEMPT SMP DEBUG_PAGEALLOC
>  Modules linked in: reiserfs nfsd exportfs md5 ipv6 autofs4 nfs lockd
>  sunrpc sk98lin microcode uhci_hcd ehci_hcd video button battery ac sd
>  _mod sr_mod ext3 jbd dm_mod ata_piix libata scsi_mod
>  CPU:    0
>  EIP:    0060:[<e0853769>]    Not tainted VLI
>  EFLAGS: 00010002   (2.6.12-rc4-smp-preempt)
>  EIP is at scsi_eh_scmd_add+0x59/0x90 [scsi_mod]
>  eax: dfc1205c   ebx: 00000001   ecx: d3562eac   edx: d3e61eac
>  esi: d3e61e94   edi: dfc12000   ebp: c03d1efc   esp: c03d1eec
>  ds: 007b   es: 007b   ss: 0068
>  Process swapper (pid: 0, threadinfo=c03d0000 task=c036cc40)
>  Stack: 00000286 d3e61e94 00000101 c1405ee0 c03d1f1c e08538ec c1405e80
>  c03d1f18
>         c03d1f1c 00000286 c03d1f1c d3e61e94 c03d1f58 c012add6 c03d1f2c
>  c031d0a2
>         c03d1f38 c036cc40 c03d1f40 c03d0000 e08538a0 c03d1f40 c03d1f40
>  000f4354
>  Call Trace:
>   [<c010412a>] show_stack+0x7a/0x90
>   [<c01042b6>] show_registers+0x156/0x1c0
>   [<c01044d0>] die+0x100/0x180
>   [<c0119026>] do_page_fault+0x356/0x6dd
>   [<c0103d7b>] error_code+0x4f/0x54
>   [<e08538ec>] scsi_times_out+0x4c/0xc0 [scsi_mod]
>   [<c012add6>] run_timer_softirq+0xe6/0x1b0
>   [<c0126c3b>] __do_softirq+0xdb/0x100
>   [<c0126cad>] do_softirq+0x4d/0x50
>   [<c0126dae>] irq_exit+0x4e/0x50
>   [<c0103cd4>] apic_timer_interrupt+0x1c/0x24
>   [<c0101121>] cpu_idle+0x71/0x90
>   [<c03d29bc>] start_kernel+0x18c/0x1d0
>   [<c010020e>] 0xc010020e
>  Code: 89 f6 8b 47 3c e8 78 95 ac df 09 5e 24 8d 56 18 89 45 f0 8d 47 5c
>  66 c7 46 0a 03 01 66 c7 46 08 02 10 8b 48 04 89 46 18 89 50 04 <89
>  > 11 89 4a 04 f0 0f ba af 0c 01 00 00 03 ff 87 98 00 00 00 89
>   <0>Kernel panic - not syncing: Fatal exception in interrupt

Please describe the I/O setup.  Serial ATA?  Which driver, what type of
hardware?

