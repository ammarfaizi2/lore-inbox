Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTKKQgC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 11:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTKKQgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 11:36:02 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:23529 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263647AbTKKQfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 11:35:53 -0500
From: "Csaba Halasz" <Jester01@freemail.hu>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: ide-scsi panic with faulty disk and DMA enabled (2.6.0-test9)
Date: Tue, 11 Nov 2003 17:32:18 +0100
Message-ID: <9B4E9DA25A3DD41189B000508B5C0CEE2142B1@BOMBA>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay, this is the ide-scsi version of the panic.
(see http://www.ussg.iu.edu/hypermail/linux/kernel/0311.1/0313.html)

This is with preemption disabled. (I hope. I have compiled a zillion
test kernels yesterday...)

Not sure whether DMA has anything to do with this one, since
it gets disabled early on. I will do a PIO mode test ASAP.

GDB output at the end :)

Greets,
	Csaba

hdd: DMA timeout error
hdd: dma timeout error: status=0xd0 { Busy }
hdd: DMA disabled
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 1a de 7e 00 00 20 00 
Info fld=0x1ade70, Current sr0: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr0, sector 7043576
Buffer I/O error on device sr0, logical block 880447
ide-scsi: abort called for 5922
ide-scsi: abort called for 5923
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 1a de 5e 00 00 20 00 
Info fld=0x1ade60, Current sr0: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr0, sector 7043456
Buffer I/O error on device sr0, logical block 880432
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 1a de 62 00 00 1c 00 
Info fld=0x1ade60, Current sr0: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr0, sector 7043464
Buffer I/O error on device sr0, logical block 880433
ide-scsi: abort called for 5928
ide-scsi: abort called for 5929
ide-scsi: abort called for 5931
Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
in_atomic():0, irqs_disabled():1
Call Trace:
 [<c0120091>] __might_sleep+0x91/0xc0
 [<c0240378>] scsi_sleep+0xf8/0x120
 [<c0240260>] scsi_sleep_done+0x0/0x20
 [<c024830f>] idescsi_abort+0x26f/0x300
 [<c023f6fb>] scsi_try_to_abort_cmd+0xcb/0x1e0
 [<c011df32>] __wake_up_locked+0x22/0x30
 [<c023f920>] scsi_eh_abort_cmds+0x40/0x80
 [<c0240811>] scsi_unjam_host+0x121/0x1c0
 [<c011dd40>] default_wake_function+0x0/0x30
 [<c02409b8>] scsi_error_handler+0x108/0x140
 [<c02408b0>] scsi_error_handler+0x0/0x140
 [<c01072a9>] kernel_thread_helper+0x5/0xc

hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
ide-scsi: reset called for 5928
hdc: ATAPI reset complete
end_request: I/O error, dev sr0, sector 7043584
Buffer I/O error on device sr0, logical block 880448	<- lot of these
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 1a de 9e 00 00 20 00 
Info fld=0x1ade90, Current sr0: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr0, sector 7043704
Buffer I/O error on device sr0, logical block 880463 <- lot of these
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
ide-scsi: abort called for 5935
ide-scsi: abort called for 5936
Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
in_atomic():0, irqs_disabled():1
Call Trace:
 [<c0120091>] __might_sleep+0x91/0xc0
 [<c0240378>] scsi_sleep+0xf8/0x120
 [<c0240260>] scsi_sleep_done+0x0/0x20
 [<c024830f>] idescsi_abort+0x26f/0x300
 [<c023f6fb>] scsi_try_to_abort_cmd+0xcb/0x1e0
 [<c011df32>] __wake_up_locked+0x22/0x30
 [<c023f920>] scsi_eh_abort_cmds+0x40/0x80
 [<c0240811>] scsi_unjam_host+0x121/0x1c0
 [<c011dd40>] default_wake_function+0x0/0x30
 [<c02409b8>] scsi_error_handler+0x108/0x140
 [<c02408b0>] scsi_error_handler+0x0/0x140
 [<c01072a9>] kernel_thread_helper+0x5/0xc

hdd: ATAPI reset complete
drivers/scsi/ide-scsi.c:362: spin_lock(drivers/scsi/hosts.c:df4b6c2c) already locked by drivers/scsi/scsi_error.c/700
drivers/scsi/scsi_error.c:702: spin_unlock(drivers/scsi/hosts.c:df4b6c2c) not locked
ide-scsi: reset called for 5935
------------[ cut here ]------------
kernel BUG at drivers/scsi/ide-scsi.c:493!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c024723b>]    Not tainted
EFLAGS: 00010282
EIP is at idescsi_transfer_pc+0x9b/0x120
eax: c02274e0   ebx: c03accac   ecx: 00000000   edx: 00000172
esi: c29b278c   edi: df4b6e18   ebp: df48fcf8   esp: df48fcd4
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_0 (pid: 10, threadinfo=df48e000 task=df4b2960)
Stack: 00000172 c03accac 00000008 00000080 00001388 df4b6e18 c03accac 00000000 
       c2ed1f38 df48fd24 c0222ade c03accac c29b278c 00000000 00000088 00001388 
       df48fd40 c2ed1f38 c03accac c03aca38 df48fd60 c0222e25 c03accac c2ed1f38 
