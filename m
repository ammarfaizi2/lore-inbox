Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276135AbRJKM3j>; Thu, 11 Oct 2001 08:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276233AbRJKM33>; Thu, 11 Oct 2001 08:29:29 -0400
Received: from radium.jvb.tudelft.nl ([130.161.76.91]:41477 "HELO
	radium.jvb.tudelft.nl") by vger.kernel.org with SMTP
	id <S276135AbRJKM3T>; Thu, 11 Oct 2001 08:29:19 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: <linux-kernel@vger.kernel.org>
Subject: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
Date: Thu, 11 Oct 2001 14:29:56 +0200
Message-ID: <002001c15250$6fad3c50$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I can confirm that the known bug in the Intel EtherExpress Pro/100
adapter is still not worked around in recent kernels. The bug only
manifests itself when the card is operating on 10 Mbit half duplex. On
100 Mbit there are no problems. The problem is that after the device
received certain amount of traffic (between 80 and 130 Mb in my tests)
the device will lockup on new connections. Processes start to hang after
this and logging in is impossible. The only solution is to reset the
interface (using a previously logged in root session) and reboot the
system.

This is tested on :
Linus kernels:
	- 2.4.5
	- 2.4.10-pre2
	- 2.4.10
	- 2.4.11pre6
	- 2.4.11
	- 2.4.11 with eepro100.c from ac kernel 2.4.10ac11 (minor diffs)

Again, on 100 Mbit there are no more problems.

This is my relevant dmesg output:

eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:E8:A2:02, IRQ 17.
  Board assembly 749658-005, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xdbd8681d).

cat /proc/pci part:
  Bus  0, device  13, function  0:
    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
9).
      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xda020000 [0xda020fff].
      I/O at 0xc800 [0xc83f].
      Non-prefetchable 32 bit memory at 0xda000000 [0xda01ffff].

These are taken from the current setup on 100 Mbit.

Regards,
- Robbert Kouprie, System Administrator, The Netherlands

