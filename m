Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278678AbRJSWNR>; Fri, 19 Oct 2001 18:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278679AbRJSWNI>; Fri, 19 Oct 2001 18:13:08 -0400
Received: from 24-25-196-177.san.rr.com ([24.25.196.177]:59919 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S278678AbRJSWMx>;
	Fri, 19 Oct 2001 18:12:53 -0400
Date: Fri, 19 Oct 2001 15:13:26 -0700
From: andrew may <acmay@acmay.homeip.net>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com
Subject: 2.4.12 problems with routes
Message-ID: <20011019151326.A13503@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a strange problem in 2.4.12 that a ping from 
my machine 172.25.4.9 to 192.168.12.1 works but a 
ping the other way does not.

The ping going out goes to the correct route but
a ping reply from the other machine goes to the
default route.

>From my setup, and a dump of 2 packets that show that MAC dst.

On the echo req it has the correct dst, but on the echo reply
the dst is the default route.

The output is from 2 seperate pings and I cut down on the output.

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
172.25.0.0      0.0.0.0         255.255.0.0     U     0      0        0 eth0
192.168.0.0     172.25.4.17     255.255.0.0     UG    0      0        0 eth0
0.0.0.0         172.25.3.1      0.0.0.0         UG    0      0        0 eth0


pie:~# arp -an
? (172.25.3.1) at 00:20:9C:13:08:24 [ether] on eth0
? (172.25.4.15) at 00:D0:B7:BF:D3:37 [ether] on eth0
? (172.25.4.17) at 00:60:08:A6:A4:3D [ether] on eth0

pie:~# tcpdump  -r bad-mac  -n -v -e
14:47:49.275170 0:d0:b7:3f:af:5 0:20:9c:13:8:24 0800 98: 172.25.4.9 > 192.168.12.1: icmp: echo reply (ttl 255, id 12687, len 84)
14:47:51.389840 0:d0:b7:3f:af:5 0:60:8:a6:a4:3d 0800 98: 172.25.4.9 > 192.168.12.1: icmp: echo request (DF) (ttl 64, id 0, len 84)
pie:~# route -n

