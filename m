Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbTCMRMG>; Thu, 13 Mar 2003 12:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262488AbTCMRMF>; Thu, 13 Mar 2003 12:12:05 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:37393
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S262485AbTCMRMB>; Thu, 13 Mar 2003 12:12:01 -0500
Subject: 2.5.64-mm6: kernel BUG at kernel/timer.c:155!
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1047576167.1318.4.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 09:22:47 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was reading back a freshly burned CD from my shiny new Plexwriter
48/24/48A.  I'm using ide-scsi, so this is an iso9660 filesystem mounted
from /dev/scd0.  After reading for a while, apparently successfully, it
started failing with the messages below:

spurious 8259A interrupt: IRQ7.
hdc: lost interrupt
ide-scsi: CoD != 0 in idescsi_pc_intr
ide-scsi: abort called for 9677
ide-scsi: abort called for 9674
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
hdc: status timeout: status=0x80 { Busy }
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
hdc: status timeout: status=0x80 { Busy }
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
hdc: status timeout: status=0x80 { Busy }
hdc: drive not ready for command
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
hdc: status timeout: status=0x80 { Busy }
hdc: drive not ready for command
hdc: ATAPI reset complete
ide-scsi: abort called for 9674
ide-scsi: abort called for 9675
ide-scsi: abort called for 9676
ide-scsi: reset called for 9677
------------[ cut here ]------------
kernel BUG at kernel/timer.c:155!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c011fc41>]    Tainted: PF
EFLAGS: 00010002
EIP is at add_timer+0xdb/0xe8
eax: 00000001   ebx: c1b3b5e4   ecx: c0322820   edx: c03d33fc
esi: 00000096   edi: c020b506   ebp: f7d8feac   esp: f7d8fea4
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_0 (pid: 9, threadinfo=f7d8e000 task=c1b7cd00)
Stack: 00000001 c1b3b5c0 f7d8fed0 c020b44c c1b3b5e4 00000000 00000082 00000000
       00000000 c03d33fc c03d33fc f7d8ff00 c020baf4 c03d33fc c020b506 00000032
       00000000 c1b3b5c0 c03d3350 00000096 00000000 c03d33fc c03d340c f7d8ff18
Call Trace:
 [<c020b44c>] ide_set_handler+0x48/0x74
 [<c020baf4>] do_reset1+0x214/0x232
 [<c020b506>] atapi_reset_pollfunc+0x0/0x11a
 [<c020bb40>] ide_do_reset+0x2e/0x62
 [<c02267b4>] idescsi_reset+0xc0/0xf6
 [<c0220a36>] scsi_try_bus_device_reset+0x46/0x66
 [<c0220abb>] scsi_eh_bus_device_reset+0x65/0x108
 [<c0221224>] scsi_eh_ready_devs+0x28/0x74
 [<c022137f>] scsi_unjam_host+0xa1/0xa4
 [<c022142f>] scsi_error_handler+0xad/0xdc
 [<c0221382>] scsi_error_handler+0x0/0xdc
 [<c0107209>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 9b 00 62 11 2e c0 e9 41 ff ff ff 55 31 c0 89 e5 83 ec



