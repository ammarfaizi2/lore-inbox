Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273702AbRI3QFo>; Sun, 30 Sep 2001 12:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273701AbRI3QFY>; Sun, 30 Sep 2001 12:05:24 -0400
Received: from [212.113.174.249] ([212.113.174.249]:14115 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S273703AbRI3QFV>;
	Sun, 30 Sep 2001 12:05:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ricardo Ferreira <stormlabs@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Poor 8139 network card performance when sharing IRQ
Date: Sun, 30 Sep 2001 17:05:25 +0100
X-Mailer: KMail [version 1.3.5]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <EXCH02SMTP02UR7BED00000751b@smtp.netcabo.pt>
X-OriginalArrivalTime: 30 Sep 2001 16:03:17.0716 (UTC) FILETIME=[6B195140:01C149C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual p3-1Ghz on a Abit VP6 board. Everything is working well except 
the network card. I have some nfs mounts and i'm using 4096 wsize and rsize 
for performance. However when eth0 and any other card are sharing an IRQ the 
result of a ping to the server with a packetsize of 4096 is this:

$ ping -s 4096 fs
PING loki.internal (192.168.0.40): 4096 data bytes
4104 bytes from 192.168.0.40: icmp_seq=0 ttl=255 time=1.6 ms
4104 bytes from 192.168.0.40: icmp_seq=1 ttl=255 time=283.5 ms
4104 bytes from 192.168.0.40: icmp_seq=2 ttl=255 time=755.3 ms
4104 bytes from 192.168.0.40: icmp_seq=3 ttl=255 time=2.1 ms
4104 bytes from 192.168.0.40: icmp_seq=4 ttl=255 time=1.6 ms
4104 bytes from 192.168.0.40: icmp_seq=5 ttl=255 time=2.1 ms
4104 bytes from 192.168.0.40: icmp_seq=6 ttl=255 time=1.8 ms
4104 bytes from 192.168.0.40: icmp_seq=7 ttl=255 time=284.1 ms
4104 bytes from 192.168.0.40: icmp_seq=8 ttl=255 time=2.0 ms
4104 bytes from 192.168.0.40: icmp_seq=9 ttl=255 time=284.4 ms
4104 bytes from 192.168.0.40: icmp_seq=10 ttl=255 time=2.0 ms
4104 bytes from 192.168.0.40: icmp_seq=11 ttl=255 time=2.2 ms
4104 bytes from 192.168.0.40: icmp_seq=12 ttl=255 time=754.9 ms
4104 bytes from 192.168.0.40: icmp_seq=13 ttl=255 time=283.7 ms
4104 bytes from 192.168.0.40: icmp_seq=14 ttl=255 time=391.9 ms
 
--- loki.internal ping statistics ---
15 packets transmitted, 15 packets received, 0% packet loss
round-trip min/avg/max = 1.6/203.5/755.3 ms

... but if i remove the other card (in this case a Miro Video TV Card) the 
ping times all drop to about 2ms. 

Is this drop in performance normal or is it a bug ? As an aside, anything 
lower than 1024 packetsize doesn't slowdown.

Thanks
-- 
[------------------------------------------------][-------------------------]
|"One World, One Web, One Program" - Microsoft Ad||    stormlabs@gmx.net    |
|"Ein Volk, Ein Reich, Ein Fuhrer" - Adolf Hitler||http://storm.superzip.net|
[------------------------------------------------][-------------------------]
       --> thor up 2 days | sentinel up 59 days | loki up 59 days <--
