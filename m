Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266150AbRGGMRp>; Sat, 7 Jul 2001 08:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266141AbRGGMRf>; Sat, 7 Jul 2001 08:17:35 -0400
Received: from tela.iaeste.tuwien.ac.at ([128.130.57.77]:32004 "EHLO
	tela.iaeste.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S266138AbRGGMRY>; Sat, 7 Jul 2001 08:17:24 -0400
Date: Sat, 7 Jul 2001 14:21:45 +0200
From: Albert Weichselbraun <albert+kernel@iaeste.or.at>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: rtl8139 dhcp-autoconfiguration problem
Message-ID: <20010707142145.A6988@iaeste.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i'm experiencing problems using dhcp-autoconfiguration with rtl8139-network
cards and kernels >2.2.17.
- it seems to be, that the kernel tries to mount the nfs-root-directory,
  before fetching the nodes-ip-address via dhcp (the logs from dhcpd
  indicate, that the node doesn't even try to fetch an ip-address).

<dmesg kernel="2.2.20-pre7" net="rtl8139">
...
rtl8139.c:v1.07 5/6/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/rtl8139.html
eth0: RealTek RTL8139 Fast Ethernet at 0xe000, IRQ 15, 00:02:44:16:41:0b.
Root-NFS: No NFS server available, giving up.
...
</dmesg>

<dmesg kernel="2.2.20-pre7" net="8139too">
...
eth0: 8139too FastEthernet driver 0.9.14-2.2 Jeff Garzik <jgarzik@mandrakesoft.com>
eth0: Linux-2.2 bug reports to Jens David <dg1kjd@afthd.tu-darmstadt.de>
eth0: RealTek RTL8139 Fast Ethernet board found at 0xe08000000, IRQ 10
eth0: Chip is 'RTL-8139B' - MAC address '00:00:21:fa:20:ce'.
Root-NFS: No NFS server available, giving up.
...
</dmesg>

<dmesg kernel="2.4.5" net="8139too">
...
8139too Fast Ethernet driver 0.9.17
PCI: Found IRQ 10 for device 00:09.0
eth0: RealTek RTL8139 Fast Ethernet at 0xe0800000, 00:00:21:fa:20:ce, IRQ 10
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32 Kbytes
TCP: Hash table configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Root-NFS: No NFS server available, giving up.
...
</dmesg>

using the same kernel-config with kernels <= 2.2.17 works without any
problems.

<dmesg kernel="2.2.17" net="rtl18139">
...
rtl8139.c:v1.07 5/6/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/rtl8139.html
eth0: RealTek RTL8139 Fast Ethernet at 0xe000, IRQ 15, 00:02:44:16:41:0b.
Sending DHCP requests .. OK
IP-Config: Got DHCP answer from 192.168.109.51
IP-Config: Complete:
      device=eth0, addr=192.168.109.46, mask=255.255.255.128, gw=192.168.109.1,
     host=192.168.109.46, domain=in-vienna.iaeste.or.at, nis-domain=(none),
     bootserver=192.168.109.51, rootserver=192.168.109.51, rootpath=
Looking up port of RPC 100003/2 on 192.168.109.51
Looking up port of RPC 100005/1 on 192.168.109.51
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 40k freed
...
</dmesg>

the kernel-config and dmesg output are available under
http://www.iaeste.or.at/cc/8139/

any hints, what might be wrong?

greets,
  albert
