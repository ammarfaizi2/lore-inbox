Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbUAIUQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUAIUQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:16:59 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:3755 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S264256AbUAIUQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:16:42 -0500
Message-Id: <6.0.0.22.0.20040109124348.01b86068@pop-server.kc.rr.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.0.22
Date: Fri, 09 Jan 2004 13:14:52 -0700
To: linux-scsi@vger.kernel.org
From: "Larry W. Finger" <Larry.Finger@lwfinger.net>
Subject: Kernel oops in 2.6.1 when loading aha152x_cs.ko
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When loading module aha152x_cs with kernel 2.6.1 and cardmgr 3.2.5, I get a 
kernel oops. This problem has existed at least since 2.5.63, which is when 
I started trying the new version. I am reporting this problem now because 
since 2.6.0-rc1, the driver now works except for this problem. What I 
believe to be the pertinent sections of the output of dmesg are listed below:

===================================================================
Linux version 2.6.1 (root@lwflap) (gcc version 3.3.1) #1 Fri Jan 9 09:56:28 
MST 2004
...snip...
Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
..snip..
Yenta: CardBus bridge found at 0000:00:0a.0 [103c:0022]
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000007
..snip..
cs: IO port probe 0x0100-0x04ff: excluding 0x2c8-0x2cf 0x378-0x37f 
0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: memory probe 0x60000000-0x60ffffff: clean.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c02b5f60
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c02b5f60>]    Not tainted
EFLAGS: 00010282
EIP is at scsi_register+0x40/0x70
eax: c7bf1a10   ebx: c7bf17f8   ecx: 00000000   edx: cf986cf4
esi: cf986c80   edi: c8a2fa24   ebp: c8a2f7b0   esp: c8a2f7a0
ds: 007b   es: 007b   ss: 0068
Process cardmgr (pid: 1088, threadinfo=c8a2e000 task=ca31d960)
Stack: cf986c80 00000350 00000000 c8a2f9fc c8a2f7fc cf97ca30 cf986c80 00000350
        c73ab180 c8a2f7fc 00000282 cefef080 c73abe90 0000006b c8a2f7fc 
073abe90
        cf97c42e c73abe90 cefe5ef8 00000282 00000000 c8a2f9fc c8a2fa24 
