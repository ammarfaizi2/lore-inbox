Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVCFUKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVCFUKY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 15:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVCFUKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 15:10:24 -0500
Received: from isilmar.linta.de ([213.239.214.66]:51125 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261488AbVCFUJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 15:09:57 -0500
Date: Sun, 6 Mar 2005 14:09:46 -0600
From: Hendrik Hoeth <hendrik.hoeth@cern.ch>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux@brodo.de
Subject: serial CardBus card does not wake up after sleep
Message-ID: <20050306200946.GD3101@mail.physik.uni-wuppertal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-URL: http://www.philippi-trust.de/hendrik/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using a serial CardBus card (Sony Ericsson GC79 -- combined GPRS and
WiFi, I'm talking about the GPRS modem part of it) in a Samsung P35
laptop, kernel version 2.6.11. If I put the laptop in S3 leaving the
card in the laptop, the card does not wake up on resume. I need to
remove and reinsert the card.

If I suspend the laptop having an open ppp-session, the session is dead
after resume. It takes long for pppd to exit (ctrl-c), and when I remove
the card, I get the "kernel BUG" message pasted below.

This is what lspci tells me about the card:
----------8<--------------
07:00.0 Network controller: Broadcom Corporation: Unknown device 4320 (rev 03)
        Subsystem: Unknown device 18de:0002
        Flags: fast devsel, IRQ 11
        Memory at 51000000 (32-bit, non-prefetchable) [disabled] [size=8K]

07:00.1 Serial controller: Broadcom Corporation: Unknown device 4322 (rev 03) (prog-if 02 [16550])
        Subsystem: Unknown device 18de:0002
        Flags: fast devsel, IRQ 11
        I/O ports at 4c00 [size=256]
----------8<--------------


That's what I find in the logfiles:


Mar  6 05:04:02 prometheus kernel: PM: Preparing system for suspend
Mar  6 05:04:02 prometheus kernel: Stopping tasks: ================================|
Mar  6 05:04:02 prometheus kernel: PM: Entering state.
Mar  6 05:04:02 prometheus kernel:  hwsleep-0306 [19938] acpi_enter_sleep_state: Entering sleep state [S3]
Mar  6 05:04:02 prometheus kernel: Back to C!
Mar  6 05:04:02 prometheus kernel: PM: Finishing up.
Mar  6 05:04:02 prometheus kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Mar  6 05:04:02 prometheus kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Mar  6 05:04:02 prometheus kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Mar  6 05:04:02 prometheus kernel: PCI: cache line size of 32 is not supported by device 0000:00:1d.7
Mar  6 05:04:02 prometheus kernel: ehci_hcd 0000:00:1d.7: USB 2.0 restarted, EHCI 1.00, driver 10 Dec 2004
Mar  6 05:04:02 prometheus kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
Mar  6 05:04:02 prometheus kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
Mar  6 05:04:02 prometheus kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Mar  6 05:04:02 prometheus kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level, low) -> IRQ 5
Mar  6 05:04:02 prometheus kernel: PCI: Setting latency timer of device 0000:00:1f.6 to 64
Mar  6 05:04:02 prometheus kernel: ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
Mar  6 05:04:02 prometheus kernel: ttyS4: LSR safety check engaged!
Mar  6 05:04:03 prometheus kernel: Restarting tasks... done
Mar  6 05:04:34 prometheus kernel: acpi_power-0472 [19947] acpi_power_transition : Error transitioning device [FAN1] to D0
Mar  6 05:04:34 prometheus kernel: acpi_bus-0269 [19946] acpi_bus_set_power    : Error transitioning device [FAN1] to D0
Mar  6 05:04:34 prometheus kernel: acpi_thermal-0615 [19945] acpi_thermal_active   : Unable to turn cooling device [c1aef8e8] 'on'
Mar  6 05:04:34 prometheus kernel: acpi_bus-0269 [19947] acpi_bus_set_power    : Error transitioning device [FAN1] to D0
Mar  6 05:04:34 prometheus kernel: acpi_thermal-0615 [19946] acpi_thermal_active   : Unable to turn cooling device [c1aef8e8] 'on'
Mar  6 05:04:34 prometheus kernel: acpi_bus-0269 [19948] acpi_bus_set_power    : Error transitioning device [FAN1] to D0
Mar  6 05:04:34 prometheus kernel: acpi_thermal-0615 [19947] acpi_thermal_active   : Unable to turn cooling device [c1aef8e8] 'on'
Mar  6 05:05:18 prometheus kernel: ------------[ cut here ]------------
Mar  6 05:05:18 prometheus kernel: kernel BUG at drivers/serial/8250.c:1292!
Mar  6 05:05:18 prometheus kernel: invalid operand: 0000 [#1]
Mar  6 05:05:18 prometheus kernel: PREEMPT 
Mar  6 05:05:18 prometheus kernel: Modules linked in: firmware_class ieee80211 ieee80211_crypt
Mar  6 05:05:18 prometheus kernel: CPU:    0
Mar  6 05:05:18 prometheus kernel: EIP:    0060:[read_chan+1801/2096]    Not tainted VLI
Mar  6 05:05:18 prometheus kernel: EFLAGS: 00010246   (2.6.11) 
Mar  6 05:05:18 prometheus kernel: EIP is at serial_unlink_irq_chain+0x69/0x80
Mar  6 05:05:18 prometheus kernel: eax: 00000000   ebx: c05aed6c   ecx: 00000000   edx: 0000000b
Mar  6 05:05:18 prometheus kernel: esi: c05af050   edi: a4000000   ebp: c05af050   esp: f6e47e50
Mar  6 05:05:18 prometheus kernel: ds: 007b   es: 007b   ss: 0068
Mar  6 05:05:18 prometheus kernel: Process pppd (pid: 8971, threadinfo=f6e46000 task=f7404a80)
Mar  6 05:05:18 prometheus kernel: Stack: 00000000 00000000 f6b96480 c05af050 c02b61f4 c05af050 00000286 00000286 
Mar  6 05:05:18 prometheus kernel:        f7e37ca0 f6a15000 c02b796f f7e37ca0 00000015 00000000 f6a15000 00000000 
Mar  6 05:05:18 prometheus kernel:        c02b78a0 f70547c0 c029c113 f6a15000 f70547c0 00000000 00000000 c0118330 
Mar  6 05:05:18 prometheus kernel: Call Trace:
Mar  6 05:05:18 prometheus kernel:  [release_dev+1844/2160] uart_shutdown+0xa4/0x100
Mar  6 05:05:18 prometheus kernel:  [__do_SAK+223/576] uart_close+0xcf/0x220
Mar  6 05:05:18 prometheus kernel:  [__do_SAK+16/576] uart_close+0x0/0x220
Mar  6 05:05:18 prometheus kernel:  [acpi_tb_get_required_tables+354/687] release_dev+0x723/0x870
Mar  6 05:05:18 prometheus kernel:  [release_console_sem+144/240] release_console_sem+0x90/0xf0
Mar  6 05:05:18 prometheus kernel:  [acpi_power_get_list_state+234/273] set_cursor+0x69/0x90
Mar  6 05:05:18 prometheus kernel:  [acpi_ut_allocate_owner_id+198/214] write_chan+0x1dc/0x220
Mar  6 05:05:18 prometheus kernel:  [__wake_up+83/128] __wake_up+0x53/0x80
Mar  6 05:05:18 prometheus kernel:  [acpi_rs_irq_resource+225/347] tty_ldisc_deref+0x35/0xa0
Mar  6 05:05:18 prometheus kernel:  [acpi_tb_build_common_facs+133/268] tty_write+0x20d/0x280
Mar  6 05:05:18 prometheus kernel:  [acpi_tb_delete_single_table+21/65] tty_release+0x14/0x20
Mar  6 05:05:18 prometheus kernel:  [__fput+302/368] __fput+0x12e/0x170
Mar  6 05:05:18 prometheus kernel:  [filp_close+82/160] filp_close+0x52/0xa0
Mar  6 05:05:18 prometheus kernel:  [sys_close+116/192] sys_close+0x74/0xc0
Mar  6 05:05:18 prometheus kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
Mar  6 05:05:18 prometheus kernel: Code: 74 24 0c 83 c4 10 c3 89 5c 24 04 89 14 24 e8 bf bd e7 ff 89 74 24 04 89 1c 24 e8 d3 fd ff ff 8b 5c 24 08 8b 74 24 0c 83 c4 10 c3 <0f> 0b 0c 05 e2 e8 48 c0 eb b6 8d b6 00 00 00 00 8d bc 27 00 00 


Cheers,

    Hendrik

-- 
Die gesellschaftliche Konversation waere ein ausgezeichnetes
Schlafmittel, wenn die Leute sich angewoehnen koennten, etwas
leiser zu sprechen.
                         -- George Bernard Shaw
