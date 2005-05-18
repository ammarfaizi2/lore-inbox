Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVERW1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVERW1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVERW1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:27:46 -0400
Received: from main.gmane.org ([80.91.229.2]:16352 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262382AbVERW0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:26:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <Fieroch@web.de>
Subject: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18: nobody
 cared!"
Date: Thu, 19 May 2005 00:24:02 +0200
Message-ID: <d6gf8j$jnb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: de-de, en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem 1:
while booting the message "hdb: cdrom_pc_intr: The drive appears
confused (ireason = 0x01)" repeats several times and the system hangs
for some seconds. After booting sometimes I get the same message and
linux hangs.

Problem 2:
syslog message "irq 18: nobody cared!" followed by a call trace repeats
while booting and while running linux.

On the bottom of this mail you'll find an extract of /var/log/syslog
showing this error.


My system is a P4 630 with em64t, ASUS P5GD2 Premium board (ICH6
chipset) and nvidia 6600GT PCIe graphic card.
I'm running a self compiled kernel 2.6.12rc4 but I've had these bugs in
 self compiled kernel 2.6.11.8 and default debian kernel
2.6.11-9-em64t-p4-smp too.
The default debian kernel 2.6.8-11-em64t-p4-smp seems to be the only one
where problem 1 does not occur but problem 2 does.



/var/log/syslog:

...
ICH6: chipset revision 3
ICH6: 100%% native mode on irq 18
    ide0: BM-DMA at 0x5800-0x5807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x5808-0x580f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC35L060AVV207-0, ATA DISK drive
hdb: SONY CD-RW CRX210E1, ATAPI CD/DVD-ROM drive
ide0 at 0x7000-0x7007,0x6802 on irq 18
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1
hdb: packet command error: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Losing some ticks... checking if CPU frequency changed.
ide: failed opcode was: unknown
hdb: drive not ready for command
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
last message repeated 37 times
irq 18: nobody cared!

Call Trace: <IRQ> <ffffffff80151c54>{__report_bad_irq+48}
<ffffffff80151d18>{note_interrupt+91}
       <ffffffff801516d3>{__do_IRQ+257} <ffffffff80110469>{do_IRQ+67}
       <ffffffff8010ddc1>{ret_from_intr+0}  <EOI>
<ffffffff8010dee9>{retint_kernel+38}
       <ffffffff8010bb2c>{mwait_idle+94} <ffffffff8010bab0>{cpu_idle+71}
       <ffffffff80670876>{start_kernel+445}
<ffffffff8067022c>{x86_64_start_kernel+320}

handlers:
[<ffffffff80308031>] (ide_intr+0x0/0x17a)
Disabling IRQ #18
ide-cd: cmd 0x5a timed out
hdb: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdb: DMA disabled
hdb: ATAPI reset complete
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
last message repeated 52 times
Uniform CD-ROM driver Revision: 3.20
hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
last message repeated 3 times
...

