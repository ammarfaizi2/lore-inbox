Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbQKUOc7>; Tue, 21 Nov 2000 09:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130676AbQKUOct>; Tue, 21 Nov 2000 09:32:49 -0500
Received: from sirppi.helsinki.fi ([128.214.205.27]:8965 "EHLO
	sirppi.helsinki.fi") by vger.kernel.org with ESMTP
	id <S130645AbQKUOcd>; Tue, 21 Nov 2000 09:32:33 -0500
Date: Tue, 21 Nov 2000 16:02:28 +0200
From: Aki M Nyrhinen <anyrhine@cc.helsinki.fi>
To: linux-kernel@vger.kernel.org
Subject: D-Link DFE-530TX, via-rhine, drops interface when receiving fast
Message-ID: <20001121160228.A29050@sirppi.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The D-Link DFE530TX NIC, which is based on the VIA Rhine-II chip,
doesn't seem to work properly when receiving data fast. Sending isn't a
problem.

---
via-rhine.c:v1.08b-LK1.1.6  8/9/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xd400, 00:50:ba:f1:b5:d3, IRQ 10.
eth0: MII PHY found at address 8, status 0x7829 advertising 01e1 Link
      40a1.
---

when doing 'wget http://a-computer-on-the-same-hub/abt-1MB-file -O /dev/null'
I get the following on 2.4.0-test11 (and propably with all the other 
test-kernels):

---
Nov 21 15:37:02 FOO kernel: NETDEV WATCHDOG: eth0: transmit timed out
Nov 21 15:37:02 FOO kernel: eth0: Transmit timed out, status 0000, 
                            PHY status 782d, resetting...
---

and then it starts looping until something like 'ifconfig eth0 down;
sleep 10; ifconfig eth0 up; route add default gw ...' is done. 
in beetween the first message and the ifconfig-stuff, network is
completely unusable, which is quite annoying I don't happen to be on the
console.

the very same thing appears on 2.2 kernels with the becker's module from 
http://www.scyld.com/network/via-rhine.html, but without the
NETDEV_WATCHDOG-stuff.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
