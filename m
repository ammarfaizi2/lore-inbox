Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSHNWmd>; Wed, 14 Aug 2002 18:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSHNWmd>; Wed, 14 Aug 2002 18:42:33 -0400
Received: from imo-r05.mx.aol.com ([152.163.225.101]:10209 "EHLO
	imo-r05.mx.aol.com") by vger.kernel.org with ESMTP
	id <S315760AbSHNWmc>; Wed, 14 Aug 2002 18:42:32 -0400
Date: Wed, 14 Aug 2002 18:43:33 -0400
From: JosMHinkle@netscape.net
To: linux-kernel@vger.kernel.org
Subject: Linux kernel 2.4.19 failure to access a serial port
Message-ID: <79B43166.1160898F.0BD32098@netscape.net>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: In an i586 system with two serial ports and a modem,
Linux fails to access the modem

Slight expansion: A system with two serial ports on ttyS0 and ttyS1
and a hardware modem on ttyS2 was not serviced properly in kernel
2.4.19 and some earlier ones.  The modem at ttyS2 was fairly well
ignored.  The interrupt requests used were ttyS0:irq4 ttyS1:irq3
ttyS2:irq10

Temporary fix:
   In drivers/char/serial.c at the directive "#ifdef CONFIG_PCI"
the assumption is made that interrupt requests are shared and
there are more than four serial ports.  That is not necessarily
true, and the directives defeat the options set in configuration.
   The solution here was to comment out #define CONFIG_SERIAL_SHARE_IRQ
and CONFIG_SERIAL_MANY_PORTS and recompile.

#ifdef CONFIG_PCI
#define ENABLE_SERIAL_PCI
/*** Commented out to allow unshared IRQ's on ttyS0-ttyS3
#ifndef CONFIG_SERIAL_SHARE_IRQ
#define CONFIG_SERIAL_SHARE_IRQ
#endif
#ifndef CONFIG_SERIAL_MANY_PORTS
#define CONFIG_SERIAL_MANY_PORTS
#endif
***/
#endif

   It seems a more sophisticated judgement needs to be made, and
perhaps simply following the directions of the configurer would be
advisable, in that these two items are made specifically available
in configuration, and should not be silently bypassed.

Note: I have been informed the mailer here does not break lines as
shown on the screen.  I hope this message turned out better.  It is
purposely reposted so the viewer doesn't have to deal with the 
unbroken line version






__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/

