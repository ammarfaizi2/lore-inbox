Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263920AbTKJPia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 10:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTKJPi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 10:38:29 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:6357 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263920AbTKJPiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 10:38:23 -0500
From: "Csaba Halasz" <Jester01@freemail.hu>
To: <linux-kernel@vger.kernel.org>
Cc: <axboe@suse.de>
Subject: PROBLEM: ide-cd panic with faulty disk and DMA enabled (2.6.0-test9)
Date: Mon, 10 Nov 2003 16:34:48 +0100
Message-ID: <9B4E9DA25A3DD41189B000508B5C0CEE2142AD@BOMBA>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a DVD+RW disk that crashes the kernel every time I try to
read a particular area using my DVD-ROM drive with DMA enabled.
(The writer unit can read it back without any problems though.)

IMHO the crash seems to be of a more general nature,
not related to DVD+RW.

Linux version 2.6.0-test9 (hcs@defiant) (gcc version 3.3 (Debian)) #1 Sun Nov 9 14:08:41 CET 2003
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE: IDE controller at PCI slot 0000:00:09.0
NFORCE: chipset revision 195
NFORCE: not 100%% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: 0000:00:09.0 (rev c3) UDMA100 controller on pci0000:00:09.0
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 5T040H4, ATA DISK drive
hdb: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Maxtor 5T040H4, ATA DISK drive
hdd: MATSHITADVD-ROM SR-8586, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
end_request: I/O error, dev hdb, sector 0
hdb: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 123X DVD-ROM drive, 512kB Cache, UDMA(33)
hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdd: media error (bad sector): error=0x34
end_request: I/O error, dev hdd, sector 7043320
Buffer I/O error on device hdd, logical block 880415
hdd: DMA timeout retry
hdd: timeout waiting for DMA

Unable to handle kernel paging request at virtual address ddff7f74
 printing eip:
c0249af6
*pde = 00076067
*pte = 1dff7000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0249af6>]    Not tainted
EFLAGS: 00010286
EIP is at cdrom_read_intr+0x2b6/0x3b0
eax: 00000000   ebx: fffffff8   ecx: 00000001   edx: df710ca8
esi: ddff7f60   edi: 00000040   ebp: c0367ee4   esp: c0367cbc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0366000 task=c0327680)
Stack: c03c61ac 00000001 c0367cd4 00000000 00000002 c026fc01 00000058 c0367d04 
       00000720 c0367d04 c011da9e def7b960 0000d263 36b4dd08 df06ad4c 00000000 
       def7b960 c03b58d4 c0367d44 c011dd1a 00000000 c032a5e0 c0367d4c 00000046 
Call Trace:
 [<c026fc01>] fbcon_cursor+0x281/0x390
 [<c011da9e>] recalc_task_prio+0x8e/0x1b0
 [<c011dd1a>] try_to_wake_up+0x15a/0x290
 [<c0130716>] update_process_times+0x46/0x50
 [<c023c3bd>] ata_output_data+0x7d/0xa0
 [<c023c482>] atapi_output_bytes+0x32/0x70
 [<c024971c>] cdrom_transfer_packet_command+0x9c/0x100
 [<c02494a0>] cdrom_timer_expiry+0x0/0x40
 [<c0249dc9>] cdrom_start_read_continuation+0x79/0xb0
 [<c0249840>] cdrom_read_intr+0x0/0x3b0
 [<c011da9e>] recalc_task_prio+0x8e/0x1b0
 [<c011dd1a>] try_to_wake_up+0x15a/0x290
 [<c0249d50>] cdrom_start_read_continuation+0x0/0xb0
 [<c011f29a>] default_wake_function+0x2a/0x30
 [<c011f2da>] __wake_up_common+0x3a/0x60
 [<c0130716>] update_process_times+0x46/0x50
 [<c0239628>] ide_intr+0x2c8/0x5d0
 [<c01129ac>] timer_interrupt+0x8c/0x260
 [<c0249840>] cdrom_read_intr+0x0/0x3b0
 [<c010c4cb>] handle_IRQ_event+0x3b/0x70
 [<c010cae0>] do_IRQ+0x140/0x390
 [<c0105000>] _stext+0x0/0xf0
 [<c010ab5c>] common_interrupt+0x18/0x20
 [<c0105000>] _stext+0x0/0xf0
 [<c01072a6>] default_idle+0x26/0x30
 [<c0107324>] cpu_idle+0x34/0x40
 [<c036876d>] start_kernel+0x1bd/0x220
 [<c0368480>] unknown_bootoption+0x0/0x100

