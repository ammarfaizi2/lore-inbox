Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316832AbSGBRkt>; Tue, 2 Jul 2002 13:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSGBRks>; Tue, 2 Jul 2002 13:40:48 -0400
Received: from w007.z208177141.sjc-ca.dsl.cnc.net ([208.177.141.7]:64954 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S316832AbSGBRkr>;
	Tue, 2 Jul 2002 13:40:47 -0400
Subject: 3Com 3c905C Tornado (newish 2.4.x) improper frame processing
From: Dax Kelson <dax@GuruLabs.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Jul 2002 11:43:15 -0600
Message-Id: <1025631796.8314.43.camel@porthos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A frame with a destination address of FF:00:00:00:00:00 shouldn't be
processed, unless the card has been told to listen to that multicast
address.

Driver/Card information:
-------------------
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:10.0: 3Com PCI 3c905C Tornado at 0xe000. Vers LK1.1.1600:10.0 
3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
-------------------

I tried:

# ifconfig eth0 -mulicast

And STILL the frame was processed.

The linux/drivers/net/3c59x.c has this comment:

/* Pre-Cyclone chips have no documented multicast filter, so the only
   multicast setting is to receive all multicast frames.  At least
   the chip has a very clean way to set the mode, unlike many others. */

However, this card is Tornado, the latest rev, so this comment shouldn't
apply. 

The families go: Vortex -> Boomerang -> Cyclone -> Tornado

Also, I tried using the latest Donald Becker driver with the same
results:

(dmesg output from latest Donald Becker driver)

3c59x.c:v0.99X 6/21/2002 Donald Becker, becker@scyld.com
  http://www.scyld.com/network/vortex.html
eth0: 3Com 3c905C Tornado at 0xe000,  00:01:03:de:57:37, IRQ 7
  8K buffer 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Using bus-master transmits and whole-frame receives.



