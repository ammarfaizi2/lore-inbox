Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbRCJVVB>; Sat, 10 Mar 2001 16:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131157AbRCJVUv>; Sat, 10 Mar 2001 16:20:51 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:8426 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S131063AbRCJVUj>; Sat, 10 Mar 2001 16:20:39 -0500
Date: Sat, 10 Mar 2001 15:19:48 -0600 (CST)
From: sidewinder <sidewinder@usa.net>
Subject: NFS times out with 2.4.2 as client
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.30.0103101500080.22174-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I built 2.4.2 to experiment with it. So far, I can't get it to mount an
nfs share without timing out. The nfs server, in this case, is running
2.2.17. There are no problems mounting the share when I revert to the old
kernel, 2.2.16, on the client machine.

Other than that there's nothing special about the setup. The connection
occurs across the LAN. Apparently although the server recognizes the
client packets, its answers are not understood by the client, which tries
different ports. Eventually, the client reports a timeout, but in fact the
share is successfully mounted.

I've tried a number of solutions, including a newer version of mount,
adding nolock to the options line, and also vers=2. Ver3 is not selected
in the 2.4.2 kernel, indidentally. At first I suspected the firewall, but
the same results happen when the fw is down.

The only entries in the kernel log say, portmap: server not
responding. During this time the terminal on which the commands are
entered won't respond to input (you can open up another connection
remotely).

Here's a typical entry from tcpdump, from the server's point of view.
192.168.1.1 is the client, 192.168.1.10 is the server.

tcpdump: listening on eth0
11:32:24.958338 localhost.localdomain.631 > 192.168.1.255.631: udp 124
11:32:55.958333 localhost.localdomain.631 > 192.168.1.255.631: udp 124
11:32:56.736047 arp who-has localhost.localdomain tell 192.168.1.1
11:32:56.736083 arp reply localhost.localdomain is-at 0:0:e8:35:77:ae
11:32:56.736615 192.168.1.1.745 > localhost.localdomain.sunrpc: S
1160224917:1160224917(0) win 5840 <mss 1460,sackOK,timestamp 15251[|tcp]> (DF)
11:32:56.736772 localhost.localdomain.sunrpc > 192.168.1.1.745: S
980802949:980802949(0) ack 1160224918 win 32120 <mss
1460,nop,nop,sackOK,nop,wscale 0> (DF)
11:32:56.737386 192.168.1.1.745 > localhost.localdomain.sunrpc: . ack 1 win
5840 (DF)
11:32:56.738109 192.168.1.1.745 > localhost.localdomain.sunrpc: P 1:45(44) ack
1 win 5840 (DF)
11:32:56.738152 localhost.localdomain.sunrpc > 192.168.1.1.745: . ack 45 win
32120 (DF)
11:32:56.738412 localhost.localdomain.sunrpc > 192.168.1.1.745: P 1:293(292)
ack 45 win 32120 (DF)
11:32:56.738692 localhost.localdomain.1051 > 151.164.1.8.domain: 52408+ (42)
11:32:56.739497 192.168.1.1.745 > localhost.localdomain.sunrpc: . ack 293 win
6432 (DF)
11:32:56.740010 192.168.1.1.745 > localhost.localdomain.sunrpc: F 45:45(0) ack
293 win 6432 (DF)
11:32:56.740041 localhost.localdomain.sunrpc > 192.168.1.1.745: . ack 46 win
32120 (DF)
11:32:56.740137 localhost.localdomain.sunrpc > 192.168.1.1.745: F 293:293(0)
ack 46 win 32120 (DF)
11:32:56.740779 192.168.1.1.745 > localhost.localdomain.sunrpc: . ack 294 win
6432 (DF)
11:32:56.741604 192.168.1.1.746 > localhost.localdomain.1026: udp 144 (DF)
11:32:56.742060 localhost.localdomain.1026 > 192.168.1.1.746: udp 60
11:32:56.743109 192.168.1.1.748 > localhost.localdomain.sunrpc: udp 56 (DF)
11:32:56.743255 localhost.localdomain.sunrpc > 192.168.1.1.748: udp 28
11:32:56.745189 192.168.1.1.2121638 > localhost.localdomain.nfs: 152 getattr
[|nfs] (DF)
11:32:56.745254 localhost.localdomain.nfs > 192.168.1.1.2121638: reply ok 96
getattr [|nfs]11:32:56.746302 192.168.1.1.18898854 >
localhost.localdomain.nfs: 152 statfs [|nfs] (DF)
11:32:56.746375 localhost.localdomain.nfs > 192.168.1.1.18898854: reply ok 48
statfs [|nfs]11:33:01.748311 localhost.localdomain.1051 > 151.164.1.7.domain:
52408+ (42)
11:33:51.778238 arp who-has 192.168.1.1 tell localhost.localdomain
11:33:51.778738 arp reply 192.168.1.1 is-at 0:0:e8:35:7e:51
11:33:55.078917 0:20:78:d:3d:ce > 3:0:0:0:0:1 sap f0 ui/C len=169
                         2c00 ffef 0800 0000 0000 0000 0102 5f5f
                         4d53 4252 4f57 5345 5f5f 0201 5241 4242
                         4954 2020 2020 2020 2020 2000 ff53 4d42
                         2500 00

The rest is more of the same, or other traffic.

Any one have similar problems? I've tried recompiling 2.4.2, thinking I
might have missed something. No change.

Perplexed.

-Alex

