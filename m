Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVCYUY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVCYUY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVCYUY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:24:27 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:17547 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261768AbVCYUYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:24:14 -0500
Date: Fri, 25 Mar 2005 21:24:15 +0100
From: Luca <kronos@kronoz.cjb.net>
To: Linux Serial <linux-serial@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Garbage on serial console after serial driver loads
Message-ID: <20050325202414.GA9929@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I attached a null modem cable to my notebook and I'm seeing garbage as
soon as the serial driver is loaded. I tried booting with init=/bin/bash
to be sure that it's not some rc script doing strange things to the
serial port, but this didn't solve the problem.

This is the relevant part of .config:

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set


I also tried with ACPI discovery (just in case) without success:

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

This is kernel command line:

Kernel command line: BOOT_IMAGE=linux-2.6.12rc1 ro root=305 video=sisfb:mode:1024x768x16 console=tty0 console=ttyS0,38400n8 init=/bin/bash

And this is where garbage appears:

PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
[garbage]

Once I get the shell using 'clear' cures the problem. The log (from
dmesg) should be:

Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A

This is the first time that I use serial console with the notebook, but
I've done this before with other machines and never saw this problem.

Googling aroung I found another user with the same problem:
http://www.ussg.iu.edu/hypermail/linux/kernel/0503.1/0442.html
but no answer :(

Any suggestion?

Luca
-- 
Home: http://kronoz.cjb.net
Un apostolo vedendo Gesu` camminare sulle acque:
- Cazzo se e` buono 'sto fumo!!!
