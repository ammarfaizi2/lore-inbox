Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130887AbRAVCql>; Sun, 21 Jan 2001 21:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130916AbRAVCqb>; Sun, 21 Jan 2001 21:46:31 -0500
Received: from node121b3.a2000.nl ([24.132.33.179]:16000 "EHLO
	node121b3.a2000.nl") by vger.kernel.org with ESMTP
	id <S130887AbRAVCqR>; Sun, 21 Jan 2001 21:46:17 -0500
Message-ID: <3A6CF2EB.7EB23951@reviewboard.com>
Date: Tue, 23 Jan 2001 03:56:44 +0100
From: Chris Chabot <chabotc@reviewboard.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, tadavis@lbl.gov
Subject: Interface statistics for Bonding bug in 2.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded my main server to a 2.4 kernel (2.4.1pre9). This
machine uses 2 3Com 3C905B networkcards, bonded together (using the
bonding module).

When doing a 'ifconfig' the bond0 device shows 0 RX packets, and a valid
# of TX packets. However looking at eth0 / eth1 (the 2 network cards)
they have the just about the same amount of RX packets, so recieving
does apear to be balanced over the two interfaces.

When running this machine on 2.2.16 the interface it does show the
interface statistics accuratly. I also tested this on a clean 2.4.0
kernel, and it had the same bug.

The ifconfig output (note the 0 packets in bond0's RX)

bond0     Link encap:Ethernet  HWaddr 00:50:DA:B8:33:0F
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0

          UP BROADCAST RUNNING MASTER MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3655 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

eth0      Link encap:Ethernet  HWaddr 00:50:DA:B8:33:0F
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0

          UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metric:1
          RX packets:1992 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1828 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:11 Base address:0x9800

eth1      Link encap:Ethernet  HWaddr 00:50:DA:B8:33:0F
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0

          UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metric:1
          RX packets:1878 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1827 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:10 Base address:0x9400

Please CC me in any replies since im not subscribed to the kernel list.

    -- Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
