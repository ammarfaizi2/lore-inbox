Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264130AbUDBR3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 12:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264133AbUDBR3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 12:29:10 -0500
Received: from postman2.arcor-online.net ([151.189.0.152]:63738 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S264130AbUDBR3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 12:29:02 -0500
Message-ID: <406DA2DD.6040700@bndlg.de>
Date: Fri, 02 Apr 2004 17:29:01 +0000
From: Johannes Deisenhofer <joe@bndlg.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Undecoded Interrupt with SiL3112 IDE?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a recent problem with my sil3112 onboard SATA adapter.

Starting after a while (sometimes after hours of uptime), i get this every few 
seconds:

----- snip -----
irq 18: nobody cared!
Call Trace:
  [<c0108f03>] __report_bad_irq+0x33/0x90
  [<c0108fe0>] note_interrupt+0x50/0x80
  [<c01091e9>] do_IRQ+0xa9/0x130
  [<c0105030>] default_idle+0x0/0x30
  [<c010795c>] common_interrupt+0x18/0x20
  [<c0105030>] default_idle+0x0/0x30
  [<c0105053>] default_idle+0x23/0x30
  [<c01050de>] cpu_idle+0x2e/0x40
  [<c0103055>] _stext+0x55/0x60
  [<c04e66f5>] start_kernel+0x155/0x160

handlers:
[<c02ae9f0>] (ide_intr+0x0/0x180)
[<c02ae9f0>] (ide_intr+0x0/0x180)
Disabling IRQ #18
----- snip -----

This started recently (without changes in hardware or software) and drags down 
my machine quite a bit. No hangs / data losses, however.

- There is always an interrupt storm (about 100000 IRQ in ca. 1 sec) on IRQ 18 
when this message is logged.
- kernel 2.6.5-rc2
- siimage driver (not libata)
- two SATA drives on adapter, ST3120026AS and WDC WD1200JD-00FYB0
- Asus A7N8X board (nforce2 chipset), latest bios
- There is only the onboard SATA adapter on this IRQ. I've pulled the PCI card 
physically sharing the same IRQ line.
- Same problem with kernel 2.4, although it handles it less gracefully (system 
  freezes for some time).
- Disabling ACPI doesn't change a thing (IRQ #11 will be disabled, then)
- System has otherwise been stable.
- After reboot, problem will disappear for a while

I suspect some unhandled error condition of the sil chip. After disconnecting 
and reseating both SATA connectors, problems disappeared for two days. 
Coincidence?

Anything I can test before I go and buy new cables?

 From lspci -v -xxxx

01:0b.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 
SATARaid Controller (rev 01)
         Subsystem: CMD Technology Inc: Unknown device 6112
         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
         I/O ports at 9800 [size=8]
         I/O ports at 9c00 [size=4]
         I/O ports at a000 [size=8]
         I/O ports at a400 [size=4]
         I/O ports at a800 [size=16]
         Memory at de005000 (32-bit, non-prefetchable) [size=512]
         Expansion ROM at <unassigned> [disabled] [size=512K]
         Capabilities: [60] Power Management version 2
00: 95 10 12 31 07 00 b0 02 01 00 04 01 01 20 00 00
10: 01 98 00 00 01 9c 00 00 01 a0 00 00 01 a4 00 00
20: 01 a8 00 00 00 50 00 de 00 00 00 00 95 10 12 61
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 00 00
40: 02 00 00 00 00 82 08 ba 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 00 00 20 00 00 e0 d5 37 00 00 20 00 00 c0 d5 37
80: 03 00 00 00 03 00 00 00 00 00 10 00 da a9 50 7e
90: 00 fc 01 01 0f ff 00 00 00 00 00 18 00 00 00 00
a0: 01 60 8a 32 8a 32 dd 62 c1 10 92 43 01 40 09 40
b0: 01 60 8a 32 8a 32 dd 62 c1 10 92 43 02 40 09 40
c0: 84 01 00 00 13 01 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


P.S.: I'm not on the linux-kernel list, but I read the archives

Jo


