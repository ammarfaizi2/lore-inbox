Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947190AbWKKMe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947190AbWKKMe6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 07:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947198AbWKKMe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 07:34:58 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:2177 "EHLO
	torres.zugschlus.de") by vger.kernel.org with ESMTP
	id S1947190AbWKKMe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 07:34:57 -0500
Date: Sat, 11 Nov 2006 13:34:55 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ttyS0 not working any more, LSR safety check engaged
Message-ID: <20061111123455.GB9206@torres.l21.ma.zugschlus.de>
References: <20061111114352.GA9206@torres.l21.ma.zugschlus.de> <20061111115016.GA24112@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061111115016.GA24112@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 11:50:16AM +0000, Russell King wrote:
> Maybe something to do with PNP?  Maybe ACPI?  Both of those I know
> nothing about, but I suggest that if you have PNP enabled, you
> build and use the 8250_pnp module, even if your port is detected
> by the legacy detection methods in 8250.

How do I configure that?

I have:
  ? ?<*> 8250/16550 and compatible serial support                         ? ?
  ? ?[*]   Console on 8250/16550 and compatible serial port               ? ?
  ? ?<*>   8250/16550 PCI device support                                  ? ?
  ? ?<*>   8250/16550 PNP device support                                  ? ?
  ? ?< >   8250/16550 PCMCIA device support                               ? ?
  ? ?(4)   Maximum number of 8250/16550 serial ports                      ? ?
  ? ?(4)   Number of 8250/16550 serial ports to register at runtime       ? ?
  ? ?[*]   Extended 8250/16550 serial driver options                      ? ?
  ? ?[ ]     Support more than 4 legacy serial ports (NEW)                ? ?
  ? ?[ ]     Support for sharing serial interrupts (NEW)                  ? ?
  ? ?[ ]     Autodetect IRQ on standard ports (unsafe) (NEW)              ? ?
  ? ?[ ]     Support RSA serial ports (NEW)                               

(drivers compiled in since I want to use the serial console without
initrd).

$ grep -i 'nov 11.*\(8250\|serial\|ttyS\|pnp\)' /var/log/syslog/syslog
Nov 11 09:27:41 scyw00225 kernel: pnp: PnP ACPI init
Nov 11 09:27:41 scyw00225 kernel: pnp: PnP ACPI: found 15 devices
Nov 11 09:27:41 scyw00225 kernel: PnPBIOS: Disabled by ACPI PNP
Nov 11 09:27:41 scyw00225 kernel: pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
Nov 11 09:27:41 scyw00225 kernel: pnp: 00:0d: ioport range 0x1000-0x107f could not be reserved
Nov 11 09:27:41 scyw00225 kernel: pnp: 00:0d: ioport range 0x1100-0x113f has been reserved
Nov 11 09:27:41 scyw00225 kernel: pnp: 00:0d: ioport range 0x1200-0x121f has been reserved
Nov 11 09:27:41 scyw00225 kernel: isapnp: Scanning for PnP cards...
Nov 11 09:27:41 scyw00225 kernel: isapnp: No Plug & Play device found
Nov 11 09:27:41 scyw00225 kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Nov 11 09:27:41 scyw00225 kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov 11 09:27:41 scyw00225 kernel: serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
Nov 11 09:27:41 scyw00225 kernel: 00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov 11 09:27:41 scyw00225 kernel: PNP: PS/2 Controller [PNP0303:C192,PNP0f13:C193] at 0x60,0x64 irq 1,12
Nov 11 09:27:41 scyw00225 kernel: usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
Nov 11 09:27:41 scyw00225 kernel: usb usb1: SerialNumber: 0000:00:1d.0
Nov 11 09:27:41 scyw00225 kernel: parport: PnPBIOS parport detected.
Nov 11 09:27:41 scyw00225 kernel: usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
Nov 11 09:27:41 scyw00225 kernel: usb usb2: SerialNumber: 0000:00:1d.1
Nov 11 09:27:41 scyw00225 kernel: usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
Nov 11 09:27:41 scyw00225 kernel: usb usb3: SerialNumber: 0000:00:1d.2
Nov 11 09:27:41 scyw00225 kernel: usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
Nov 11 09:27:41 scyw00225 kernel: usb usb4: SerialNumber: 0000:00:1d.7
Nov 11 09:27:41 scyw00225 kernel: usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=0
Nov 11 09:27:41 scyw00225 kernel: ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
Nov 11 09:27:41 scyw00225 kernel: ieee1394: sbp2: Try serialize_io=0 for better performance
Nov 11 09:27:47 scyw00225 kernel: ttyS0: LSR safety check engaged!
Nov 11 09:27:48 scyw00225 kernel: ttyS2: LSR safety check engaged!


The port in question is ttyS0.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
