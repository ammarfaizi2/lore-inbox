Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRAONmu>; Mon, 15 Jan 2001 08:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130219AbRAONmk>; Mon, 15 Jan 2001 08:42:40 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:57811 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129523AbRAONmf>; Mon, 15 Jan 2001 08:42:35 -0500
Message-ID: <3A62FE09.F33DEB35@home.com>
Date: Mon, 15 Jan 2001 08:41:29 -0500
From: John Cavan <johncavan@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Networking strangeness 2.4.0-ac9 and earlier
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've seen this for a while... the output from netstat and ifconfig do
not agree on the MTU of the device:

[root@lion /root]# netstat -r
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt
Iface
10.1.11.0       *               255.255.255.0   U        40 0          0
eth0
127.0.0.0       *               255.0.0.0       U        40 0          0
lo
default         spqr            0.0.0.0         UG       40 0          0
eth0

[root@lion /root]# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:10:4B:2B:12:80  
          inet addr:10.1.11.76  Bcast:10.1.11.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3648 errors:77 dropped:0 overruns:0 frame:144
          TX packets:3863 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:11 Base address:0xd800 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16192  Metric:1
          RX packets:139 errors:0 dropped:0 overruns:0 frame:0
          TX packets:139 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 

AFAIK, the MSS value should be about 40 less than the MTU, not 40,
though on other Linux boxes I have, the MSS column from netstat shows 0
(both of them are 2.2 kernels and single proc machines). This machine is
a dual P3-500 with 512mb of RAM and a 3COM 3c905 card. I understand that
the MSS column should actually read the MTU, but I don't know if that is
the case. Either way cat /proc/net/route shows:

Iface   Destination     Gateway         Flags   RefCnt  Use     Metric 
Mask     MTU     Window 
IRTT                                                       
eth0    000B010A        00000000        0001    0       0       0      
00FFFFFF 40      0      
0                                                                              
lo      0000007F        00000000        0001    0       0       0      
000000FF 40      0      
0                                                                                
eth0    00000000        FE0B010A        0003    0       0       0      
00000000 40      0       0

One of the things that seem to be symptomatic of the problem is web
browsing to my Ultra 5 (Solaris 2.6 with recommended patches). A single
web page can take several minutes to load with all images on my local
LAN, but on the other Linux machines, it blows in before you can blink
(as would be expected). Similar behaviour can be seen browsing against
other Linux machines as well, though not as bad. Other network protocols
are slower as well (FTP, telnet), though not once it gets through the
firewall, oddly enough.

Any help appreciated.

Thanks,
John
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
