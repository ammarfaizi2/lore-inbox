Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130543AbRCDWnW>; Sun, 4 Mar 2001 17:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130544AbRCDWnM>; Sun, 4 Mar 2001 17:43:12 -0500
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:8981 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S130543AbRCDWnA>; Sun, 4 Mar 2001 17:43:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Georg Wittenburg <georg.wittenburg@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: sundance driver problem detecting DFE-550 card
Date: Sun, 4 Mar 2001 23:43:12 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01030423431200.00666@barclay.hal.tf>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

I contacted Donald Becker (mainainer of sundance driver according to the 
comments) about this issue who told me that he wasn't in charge of the 2.4 
driver anymore and suggested to ask on the list.

My vanilla Linux 2.4.2 system has some trouble using the D-Link DFE-550TX
network adapter with the sundance driver that should support that card
according to the docs .

Until now I've used the dlh5x driver right from the D-Link homepage, but that
doesn't compile with Linux 2.4 and seems to be rather unsupported.

The symptoms are: sundance.c compiles to a module and is loaded over the
normal init scripts without problems. However asking for a "ping 192.168.1.1"
(our local server) doesn't yield anything (switching back to the old 2.2.17
kernel and dlh5x works). Furthermore, the ifconfig statistics remain empty
and also ifconfig reports a different base address than when using the old 
dlh5x driver. Also note the different memory addresses reported in /proc/pci.

I've gathered the following info which I hope will help track down the
problem:

ifconfig under 2.4.2 and sundance:

eth0      Link encap:Ethernet  HWaddr 00:50:BA:0F:5E:DD
          inet addr:192.168.1.2  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:5 Base address:0xf000

/proc/pci under 2.4.2 and sundance:

  Bus  0, device  10, function  0:
    Ethernet controller: PCI device 1186:1002 (D-Link System Inc) (rev 0).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0xa400 [0xa47f].
      Non-prefetchable 32 bit memory at 0xd4800000 [0xd480007f].

ifconfig under 2.2.17 and dlh5x:

eth0      Link encap:Ethernet  HWaddr 00:50:BA:0F:5E:DD
          inet addr:192.168.1.2  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:737286 errors:2868 dropped:2868 overruns:0 frame:0
          TX packets:118998 errors:2880 dropped:0 overruns:0 carrier:1968
          collisions:5760 txqueuelen:100
          Interrupt:5 Base address:0x6000

/proc/pci under 2.2.17and dlh5x:

  Bus  0, device  10, function  0:
    Ethernet controller: Unknown vendor Unknown device (rev 0).
      Vendor id=1186. Device id=1002.
      Medium devsel.  IRQ 5.  Master Capable.  Latency=32.  Min Gnt=10.Max
Lat=10.
      I/O at 0xa400 [0xa401].
      Non-prefetchable 32 bit memory at 0xd4800000 [0xd4800000].

More (lengthy) output of Donald Becker's debugging tool (alta-diag) is 
available.

I'm not subscribed to the list, so please send me a CC. Thanks for your help.

Yours,
	Georg
