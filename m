Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319182AbSHNDqH>; Tue, 13 Aug 2002 23:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319183AbSHNDqH>; Tue, 13 Aug 2002 23:46:07 -0400
Received: from imo-d05.mx.aol.com ([205.188.157.37]:34552 "EHLO
	imo-d05.mx.aol.com") by vger.kernel.org with ESMTP
	id <S319182AbSHNDqH>; Tue, 13 Aug 2002 23:46:07 -0400
Date: Tue, 13 Aug 2002 23:49:03 -0400
From: JosMHinkle@netscape.net
To: linux-kernel@vger.kernel.org
Subject: Linux kernel 2.4.19 failure to access a serial port
Message-ID: <380543EF.54D883E4.0BD32098@netscape.net>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: In an i586 system with two serial ports and a modem, Linux fails to access the modem

Expansion: The system is a 233MHz Pentium Mmx in a board called "P5SV-B" manufacurer unknown.  There are two serial ports available with the mouse using one (ttyS0).  The Rockwell K56Flex modem is installed to use ttyS2 and IRQ 10, set by PnP.  The reason for this is Windows is run on the machine at times, and is the only arrangement it will accept, so the same configuration was intended to be used when Linux was run.  Indeed, when kernel 2.2.21 was used, there was no problem.
The kernel was originally configured without support for sharing interrupts  since none were shared.
  However, the symptoms are strings sent to the modem might or might not reach it, and when they do, they come in 16 byte segments about once every 30 seconds.  I understand that is typical behaviour when interrupts are shared, and indeed when the serial driver becomes active on bootup, the annunciation is "Serial driver version 5.05c with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled" whether or not those were selected in the configuration before kernel compilation.
  Initially /dev/ttyS2 is reported as using IRQ4 on bootup even though the isapnp.conf directs it to be IRQ10.  setserial is used later thus: "setserial /dev/ttyS2 irq 10 baud_base 115200 spd_normal skip_test".
   Curiously, with or without that, the modem responds the same way whether IRQ4 or IRQ10 is used after the isapnp software has allegedly set it to use IRQ10.
   /dev/ttyS0 (the mouse) and /dev/ttyS1 (a serial port ppp link) work perfectly well, and as mentioned, /dev/ttyS2 also worked perfectly well in a kernel 2.2.21 installation.
   Contents of /proc/tty/driver/serial:
0: uart:16550A port:3F8 irq:4 baud:1200 RTS|DTR
1: uart:16550A port:2F8 irq:3 baud:115200 RTS|CTS|DTR|DSR|CD
2: uart:16550A port:3E8 irq:10 baud:9600 CTS|DTR

Perhaps this is not a kernel issue, but one of PnP software, or something else.  I post this here because I have found precious little related to such a problem in my searches, and perhaps others have seen this and would benefit from a response here.

For what it's worth:
Gnu c 2.95.3
Gnu make 3.79.1
util-linux 2.11r
mount      2.11r
modutils   2.4.16
e2fsprogs  1.27
PPP        2.4.1
Linux C Library 2.5.so*
Dynamic linker (ldd) 2.2.5
Procps               2.0.7
Net-tools            1.6.0
Kbd                  command
Sh-utils             2.0
Modules loaded       bsd_comp opl3 opl3sa2 ad1848 mpu401 sound soundcore
                     ppp_deflate ppp_async ppp_generic slhc lp parport_pc                       parport
The sound system uses IRQ5 and the parallel port IRQ7




__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/

