Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVF2FU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVF2FU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 01:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVF2FU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 01:20:57 -0400
Received: from web52610.mail.yahoo.com ([206.190.39.148]:60345 "HELO
	web52610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262421AbVF2FTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 01:19:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2T5enrmNztkiaBMMAjGr00pseWPDo+8SN1G47cD98RD2rSPjqitIMinDL1ZlGyioHxzCKAtkRRM72amJVeWo8tJC0DFJJxjBAT6YI6br7E5o6giODrJ6Salh9Y12wfwPeWmmkRSV4sgzFg2lIVeLqRJ08xHaA9Ib4/b53Y+lKiA=  ;
Message-ID: <20050629051940.66828.qmail@web52610.mail.yahoo.com>
Date: Wed, 29 Jun 2005 15:19:40 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: [PROBLEM] kernel BUG at include/linux/blkdev.h:601
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vanilla 2.6.12 or 2.6.12-git* (the below BUG/Panic
report is from 2.6.12-git9).

Hardware:
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings:
hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings:
hdc:DMA, hdd:DMA
hda: IC35L060AVV207-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST CD-ROM GCR-8482B, ATAPI CD/DVD-ROM drive

Software:
Linux-2.6.*
Vanilla FC4 + official updates

How to reproduce:
Insert Coldplay X&Y CD album (yes, it's a
copy-controlled cd), and wait for few minutes until it
crashes. No need to even 'play' it.

end_request: I/O error, dev hdc, sector 0
printk: 140 messages suppressed.
Buffer I/O error on device hdc, logical block 0
hdc: command error: status=0x51 { DriveReady
SeekComplete Error }
hdc: command error: error=0x54 { AbortedCommand
LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 0
------------[ cut here ]------------
kernel BUG at include/linux/blkdev.h:601!
invalid operand: 0000 [#1]
Modules linked in: autofs4 sunrpc af_packet dm_mod
video thermal processor fan button uhci_hcd ehci_hcd
intel_agp i2c_i801 i2c_core snd_intel8x0
snd_ac97_codec snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd soundcore
snd_page_alloc e100 mii floppy ide_cd cdrom usbcore
unix ext3 mbcache jbd
CPU:    0
EIP:    0060:[<c01f5e68>]    Not tainted VLI
EFLAGS: 00010046   (2.6.12-git9) 
EIP is at __ide_end_request+0x118/0x125
eax: 00009feb   ebx: de543460   ecx: 01600100   edx:
de543460
esi: 00000001   edi: c033e5fc   ebp: 00000292   esp:
c030ef58
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c030e000
task=c02a2b80)
Stack: 00000001 de543460 c033e5fc c01f5eca 00000001
00000001 00000012 c033e5fc 
       00000012 de543460 e008d547 e008c8af c033e56c
00000004 00000003 00000012 
       0000000f 00000050 df3dad80 c033e5fc 00000296
c033e56c c01f7762 c030efb0 
Call Trace:
 [<c01f5eca>] ide_end_request+0x55/0x57
 [<e008d547>] cdrom_pc_intr+0x90/0x219 [ide_cd]
 [<e008c8af>] cdrom_timer_expiry+0x0/0x59 [ide_cd]
 [<c01f7762>] ide_intr+0x66/0x11d
 [<e008d4b7>] cdrom_pc_intr+0x0/0x219 [ide_cd]
 [<c01320ed>] handle_IRQ_event+0x2e/0x5a
 [<c0132197>] __do_IRQ+0x7e/0xc7
 [<c010459d>] do_IRQ+0x4a/0x82
 =======================
 [<c0102e32>] common_interrupt+0x1a/0x20
 [<c010101a>] default_idle+0x0/0x29
 [<c0101040>] default_idle+0x26/0x29
 [<c01010a6>] cpu_idle+0x34/0x4c
 [<c02e770a>] start_kernel+0x15d/0x1b7
 [<c02e72f7>] unknown_bootoption+0x0/0x1b6
Code: 50 14 89 f8 ff 92 e0 04 00 00 e9 31 ff ff ff 8b
47 10 89 da e8 c6 5f ff ff e9 50 ff ff ff 0f 0b 3f 00
1e 44 28 c0 e9 fc fe ff ff <0f> 0b 59 02 6c 3c 28 c0
e9 40 ff ff ff 55 57 56 53 83 ec 08 89 
 <0>Kernel panic - not syncing: Fatal exception in
interrupt

Thanks
Hari

PS: Since I am not subscribed to LKML, please cc me on replies.

Send instant messages to your online friends http://au.messenger.yahoo.com 
