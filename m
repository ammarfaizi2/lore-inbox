Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVG0Np1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVG0Np1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 09:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVG0Np1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 09:45:27 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:22118 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262242AbVG0NpY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 09:45:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=U5ZXfY/V627xiTq9SekBk3h8kGA/msjF2u5WN9CGRt1d9MhTx9bm8NaQLE6X2QLB2QzoWTawkIQBFmIpse4No4AK+qD5cOzRzHklQ6KmdyeQgGl02u8LLDgthRwZxYiAfy/G4F/3vCPp/ktEYiBi4JsQhij+5XsWnccKB9dHcAw=
Message-ID: <88e823ff0507270645613b1ca@mail.gmail.com>
Date: Wed, 27 Jul 2005 07:45:21 -0600
From: Brad Davis <enrock@gmail.com>
Reply-To: Brad Davis <enrock@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: US Robotics (Hardware) Modem Not Detected
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get a PCI-USRobotics Modem (Yes, it is a true hardware
modem) working on a G4 with Kernel version 2.6.10/2.6.11.

When I try to "modprobe 8250_pci". I get the following
error message:

WARNING: Error inserting 8250
(/lib/modules/2.6.10enrock.2/kernel/drivers/serial/8250.ko): No such
device
FATAL: Error inserting 8250_pci
(/lib/modules/2.6.10enrock.2/kernel/drivers/serial/8250_pci.ko):
Unknown symbol in module, or unknown parameter (see dmesg)

It looks to me like the 8250 module isn't recognizing the modem as a
seial port. The appropriate lines from dmesg are:

serial8250_init: nothing to do on PowerMac
8250_pci: Unknown symbol serial8250_unregister_port
8250_pci: Unknown symbol serial8250_resume_port
8250_pci: Unknown symbol serial8250_register_port
8250_pci: Unknown symbol serial8250_suspend_port

The "serial_core" module is correctly loaded as it shows up with a
lsmod. I get the same results whether I enable the PCI card (via
"setpci -d 12b9:1008 command=1") before the modprobe or not.

Everything looks good with lspci -vv (below). The card has an
allocated IO address (0x1020) and IRQ (53). It is disabled (I/O-), but
I understand the serial driver will enable it when it is found. There
are no /dev/ttyS* devices, but I also understand that these will be
created by the driver/udev system when the module has been correctly
loaded. I have tried manually creating a /dev/ttyS* file and then
tried to use setserial on it, but it complains.

I am currently dual-booting this machine with 2.4.X kernel and the
modem works fine there, so I guess something has changed in the new
2.6.X modules.

Output from lspci -vv:
0001:11:03.0 Serial controller: 5610 56K FaxModem 56K FaxModem Model
5610 (rev 01) (prog-if 02 [16550])
       Subsystem: 5610 56K FaxModem USR 56k Internal Voice Modem (Model 2976)
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
       Interrupt: pin A routed to IRQ 53
       Region 0: I/O ports at 1020 [disabled] [size=8]
       Capabilities: [dc] Power Management version 2
               Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold+)
               Status: D0 PME-Enable- DSel=0 DScale=2 PME-

Can someone point me in the right direction to get this card working
with the 2.6 kernel stream?

Thanks in advance for any help.

Brad
--
enrock@gmail.com
