Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932665AbWHMCu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbWHMCu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 22:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWHMCuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 22:50:25 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:20408 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932665AbWHMCuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 22:50:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ak23xCOzrckZupTBMYFduFPe+9st4P6FC3p2P2eYkxHlwEido4Rc/y2s1S0Xt7S5WtJ6t5nrveb/n50gLQQqmkC+19sF4yxgqoZZOj34OIsYfKhvseZF4duubK/VoC4XvalAik1Xif3gWy/KTngEMePBXPayiaREficGhL1to7U=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [2.6.18-rc4][ACPI] System with ACPI 1.0 deadlocks when adding Elsa Gloria XL PCI video card
Date: Sat, 12 Aug 2006 22:50:10 -0400
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608122250.11358.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to obtain a 'new' old PCI video card and decided to drop it into the old IBM 300PL machine which has ACPI version 1.0 only:

The moment I enable ACPI in the bios and boot the kernel with ACPI on, it attempts to load the ACPI interpreter, then hangs hard.

At first, the system was hanging in the BIOS, or during initial boot, my initial investigation  I figured I was somehow exceeding the systems power (the PCI Video card is rather huge and sucks a lot of juice) so I removed some ISA/PCI cards hoping to stop the hanging. 
That worked, but ACPI was still causing the system to deadlock on boot. Turning off ACPI, I'm able to use the system fine, even when putting heavy load onto the machine voltage levels (says sensors) remain OK.  It still however
hangs in BIOS when changing any settings (if i hard power off, the settings are still accepted, I think that's a BIOS bug).

I know ACPI 1.0 is very old now, but what I am noticing is older hardware is starting to trip weird oddities in ACPI (at least with legacy versions).

Whilst ACPI was off the kernel threw a nasty IRQ handler mismatch

[   72.940301] IRQ handler type mismatch for IRQ 14
[   72.940911]  [<c0103d3e>] show_trace_log_lvl+0x15e/0x190
[   72.941083]  [<c010448f>] show_trace+0xf/0x20
[   72.941233]  [<c0104555>] dump_stack+0x15/0x20
[   72.941385]  [<c0137cf7>] setup_irq+0xb7/0x1b0
[   72.941868]  [<c0137e93>] request_irq+0xa3/0xc0
[   72.942349]  [<c0221f99>] serial8250_startup+0x409/0x430
[   72.944365]  [<c021d888>] uart_startup+0x48/0x140
[   72.945862]  [<c021e6ae>] uart_open+0xbe/0x440
[   72.947347]  [<c020a610>] tty_open+0x170/0x340
[   72.948766]  [<c01609e9>] chrdev_open+0x89/0x170
[   72.949438]  [<c0156533>] __dentry_open+0xb3/0x1f0
[   72.950049]  [<c0156725>] nameidata_to_filp+0x35/0x40
[   72.950653]  [<c015677b>] do_filp_open+0x4b/0x60
[   72.951257]  [<c01567da>] do_sys_open+0x4a/0xe0
[   72.951860]  [<c01568ac>] sys_open+0x1c/0x20
[   72.952463]  [<c0102c91>] sysenter_past_esp+0x56/0x79
[   72.952602]  [<b7f11410>] 0xb7f11410
[   72.952706]  [<c0137cf7>] setup_irq+0xb7/0x1b0
[   72.952815]  [<c0154b8a>] kmem_cache_alloc+0x5a/0xa0
[   72.952926]  [<c0222040>] serial8250_interrupt+0x0/0x110
[   72.953036]  [<c0137e93>] request_irq+0xa3/0xc0
[   72.953146]  [<c0221f99>] serial8250_startup+0x409/0x430
[   72.953258]  [<c021d888>] uart_startup+0x48/0x140
[   72.953373]  [<c021e6ae>] uart_open+0xbe/0x440
[   72.953483]  [<c0206867>] check_tty_count+0x47/0xb0
[   72.953594]  [<c020a610>] tty_open+0x170/0x340
[   72.953703]  [<c01609e9>] chrdev_open+0x89/0x170
[   72.953812]  [<c0160960>] chrdev_open+0x0/0x170
[   72.953920]  [<c0156533>] __dentry_open+0xb3/0x1f0
[   72.954029]  [<c0156725>] nameidata_to_filp+0x35/0x40
[   72.954138]  [<c015677b>] do_filp_open+0x4b/0x60
[   72.954248]  [<c0149d50>] do_mmap_pgoff+0x500/0x6e0
[   72.954387]  [<c0156466>] get_unused_fd+0xb6/0xd0
[   72.954497]  [<c01567da>] do_sys_open+0x4a/0xe0
[   72.954606]  [<c01568ac>] sys_open+0x1c/0x20
[   72.954714]  [<c0102c91>] sysenter_past_esp+0x56/0x79

Whats also interesting about that is I notice  ACPI/non-ACPI IRQ routing being inconsistent while having two e100 cards. Sometimes one is IRQ routed, while the other is not found, depending on if I do a hard reset or a soft reset. 
(Old hardware makes for rather fun quirks doesn't it?)

IRQs in use:

           CPU0
  0:    7755786          XT-PIC  timer
  1:         10          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  parport0
  6:          3          XT-PIC  floppy
  7:          0          XT-PIC  SoundBlaster
  8:          1          XT-PIC  rtc
  9:      85240          XT-PIC  eth1
 11:      38771          XT-PIC  uhci_hcd:usb1, eth0
 12:      10585          XT-PIC  i8042
 14:      11259          XT-PIC  ide0
 15:         11          XT-PIC  ide1

lspci info on PCI card:

00:10.0 VGA compatible controller: Elsa AG Gloria XL (rev 16) (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 00db
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at 30300000 [disabled] [size=64K]

00:10.1 Co-processor: 3DLabs GLINT Delta (rev 01)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e9dc0000 (32-bit, non-prefetchable) [size=128K]

00:10.2 Display controller: 3DLabs GLINT MX (rev 01)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e9de0000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at ea000000 (32-bit, non-prefetchable) [size=32M]
        Region 2: Memory at ec000000 (32-bit, non-prefetchable) [size=32M]
        Region 3: Memory at ee000000 (32-bit, non-prefetchable) [size=32M]
        Expansion ROM at fe000000 [disabled] [size=64K]

I'm not considering this to be a severe/serious problem since ACPI 1.0 is fading away..slowly. 

Just wondering if its worth regression testing ACPI 1.0 systems still (at least, until the PSU dies, then this will become moot :-)

Shawn.