c8a2fa38
Call Trace:
  [<cf97ca30>] aha152x_probe_one+0x20/0x460 [aha152x_cs]
  [<cf97c42e>] aha152x_config_cs+0x25e/0x360 [aha152x_cs]
  [<cf97c48c>] aha152x_config_cs+0x2bc/0x360 [aha152x_cs]
  [<c0120150>] scheduler_tick+0x2d0/0x5b0
  [<c0119e3d>] mark_offset_tsc+0x3ad/0x560
  [<c0132596>] update_process_times+0x46/0x50
  [<c013240d>] update_wall_time+0xd/0x40
  [<c01328c3>] run_timer_softirq+0x303/0x430
  [<c010c75e>] apic_timer_interrupt+0x1a/0x20
  [<c02e5652>] yenta_set_mem_map+0x1f2/0x250
  [<c02e4ba3>] exca_writew+0x63/0x80
  [<c02e5652>] yenta_set_mem_map+0x1f2/0x250
  [<c02e4ba3>] exca_writew+0x63/0x80
  [<c02e0052>] socket_detect_change+0x32/0x80
  [<c01531e9>] check_poison_obj+0x29/0x1a0
  [<c02da67e>] set_cis_map+0x3e/0x110
  [<c01531e9>] check_poison_obj+0x29/0x1a0
  [<c0267a1b>] unblank_screen+0xfb/0x100
  [<cf97c62d>] aha152x_event+0x6d/0x140 [aha152x_cs]
  [<c021bd04>] __delay+0x14/0x20
  [<c02b11c7>] __ide_dma_begin+0x37/0x50
  [<c02b1375>] __ide_dma_count+0x15/0x20
  [<c02b10b5>] __ide_dma_read+0xc5/0xd0
  [<c02b0810>] ide_dma_intr+0x0/0xb0
  [<c02b0d30>] dma_timer_expiry+0x0/0x80
  [<c02a038b>] do_rw_taskfile+0x1bb/0x2b0
  [<c011f498>] kernel_map_pages+0x28/0x90
  [<c02db0b2>] pcmcia_get_first_tuple+0x92/0x130
  [<c02dc9c8>] read_tuple+0x98/0xb0
  [<c01531e9>] check_poison_obj+0x29/0x1a0
  [<c02e1876>] pcmcia_register_client+0x1c6/0x2b0
  [<c01559cc>] __kmalloc+0x19c/0x250
  [<c02e1904>] pcmcia_register_client+0x254/0x2b0
  [<cf97c020>] aha152x_attach+0x20/0x140 [aha152x_cs]
  [<c011f498>] kernel_map_pages+0x28/0x90
  [<c02e2d5a>] CardServices+0x19a/0x346
  [<c0155780>] kmem_cache_alloc+0x170/0x220
  [<cf97c0f4>] aha152x_attach+0xf4/0x140 [aha152x_cs]
  [<cf97c5c0>] aha152x_event+0x0/0x140 [aha152x_cs]
  [<c0155780>] kmem_cache_alloc+0x170/0x220
  [<c02e3ac4>] bind_request+0x114/0x240
  [<c02df6e4>] pcmcia_get_socket_by_nr+0x24/0xb0
  [<c02e46a9>] ds_ioctl+0x539/0x680
  [<c014f442>] buffered_rmqueue+0xd2/0x270
  [<c014f8fe>] __alloc_pages+0x31e/0x380
  [<c011f498>] kernel_map_pages+0x28/0x90
  [<c01268a6>] __mmdrop+0x36/0x45
  [<c01268a6>] __mmdrop+0x36/0x45
  [<c011f498>] kernel_map_pages+0x28/0x90
  [<c015df3e>] zap_pmd_range+0x4e/0x70
  [<c015dfa1>] unmap_page_range+0x41/0x70
  [<c015e0c0>] unmap_vmas+0xf0/0x330
  [<c01634af>] unmap_vma_list+0x1f/0x30
  [<c01634af>] unmap_vma_list+0x1f/0x30
  [<c0163ad0>] do_munmap+0x1d0/0x290
  [<c018ee15>] sys_ioctl+0x205/0x3f0
  [<c010bdcf>] syscall_call+0x7/0xb

Code: 89 01 89 48 04 89 d8 8b 75 fc 8b 5d f8 c9 c3 8b 46 04 c7 04

===================================================================

My kernel debugging skills are minimal; however, I tracked this error to 
drivers/scsi/hosts.c where a call is made to list_add_tail with the 
sht->legacy_hosts list_head == NULL. The problem is fixed by the patch that 
follows. I am aware that this patch fixes the symptom rather than the cause 
and this driver should never hit this code. However, the current version 
uses scsi_register rather than scsi_host_alloc and has a problem. In 
defense of the patch, (1) the driver works with it installed, and (2) the 
modified code is only invoked when this particular case occurs.

===================================================================

--- a/drivers/scsi/hosts.c.orig	2004-01-08 09:13:39.374648400 -0700
+++ linux-2.6.1/drivers/scsi/hosts.c	2004-01-08 09:13:45.958647480 -0700
@@ -300,8 +300,13 @@
  		dump_stack();
  	}

-	if (shost)
+	if (shost) {
+		if (sht->legacy_hosts.next == NULL) {
+			printk(KERN_INFO "sht->legacy_hosts list_head is NULL!\n");
+			INIT_LIST_HEAD(&sht->legacy_hosts);
+		}
  		list_add_tail(&shost->sht_legacy_list, &sht->legacy_hosts);
+	}
  	return shost;
  }

===================================================================

Larry Finger

