Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbTDHUHW (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 16:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbTDHUHW (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 16:07:22 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:22022 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261727AbTDHUHS (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 16:07:18 -0400
Date: Tue, 8 Apr 2003 22:18:43 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.67
In-Reply-To: <Pine.LNX.4.51L.0304082115060.20726@piorun.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.51L.0304082213440.2152@piorun.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
 <Pine.LNX.4.51L.0304082115060.20726@piorun.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003, Pawe³ Go³aszewski wrote:
> My kernel config: http://piorun.ds.pg.gda.pl/~blues/config-2.5.67.txt

One more thing - I become ~1oops per second... and my cdrom is still not 
usable:
# mount /dev/hdd /mnt/cdrom/
mount: /dev/hdd is not a valid block device
# ls -l /dev/hdd
brw-rw----    1 root     disk      22,  64 1998-05-05  /dev/hdd
[...]
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST340016A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IBM-DTLA-307015, ATA DISK drive
hdd: LG DVD-ROM DRD-8120B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, 
UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
hdc: host protected area => 1
hdc: 30003120 sectors (15362 MB) w/1916KiB Cache, CHS=29765/16/63, 
UDMA(33)
 /dev/ide/host0/bus1/target0/lun0: unknown partition table
[...]

oops:
[...]
Debug: sleeping function called from illegal context at mm/slab.c:1658
Call Trace:
 [<c011c2bf>] __might_sleep+0x5f/0x70
 [<c013b95b>] kmalloc+0x4b/0xa0
 [<c02079b0>] accel_cursor+0xe0/0x2d0
 [<c021f18a>] skb_release_data+0x8a/0xa0
 [<c0207d78>] fb_vbl_handler+0x78/0xa0
 [<c0124dcc>] update_process_times+0x2c/0x40
 [<c0124c9d>] update_wall_time+0xd/0x40
 [<c0206540>] cursor_timer_handler+0x10/0x30
 [<c0124ef8>] run_timer_softirq+0xf8/0x130
 [<c0206530>] cursor_timer_handler+0x0/0x30
 [<c01216b1>] do_softirq+0x51/0xb0
 [<c010c700>] do_IRQ+0xf0/0x110
 [<c010b064>] common_interrupt+0x18/0x20
 [<c01cb6fe>] acpi_processor_idle+0xfe/0x210
 [<c01cb600>] acpi_processor_idle+0x0/0x210
 [<c0109040>] default_idle+0x0/0x30
 [<c01090f5>] cpu_idle+0x35/0x40
 [<c01090f2>] cpu_idle+0x32/0x40
 [<c0105000>] rest_init+0x0/0x60
 [<c0105055>] rest_init+0x55/0x60

Debug: sleeping function called from illegal context at mm/slab.c:1658
Call Trace:
 [<c011c2bf>] __might_sleep+0x5f/0x70
 [<c013b95b>] kmalloc+0x4b/0xa0
 [<c02079b0>] accel_cursor+0xe0/0x2d0
 [<c0254d92>] arp_process+0x442/0x450
 [<c0207d78>] fb_vbl_handler+0x78/0xa0
 [<c0124712>] add_timer+0x52/0x90
 [<c0124dcc>] update_process_times+0x2c/0x40
 [<c0124c9d>] update_wall_time+0xd/0x40
 [<c0206540>] cursor_timer_handler+0x10/0x30
 [<c0124ef8>] run_timer_softirq+0xf8/0x130
 [<c0206530>] cursor_timer_handler+0x0/0x30
 [<c01216b1>] do_softirq+0x51/0xb0
 [<c010c700>] do_IRQ+0xf0/0x110
 [<c010b064>] common_interrupt+0x18/0x20
 [<c01cb6fe>] acpi_processor_idle+0xfe/0x210
 [<c01cb600>] acpi_processor_idle+0x0/0x210
 [<c0109040>] default_idle+0x0/0x30
 [<c01090f5>] cpu_idle+0x35/0x40
 [<c01090f2>] cpu_idle+0x32/0x40
 [<c0105000>] rest_init+0x0/0x60
 [<c0105055>] rest_init+0x55/0x60


-- 
pozdr.  Pawe³ Go³aszewski        
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