Code: 8b 46 14 e9 59 ff ff ff 8b 55 08 89 7c 24 08 c7 04 24 40 7c 
 Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

0xc0249af6 is in cdrom_read_intr (drivers/ide/ide-cd.c:1137).
1132                    int this_transfer;
1133
1134                    /* If we've filled the present buffer but there's another
1135                       chained buffer after it, move on. */
1136                    if (rq->current_nr_sectors == 0 && rq->nr_sectors)
1137                            cdrom_end_request(drive, 1);
1138
1139                    /* If the buffers are full, cache the rest of the data in our
1140                       internal buffer. */
1141                    if (rq->current_nr_sectors == 0) {

0xc0249ae3 <cdrom_read_intr+675>:       mov    0x8(%ebp),%eax
0xc0249ae6 <cdrom_read_intr+678>:       movl   $0x1,0x4(%esp,1)
0xc0249aee <cdrom_read_intr+686>:       mov    %eax,(%esp,1)
0xc0249af1 <cdrom_read_intr+689>:       call   0xc02490e0 <cdrom_end_request>
0xc0249af6 <cdrom_read_intr+694>:       mov    0x14(%esi),%eax
0xc0249af9 <cdrom_read_intr+697>:       jmp    0xc0249a57 <cdrom_read_intr+535>

I think the fault is at the insn reloading rq->current_nr_sectors
(the esi register probably contains the rq pointer)
It would seem that the request has been freed or the esi register 
may have been clobbered in cdrom_end_request. 
It just occured to me that this is with preempt enabled. 
I'll try disabling it tonight, just in case...

For comparison purposes I have included the PIO mode kernel messages
and also the results of a test using kernel 2.4.20. 
While the kernel does not crash, I did have a hard time stopping 
the retries or otherwise using the system in the meantime. 
(Actually I could not wait until 2.4.20 gave up, so I rebooted)

If I should provide any more information or can help with testing
just let me know.

Regards,
    Csaba


2.6.0-test9 PIO:

hdd: DMA disabled
hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdd: media error (bad sector): error=0x34
hdd: irq timeout: status=0xd0 { Busy }
hdd: irq timeout: error=0xd0LastFailedSense 0x0d 
hdd: ATAPI reset complete
hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdd: media error (bad sector): error=0x34
end_request: I/O error, dev hdd, sector 7043456
Buffer I/O error on device hdd, logical block 880432

2.4.20-ac2:

hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: timeout waiting for DMA
hdd: timeout waiting for DMA
hdd: (__ide_dma_test_irq) called while not waiting
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x34Aborted Command LastFailedSense 0x03 
hdd: drive not ready for command
hdd: status timeout: status=0xd1 { Busy }
hdd: status timeout: error=0xd1IllegalLengthIndication LastFailedSense 0x0d 
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: timeout waiting for DMA
hdd: timeout waiting for DMA
hdd: (__ide_dma_test_irq) called while not waiting
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: timeout waiting for DMA
hdd: timeout waiting for DMA
hdd: (__ide_dma_test_irq) called while not waiting
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: ATAPI reset complete
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: DMA disabled
hdd: ATAPI reset complete
end_request: I/O error, dev 16:40 (hdd), sector 7043452
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdd: cdrom_decode_status: error=0x34Aborted Command LastFailedSense 0x03 
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
hdd: irq timeout: error=0xd0LastFailedSense 0x0d 
hdd: ATAPI reset complete
end_request: I/O error, dev 16:40 (hdd), sector 7043456

