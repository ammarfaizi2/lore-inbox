Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131200AbQKZAm7>; Sat, 25 Nov 2000 19:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130996AbQKZAmu>; Sat, 25 Nov 2000 19:42:50 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:19689 "EHLO
        altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
        id <S131200AbQKZAmk>; Sat, 25 Nov 2000 19:42:40 -0500
Date: Sun, 26 Nov 2000 00:55:38 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11 af_packet/tcpdump/routing bug?
Message-ID: <20001126005538.A10587@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The tcpdump program (tcpdump -p -i ppp1 -s 1500 not port login) will
not report any packets after adding a default route to eth0 in the setup
below. The packet generating command is ping 192.168.2.42

It has been verified at the ppp1 peer that packets really arrive there via
ppp. Tcpdumping eth0 locally also confirms that packets don't go via eth0.

After adding/deleting the default route tcpdump needs to be restarted
to notice the difference. It uses the af_packet kernel module and maybe
its usage count must drop to zero temporarily to make a difference (I
don't know).

iapetus ~# route                     
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.2.42    *               255.255.255.255 UH    0      0        0 ppp1
192.168.0.39    *               255.255.255.255 UH    0      0        0 eth0
192.168.2.0     *               255.255.255.0   U     0      0        0 eth0
localnet        *               255.255.255.0   U     0      0        0 eth0
loopback        *               255.0.0.0       U     0      0        0 lo
iapetus ~# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:50:04:21:99:04  
          inet addr:192.168.0.39  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:34216 errors:0 dropped:0 overruns:0 frame:0
          TX packets:52668 errors:0 dropped:0 overruns:0 carrier:5
          collisions:117 txqueuelen:100 
          Interrupt:10 Base address:0x300 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16144  Metric:1
          RX packets:16037 errors:0 dropped:0 overruns:0 frame:0
          TX packets:16037 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 

ppp1      Link encap:Point-to-Point Protocol  
          inet addr:192.168.2.201  P-t-P:192.168.2.42  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:331 errors:0 dropped:0 overruns:0 frame:0
          TX packets:330 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3 

Adding a default route:
iapetus ~# route add default dev eth0
iapetus ~# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.2.42    *               255.255.255.255 UH    0      0        0 ppp1
192.168.0.39    *               255.255.255.255 UH    0      0        0 eth0
192.168.2.0     *               255.255.255.0   U     0      0        0 eth0
localnet        *               255.255.255.0   U     0      0        0 eth0
loopback        *               255.0.0.0       U     0      0        0 lo
default         *               0.0.0.0         U     0      0        0 eth0

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
