Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTIIObd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbTIIObd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:31:33 -0400
Received: from alpha.tmit.bme.hu ([152.66.246.10]:34319 "EHLO alpha.ttt.bme.hu")
	by vger.kernel.org with ESMTP id S263893AbTIIObb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:31:31 -0400
Message-Id: <200309091428.h89ES0Oe015172@alpha.ttt.bme.hu>
From: "Horvath Gyorgy" <HORVAATH@tmit.bme.hu>
Organization: DTT_BUTE
To: linux-kernel@vger.kernel.org
Date: Tue, 9 Sep 2003 16:27:17 +0200
Subject: [ANNOUNCE] New hardware - SGA155D dual STM-1/OC3 PCI ad
X-mailer: Pegasus Mail v3.22
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

First, I would like to introduce a new harware -
SGA155D Dual STM-1/OC3 Telecommunications PCI Adapter.
You can obtain a short catalog from www.aitia.ai.
(www.aitia.ai/document/upload/200307/sga155.pdf)
I think it is a little bit expensive - but very flexy.
Errrr... actually the card was entirelly developed by me -
including the cores for the FPGA.
It is in low scale production, and working in the
fields well. Its current application is implemented for
DOS ;->

Second, I am going to turn to Linux, and I have decided to
write the driver(s) myself (huhh) under GPL.
It is turned out quickly, that I have some problems
at the very beginning of the development.

1. The new target application requires N pieces of SGA155D adapters
   for telephony application - multiple E1's carried in STM-1.
   Also, we need M additional pieces of SGA155D loaded with
   IP-Core for Packet-Over-SONET (WAN) application.
   Moreover - several hard-disks can be attached to the
   adapters for capture and playback application.

   As I see - SGA155D is a multifunction adapter in this context.
   Are there any driver model or technique for this situation?

   My guess is that I write a core driver for the hardware itself
   that can be compiled in the kernel (or can be modularized).
   This driver allows manipulating the IP-Core for the FPGA.
   Functional drivers are then modularized on demand.
   BTW Can I insmod other drivers from a kernel driver?
   Let say I have firstapp.o and firstapp.bin for the first
   three cards, and secondapp.o plus secondapp.bin for the rest.
   (.o is the driver and .bin is the IP-Core having the same
   filename) The core driver loads the IP-Core first, then loads
   the driver for that core. Hmmmm?

2. Packet over SONET...
   There were rumours about a Lucent card, and a driver for it -
   but I can't reach that now (a link to the void) - just
   for reference.
   What model shall I use - syncppp.o and my_driver.o - or
   I have to implement the ppp stuff entirelly in hardware
   - according to RFC's (I used to use RFC's and ITU-T's
   for cross compilation into VHDL :-).
   Is syncppp conforming RFC1619, RFC1662, RFC2615?
   I can't find notes on this in syncppp.c...

3. The telephony part is not yet clear for me.
   For the new application in question - there is not much to do
   in Linux, since the mass will be driven/sunk by the
   hard-disks.  But it might be useful elsewhere...
   Anyway - I will dig-up the Linux telephony project for advice
   before bothering this list.

4. Optionally - and if I have enough time - I'd like
   to develop a twin-linear filesystem driver for
   time-stamped capture/playback for multiple channels
   of data - like a multi-band magnetic tape.
   BTW do you know an existing one?


Best regards,


Gyorgy Horvath,        Technical University of Budapest
--------------         Dept. of Telecom. and Telematics

Tel.: +36-1-463-1865,  Fax.: +36-1-463-1865
Mail: horvaath@bme-tel.ttt.bme.hu
FTP:  ttt-pub.ttt.bme.hu  ./income
