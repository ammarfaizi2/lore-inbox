Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTDGSv1 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTDGSv1 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:51:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16850 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263580AbTDGSvZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 14:51:25 -0400
Date: Mon, 7 Apr 2003 12:02:45 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: oops when using hdc=ide-scsi (2.5.66)
Message-Id: <20030407120245.3a51a4f6.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this when I boot 2.5.66 and the Linux command line contains
"hdc=ide-scsi".  Yes, I know that I can remove that option (as in
"DDT"), but the kernel shouldn't do this, either.

/dev/hdc is a CD-RW drive with no media in it.


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: MAXTOR 6L040J2, ATA DISK drive
hdb: MAXTOR 6L040J2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CR-48X9TE, ATAPI CD/DVD-ROM drive
hdd: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=77557/16/63, UDMA(100)
 hda: hda1 hda2
hdb: host protected area => 1
hdb: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=77557/16/63, UDMA(100)
 hdb: hdb1 hdb2 hdb3 hdb4
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdd, sector 0
PCI: Found IRQ 9 for device 02:0c.0
PCI: Sharing IRQ 9 with 02:0b.1
PCI: Sharing IRQ 9 with 02:0e.0
PCI: Sharing IRQ 9 with 00:1f.3
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec 2940 SCSI adapter>
        aic7870: Single Channel A, SCSI Id=7, 16/253 SCBs

scsi1 : SCSI host adapter emulation for IDE ATAPI devices
ide-scsi: abort called for 8
hdc: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
drivers/scsi/ide-scsi.c:361: spin_lock(drivers/scsi/hosts.c:f7d900b8) already locked by drivers/scsi/scsi_error.c/724
drivers/scsi/scsi_error.c:726: spin_unlock(drivers/scsi/hosts.c:f7d900b8) not locked
hdc: status timeout: status=0xd0 { Busy }
ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
hdc: ATAPI reset complete
ide-scsi: reset called for 8
------------[ cut here ]------------
kernel BUG at drivers/scsi/ide-scsi.c:492!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c02e5627>]    Not tainted
EFLAGS: 00010282
EIP is at idescsi_transfer_pc+0xa5/0x10e
eax: c029e8c2   ebx: c0510304   ecx: 033fb2c4   edx: 00000172
esi: f7d90164   edi: f7db2d30   ebp: f7d3bcd8   esp: f7d3bcb4
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_1 (pid: 10, threadinfo=f7d3a000 task=c1b60cc0)
Stack: 00000172 c0510304 00000008 00000080 0000001e f7d90164 c0510304 00000000 
       f7d90c08 f7d3bd04 c029995d c0510304 f7db2d30 00000000 00000088 0000001e 
       0000000f f7d90c08 c0510304 c0510258 f7d3bd44 c0299bec c0510304 f7d90c08 
Call Trace:
 [<c029995d>] start_request+0xff/0x14e
 [<c0299bec>] ide_do_request+0x21c/0x488
 [<c029ab5a>] ide_do_drive_cmd+0x150/0x276
 [<c011eab6>] __call_console_drivers+0x56/0x58
 [<c02e5d4c>] idescsi_queue+0x68/0x7d4
 [<c02e5f48>] idescsi_queue+0x264/0x7d4
 [<c011fa37>] profile_hook+0x21/0x25
 [<c02b8847>] scsi_send_eh_cmnd+0x335/0x69a
 [<c02b8496>] scsi_eh_done+0x0/0x7c
 [<c02b8442>] scsi_eh_times_out+0x0/0x54
 [<c02b90cd>] scsi_eh_tur+0x8b/0xee
 [<c02b9552>] scsi_eh_bus_device_reset+0x13c/0x186
 [<c02ba2fe>] scsi_eh_ready_devs+0x28/0x74
 [<c02ba62f>] scsi_unjam_host+0x205/0x324
 [<c02ba8ca>] scsi_error_handler+0x17c/0x1d4
 [<c02ba74e>] scsi_error_handler+0x0/0x1d4
 [<c01071f5>] kernel_thread_helper+0x5/0xc

Code: 0f 0b ec 01 3e 8a 41 c0 8b 57 38 a1 a0 28 45 c0 89 d1 29 c1 
 hdc: ATAPI reset complete
hdc: status error: status=0x48 { DriveReady DataRequest }
hdc: drive not ready for command
hdc: status timeout: status=0xd0 { Busy }
hdc: drive not ready for command


--
~Randy
