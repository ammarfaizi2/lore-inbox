Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130347AbQKGCRr>; Mon, 6 Nov 2000 21:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130577AbQKGCRg>; Mon, 6 Nov 2000 21:17:36 -0500
Received: from 64.124.41.10.napster.com ([64.124.41.10]:52228 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S130347AbQKGCRZ>; Mon, 6 Nov 2000 21:17:25 -0500
Message-ID: <3A07662F.39D711AE@napster.com>
Date: Mon, 06 Nov 2000 18:17:19 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are seeing a performance slowdown between Windows PPP users and
servers running 2.4.0-test10. Attached is a tcpdump log of the
connection. The machines is without TCP ECN support. The Windows machine
is running Windows 98 SE 4.10.2222 A dialed up over PPP w/ TCP header
compression. The Linux machine is connected directly to the Internet via
a 6509. There is a possibility that we are hitting a bandwidth cap on
outgoing traffic.


18:51:33.282286 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: S
3013389:3013389(0) win 8192 <mss 536,nop,nop,sackOK> (DF)
18:51:33.282395 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: S
2198113890:2198113890(0) ack 3013390 win 5840 <mss 1460,nop,nop,sackOK>
(DF)
18:51:33.509532 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: .
1:1(0) ack 1 win 8576 (DF)
18:51:33.510360 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: .
1:1(0) ack 1 win 65280 (DF)
18:51:33.510416 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: P
1:44(43) ack 1 win 65280 (DF)
18:51:33.510457 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: .
1:1(0) ack 44 win 5840 (DF)
18:51:33.988330 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
1:21(20) ack 44 win 5840 (DF)
18:51:33.988474 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
21:557(536) ack 44 win 5840 (DF)
18:51:36.987336 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
1:21(20) ack 44 win 5840 (DF)
18:51:37.177772 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: P
44:56(12) ack 21 win 65260 (DF)
18:51:37.177794 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
21:557(536) ack 44 win 5840 (DF)
18:51:37.177806 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
557:1093(536) ack 56 win 5840 (DF)
18:51:39.845046 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: P
44:456(412) ack 21 win 65260 (DF)
18:51:39.845071 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: .
1093:1093(0) ack 456 win 6432 <nop,nop, sack 1 {44:56} > (DF)
18:51:43.177329 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
21:557(536) ack 456 win 6432 (DF)
18:51:43.538219 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: .
456:456(0) ack 557 win 65280 (DF)
18:51:43.538275 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
557:1093(536) ack 456 win 6432 (DF)
18:51:43.538292 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
1093:1629(536) ack 456 win 6432 (DF)
18:51:55.537346 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
557:1093(536) ack 456 win 6432 (DF)
18:51:55.841360 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: .
456:456(0) ack 1093 win 65280 (DF)
18:51:55.841384 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
1093:1629(536) ack 456 win 6432 (DF)
18:51:55.841393 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
1629:1849(220) ack 456 win 6432 (DF)
18:52:19.837335 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
1093:1629(536) ack 456 win 6432 (DF)
18:52:20.153776 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: .
456:456(0) ack 1629 win 65280 (DF)
18:52:20.153803 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
1629:1849(220) ack 456 win 6432 (DF)
18:53:08.147334 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
1629:1849(220) ack 456 win 6432 (DF)
18:53:08.475911 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: .
456:456(0) ack 1849 win 65060 (DF)
18:53:08.475947 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
1849:1871(22) ack 456 win 6432 (DF)
18:54:44.467332 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
1849:1871(22) ack 456 win 6432 (DF)
18:54:44.824187 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: .
456:456(0) ack 1871 win 65038 (DF)
18:54:44.824256 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
1871:1893(22) ack 456 win 6432 (DF)
18:54:55.212750 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: P
456:506(50) ack 1871 win 65038 (DF)
18:54:55.212767 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: .
1893:1893(0) ack 506 win 6432 (DF)
18:54:55.571337 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: P
1893:2429(536) ack 506 win 6432 (DF)
18:54:57.394879 eth0 < 209.179.248.69.1238 > 64.124.41.177.8888: P
456:506(50) ack 1871 win 65038 (DF)
18:54:57.394894 eth0 > 64.124.41.177.8888 > 209.179.248.69.1238: .
2429:2429(0) ack 506 win 6432 <nop,nop, sack 1 {456:506} > (DF)


Here are some numbers from /proc/sys/net/ipv4:

$ cat /proc/sys/net/ipv4/tcp_rmem
4096	87380	174760

$ cat /proc/sys/net/ipv4/tcp_wmem 
4096	16384	131072

$ cat /proc/sys/net/ipv4/tcp_sack
1

$ cat /proc/sys/net/ipv4/tcp_fack
1

$ cat /proc/sys/net/ipv4/tcp_dsack
1

$ cat /proc/sys/net/ipv4/tcp_window_scaling 
1

$ cat /proc/sys/net/ipv4/tcp_syncookies     
0

$ cat /proc/sys/net/ipv4/tcp_timestamps 
1



Jordan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
