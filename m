Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVENNSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVENNSo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 09:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVENNSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 09:18:44 -0400
Received: from lucidpixels.com ([66.45.37.187]:1664 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S262753AbVENNSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 09:18:39 -0400
Date: Sat, 14 May 2005 09:18:36 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: Reproducible 2.6.11.9 NFS Kernel Crashing Bug!
Message-ID: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I run the following command over NFS:
dd if=/dev/hde of=/remote/disk5/file.img bs=1M

After > 30-60 seconds, it kills the remote machine.

I cannot ping the machine, nor can I wake up the monitor to see what 
happened.

The mount options I am using are:
rw,hard,intr,rsize=65536,wsize=65536,nfsvers=3 0 0

1] /dev/hde is on a promise controller on an abit-ic7-g
2] /remote/disk5 is on a promise controller on another abit-ic7-g

Both filesystems are XFS.
The network interface is 1000mbpx full duplex.

Log of what happens, the packet loss begins when the dd starts moving the 
bits over to the other box.

# The following is right before I ran the dd command.
PING routerbox (192.168.0.1) 56(84) bytes of data.
64 bytes from routerbox (192.168.0.1): icmp_seq=1 ttl=64 time=0.214 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=2 ttl=64 time=0.154 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=3 ttl=64 time=0.157 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=4 ttl=64 time=0.171 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=5 ttl=64 time=0.179 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=6 ttl=64 time=0.191 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=7 ttl=64 time=0.179 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=8 ttl=64 time=0.212 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=9 ttl=64 time=0.133 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=10 ttl=64 time=0.228 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=11 ttl=64 time=0.119 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=12 ttl=64 time=0.129 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=13 ttl=64 time=0.260 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=14 ttl=64 time=0.264 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=15 ttl=64 time=0.280 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=16 ttl=64 time=0.276 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=17 ttl=64 time=0.181 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=18 ttl=64 time=0.188 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=19 ttl=64 time=3.17 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=20 ttl=64 time=2.44 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=36 ttl=64 time=0.250 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=37 ttl=64 time=0.256 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=38 ttl=64 time=0.204 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=39 ttl=64 time=0.281 ms
64 bytes from routerbox (192.168.0.1): icmp_seq=40 ttl=64 time=0.170 ms
>From mybox (192.168.0.12) icmp_seq=74 Destination Host Unreachable
>From mybox (192.168.0.12) icmp_seq=75 Destination Host Unreachable
>From mybox (192.168.0.12) icmp_seq=76 Destination Host Unreachable

--- routerbox ping statistics ---
79 packets transmitted, 25 received, +3 errors, 68% packet loss, time 
77984ms
rtt min/avg/max/mdev = 0.119/0.411/3.170/0.715 ms, pipe 3
mybox@mybox:~$


Oh, and incase one may think there is a network issue, there is not, 
during normal operation when I am not running dd, there are no network 
problems, as shown below.

77 packets transmitted, 77 received, 0% packet loss, time 76003ms
rtt min/avg/max/mdev = 0.106/0.226/0.478/0.068 ms






