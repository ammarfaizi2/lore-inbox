Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317708AbSHPG5w>; Fri, 16 Aug 2002 02:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSHPG5w>; Fri, 16 Aug 2002 02:57:52 -0400
Received: from imo-d04.mx.aol.com ([205.188.157.36]:27309 "EHLO
	imo-d04.mx.aol.com") by vger.kernel.org with ESMTP
	id <S317708AbSHPG5v>; Fri, 16 Aug 2002 02:57:51 -0400
Date: Fri, 16 Aug 2002 03:01:45 -0400
From: JosMHinkle@netscape.net
To: linux-kernel@vger.kernel.org
Subject: Linux kernel 2.4.19 failure to access a serial port
Message-ID: <257D72E0.2F5D0681.0BD32098@netscape.net>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: In an i586 system with two serial ports and a modem,
Linux fails to access the modem

IRQ 3 and 4 are used by ttyS1 and ttyS0, and IRQ 10 is used by the modem.
There are no conflicts.

I previously mentioned disabling CONFIG_SERIAL_SHARE_IRQ in serial.c
to make it work. (The disabling of CONFIG_SERIAL_MANY_PORTS is an
artifact of no importance).

Stuart, you suggest:
> "This fix breaks the driver in a fundamental way. SHARE_IRQ and
> MANY_PORTS are turned on if CONFIG_PCI is on because a) pci drivers 
> *must* share interrrupts and b) generally serial ports that are behind 
> a pci bus are multiport boards."

CONFIG_PCI must be on because the video card is on that bus.  There is no
conflict between that and the serial ports.

How can this "break the driver in a fundamental way?" This is not
a system that "generally has a multiport board", it is a specific
machine that specifically does not have a multiport board.  To try
to configure it as if it might because some other machines do is just stupid.  I am sure there are many other machines built just like it in
this way, two serial ports and a plugin hardware modem card.

The consideration that the PCI drivers must share interrupts does not
apply here because this patch to make Linux work on this machine is
only in serial.c, nowhere else, and besides, on this system there seems
to be no interrupt sharing elsewhere; correct me if I'm wrong.  The four
items on the PCI bus are:
Host bridge: Silicon Integrated Systems [SiS] 5571
ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
VGA compatible controller: S3 Inc. 86c775/86c785 [Trio 64V2/DX]

Perhaps the IDE controllers share an interrupt, but that is hardly
anything near serial.c

Again, it is very poor practice to offer a configuration item which is 
needed on a system only to silently defeat it internally because "some
systems need that".  I had to waste several days to discover this and
fix it.  If I were not technically adept enough to do it, I would simply
have told the customer that "Linux cannot be installed on your machine".




__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/

