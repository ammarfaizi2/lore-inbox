Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S316848AbSE1Q72>; Tue, 28 May 2002 12:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S316849AbSE1Q71>; Tue, 28 May 2002 12:59:27 -0400
Received: from blackhole.adamant.ua ([212.26.128.69]:62002 "EHLO blackhole.adamant.net") by vger.kernel.org with ESMTP id <S316848AbSE1Q70>; Tue, 28 May 2002 12:59:26 -0400
Date: Tue, 28 May 2002 19:59:18 +0300
From: Alexander Trotsai <mage@adamant.ua>
To: linux-kernel@vger.kernel.org
Subject: vlan dotQ vs 2.4.19pre8-ac5 vs big packets trouble
Message-ID: <20020528165918.GT1365@blackhole.adamant.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I try to use vlan with 2.4.19pre8-ac5 and
00:10.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M
[Tornado] (rev 74)
network card

I successfully setup vlan and got ping's (traffic)
But only with small packets

At main interface all work good
[root@watcher linux]# ping -s 1480 x.x.x.1
PING x.x.x.1 (x.x.x.1) from x.x.x.11 : 1480(1508) bytes of data.
1488 bytes from x.x.x.1: icmp_seq=1 ttl=255 time=6.93 ms
1488 bytes from x.x.x.1: icmp_seq=2 ttl=255 time=3.05 ms

--- x.x.x.1 ping statistics ---
2 packets transmitted, 2 received, 0% loss, time 1007ms
rtt min/avg/max/mdev = 3.056/4.993/6.930/1.937 ms

Vlan interface
[root@watcher linux]# ping -s 1480 x.x.x.242
PING x.x.x.242 (x.x.x.242) from x.x.x.244 : 1480(1508) bytes of data.

--- x.x.x.242 ping statistics ---
3 packets transmitted, 0 received, 100% loss, time 2017ms

Both pinged addresses in same subnet for approved interface
And vlan is work
[root@watcher linux]# ping -s 1400 x.x.x.242
PING x.x.x.242 (x.x.x.242) from x.x.x.244 : 1400(1428) bytes of data.
1408 bytes from x.x.x.242: icmp_seq=1 ttl=255 time=2.31 ms
1408 bytes from x.x.x.242: icmp_seq=2 ttl=255 time=1.79 ms

--- x.x.x.242 ping statistics ---
2 packets transmitted, 2 received, 0% loss, time 1010ms
rtt min/avg/max/mdev = 1.794/2.056/2.319/0.266 ms

I'm try to search information about this trouble found such
patch

# My 3C59X has MTU problems.

Edit the 3C59x.c, find the place where it says:

static const int mtu = 1500;
and replace 1500 with
static const int mtu = 1504;

but I got same trouble with this patch

-- 
Best regard, Alexander Trotsai aka MAGE-RIPE aka MAGE-UANIC
My PGP at ftp://blackhole.adamant.net/pgp/trotsai.key[.asc]
Big trouble - Post-it Note Sludge leaked into the monitor.