Call Trace:
 [<c0222ade>] start_request+0x15e/0x260
 [<c0222e25>] ide_do_request+0x215/0x490
 [<c020b947>] __elv_add_request+0x27/0x40
 [<c0223e0e>] ide_do_drive_cmd+0x17e/0x2b0
 [<c0247961>] idescsi_queue+0x61/0x7a0
 [<c0247b49>] idescsi_queue+0x249/0x7a0
 [<c023f0e5>] scsi_send_eh_cmnd+0x165/0x490
 [<c023ef30>] scsi_eh_done+0x0/0x50
 [<c023ef00>] scsi_eh_times_out+0x0/0x30
 [<c010c153>] do_IRQ+0x213/0x340
 [<c023f8a5>] scsi_eh_tur+0x95/0xd0
 [<c023fc2c>] scsi_eh_bus_device_reset+0xec/0x120
 [<c0240628>] scsi_eh_ready_devs+0x28/0x70
 [<c0240828>] scsi_unjam_host+0x138/0x1c0
 [<c011dd40>] default_wake_function+0x0/0x30
 [<c02409b8>] scsi_error_handler+0x108/0x140
 [<c02408b0>] scsi_error_handler+0x0/0x140
 [<c01072a9>] kernel_thread_helper+0x5/0xc

Code: 0f 0b ed 01 a4 3c 2f c0 8b 56 38 a1 00 c4 30 c0 89 d1 29 c1 
 hdd: ATAPI reset complete
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: drive not ready for command
hdd: status timeout: status=0xd0 { Busy }
hdd: drive not ready for command
hdd: ATAPI reset complete
Unable to handle kernel paging request at virtual address df48fe98
 printing eip:
c023ef17
*pde = 0007c067
*pte = 1f48f000
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[<c023ef17>]    Not tainted
EFLAGS: 00010282
EIP is at scsi_eh_times_out+0x17/0x30
eax: df4b6bf8   ebx: df392ea8   ecx: df48fe98   edx: c034bf24
esi: c023ef00   edi: c030e100   ebp: c034befc   esp: c034befc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c034a000 task=c030afc0)
Stack: c034bf3c c012e42d df392ea8 c034bf38 c0111922 c034bf98 c034bf98 00000001 
       00000000 c034bf24 c034bf24 c034bf24 c030d0d0 00000001 c03a0ec8 0000000a 
       c034bf58 c0129196 c03a0ec8 00000046 c0348a00 00000000 c0348a18 c034bf90 
Call Trace:
 [<c012e42d>] run_timer_softirq+0x15d/0x3d0
 [<c0111922>] timer_interrupt+0x82/0x210
 [<c0129196>] do_softirq+0x96/0xa0
 [<c010c153>] do_IRQ+0x213/0x340
 [<c011d9b9>] schedule+0x349/0x6d0
 [<c0105000>] _stext+0x0/0x30
 [<c010a0e0>] common_interrupt+0x18/0x20
 [<c0105000>] _stext+0x0/0x30
 [<c0107066>] default_idle+0x26/0x30
 [<c01070e4>] cpu_idle+0x34/0x40
 [<c034c740>] start_kernel+0x140/0x150
 [<c034c4c0>] unknown_bootoption+0x0/0x100

Code: ff 01 0f 8e e0 1c 00 00 c9 c3 eb 0d 90 90 90 90 90 90 90 90 
 Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

(gdb) l *0xc023ef17
0xc023ef17 is in scsi_eh_times_out (semaphore.h:201).

(gdb) l scsi_eh_times_out
373      *    During error handling, the kernel thread will be sleeping waiting
374      *    for some action to complete on the device.  our only job is to
375      *    record that it timed out, and to wake up the thread.
376      **/
377     static void scsi_eh_times_out(struct scsi_cmnd *scmd)
378     {
379             scsi_eh_eflags_set(scmd, SCSI_EH_REC_TIMEOUT);
380             SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd:%p\n", __FUNCTION__,
381                                               scmd));
382
383             if (scmd->device->host->eh_action)
384                     up(scmd->device->host->eh_action);
385     }


(gdb) disas 0xc023ef17
Dump of assembler code for function scsi_eh_times_out:
0xc023ef00 <scsi_eh_times_out>: push   %ebp
0xc023ef01 <scsi_eh_times_out+1>:       mov    %esp,%ebp
0xc023ef03 <scsi_eh_times_out+3>:       mov    0x8(%ebp),%eax
0xc023ef06 <scsi_eh_times_out+6>:       orl    $0x2,0x24(%eax)
0xc023ef0a <scsi_eh_times_out+10>:      mov    0x4(%eax),%eax
0xc023ef0d <scsi_eh_times_out+13>:      mov    0x10(%eax),%eax
0xc023ef10 <scsi_eh_times_out+16>:      mov    0x64(%eax),%ecx
0xc023ef13 <scsi_eh_times_out+19>:      test   %ecx,%ecx
0xc023ef15 <scsi_eh_times_out+21>:      je     0xc023ef1f <scsi_eh_times_out+31>
0xc023ef17 <scsi_eh_times_out+23>:      incl   (%ecx)
0xc023ef19 <scsi_eh_times_out+25>:      jle    0xc0240bff <.text.lock.scsi_error+10>
0xc023ef1f <scsi_eh_times_out+31>:      leave
0xc023ef20 <scsi_eh_times_out+32>:      ret

