Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbRBHQjY>; Thu, 8 Feb 2001 11:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129947AbRBHQjO>; Thu, 8 Feb 2001 11:39:14 -0500
Received: from prah01-a07-as158.ctt.cz ([194.108.177.158]:29700 "EHLO
	darkraider.hell") by vger.kernel.org with ESMTP id <S129846AbRBHQjA>;
	Thu, 8 Feb 2001 11:39:00 -0500
Date: Thu, 8 Feb 2001 17:38:40 +0100
From: ViNiL <vinil@chl.cz>
To: linux-kernel@vger.kernel.org
Subject: serial problems
Message-ID: <20010208173840.A5608@darkraider>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Switching from kernel 2.2.18 to 2.4.0 I found that my serial ports work no
more. And while using serial mouse it is quite ugly situation.

Some infos:
- QDI PII440BX B-1 motherboard
- 2 COMs + 1 internal modem -> requested state:
/dev/ttyS0 at 0x03f8 (irq = 4) is a 16550A
/dev/ttyS1 at 0x02f8 (irq = 11) is a 16550A
/dev/ttyS2 at 0x03e8 (irq = 10) is a 16550A

(irq 3 uses network card :-)

I set above settings in BIOS (because I wasn't able to setup all these
things using Linux's PnP capabilities).

Both kernels make the detection same (wrong :-) way. Let's see:

2.2.18:
Serial driver version 4.27 with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A

2.4.0:
Serial driver version 5.02 (2000-08-09) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ DETECT_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 11) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A

And after that, they are corrected by setserial. But only 2.2.18 works.
JFYI: I really try various options for configuring the serial module.

Can someone help me solving this problem?
Was there some bugfixing so 2.4.2 kernel should work better?
Are you missing some other info?

I attached a bit of syslog when the serial module was compiled with all debug
messages. I just load it, started gpm and tried to move mouse around....


ViNiL

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=out

Feb  5 22:47:15 darkraider kernel: Shutting down serial port 0 (irq 4)....<6>Serial driver version 5.02 (2000-08-09) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ DETECT_IRQ SERIAL_PCI ISAPNP enabled
Feb  5 22:47:15 darkraider kernel: Testing ttyS0 (0x03f8, 0x0000)...
Feb  5 22:47:15 darkraider kernel: Testing ttyS1 (0x02f8, 0x0000)...
Feb  5 22:47:15 darkraider kernel: Testing ttyS2 (0x03e8, 0x0000)...
Feb  5 22:47:15 darkraider kernel: serial: ttyS2: simple autoconfig failed (ff, ff)
Feb  5 22:47:15 darkraider kernel: Testing ttyS3 (0x02e8, 0x0000)...
Feb  5 22:47:15 darkraider kernel: serial: ttyS3: simple autoconfig failed (ff, ff)
Feb  5 22:47:15 darkraider kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Feb  5 22:47:15 darkraider kernel: ttyS01 at 0x02f8 (irq = 11) is a 16550A
Feb  5 22:47:15 darkraider kernel: Entered probe_serial_pci()
Feb  5 22:47:15 darkraider kernel: Leaving probe_serial_pci() (probe finished)
Feb  5 22:47:15 darkraider kernel: Setup PCI/PNP port: port 3e8, irq 4, type 0
Feb  5 22:47:15 darkraider kernel: Testing ttyS2 (0x03e8, 0x0000)...
Feb  5 22:47:15 darkraider kernel: ttyS02 at port 0x03e8 (irq = 4) is a 16550A
Feb  5 22:47:15 darkraider kernel: rs_open ttyS0, count = 1
Feb  5 22:47:15 darkraider kernel: starting up ttys0 (irq 4)...rs_open ttys0 successful...rs_interrupt_single(4)...status = f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...CTS tx stop...end.
Feb  5 22:47:25 darkraider kernel: rs_interrupt_single(4)...status = fb...DR00:fb...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...end.
Feb  5 22:47:35 darkraider kernel: rs_interrupt_single(4)...status = 60...end.
Feb  5 22:47:45 darkraider kernel: rs_interrupt_single(4)...status = fb...DR00:fb...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...DR00:f9...end.
Feb  5 22:47:55 darkraider kernel: rs_interrupt_single(4)...status = 60...end.
Feb  5 22:48:15 darkraider last message repeated 2 times
Feb  5 22:48:24 darkraider kernel: rs_close ttys0, count = 1
Feb  5 22:48:25 darkraider kernel: rs_interrupt_single(4)...status = 60...THRE...end.
Feb  5 22:48:35 darkraider kernel: rs_interrupt_single(4)...status = f9...DR00:f9...DR80:e1...DR00:f9...DR80:e1...DR00:f9...DR80:e1...DR00:f9...DR80:e1...DR00:f9...DR80:e1...DR00:f9...DR80:e1...DR00:f9...THRE...end.
Feb  5 22:48:45 darkraider kernel: rs_interrupt_single(4)...status = e1...DR80:e1...DR00:f9...DR80:e1...DR00:f9...DR80:e1...DR00:f9...DR80:e1...DR00:f9...DR80:e1...DR00:f9...DR80:e1...DR00:f9...THRE...end.
Feb  5 22:48:45 darkraider kernel: In rs_wait_until_sent(6) check=1...jiff=30009...lsr = 0 (jiff=30009)...lsr = 96 (jiff=30010)...done
Feb  5 22:48:45 darkraider kernel: In rs_wait_until_sent(3) check=1...jiff=30010...lsr = 96 (jiff=30010)...done
Feb  5 22:49:45 darkraider kernel: Shutting down serial port 0 (irq 4)....rs_open ttyS1, count = 1
Feb  5 22:49:45 darkraider kernel: starting up ttys1 (irq 11)...rs_open ttys1 successful...rs_close ttys1, count = 1
Feb  5 22:49:45 darkraider kernel: In rs_wait_until_sent(6) check=1...jiff=36078...lsr = 96 (jiff=36078)...done
Feb  5 22:49:45 darkraider kernel: In rs_wait_until_sent(3) check=1...jiff=36078...lsr = 96 (jiff=36078)...done
Feb  5 22:49:45 darkraider kernel: Shutting down serial port 1 (irq 11)....rs_open ttyS2, count = 1
Feb  5 22:49:45 darkraider kernel: starting up ttys2 (irq 4)...rs_open ttys2 successful...Shutting down serial port 2 (irq 4)....starting up ttys2 (irq 10)...rs_close ttys2, count = 1

--XsQoSWH+UP9D9v3l--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
