Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293375AbSCFIpV>; Wed, 6 Mar 2002 03:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293373AbSCFIpS>; Wed, 6 Mar 2002 03:45:18 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30219 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S293348AbSCFIpC>; Wed, 6 Mar 2002 03:45:02 -0500
Message-Id: <200203060842.g268gfq21995@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <andrewm@uow.edu.au>
Subject: Problem with 3c905B nic
Date: Wed, 6 Mar 2002 10:41:54 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a NFS client which was connected to the server directly
by crossover cable. 100mbit Enternet was working as expected
(~10mbytes/sec peak). Recently I had to move to different
location and now I'm connected to the same server through
stack of four HP ProCurve 4000M switches.
Now I'm getting ~2mbytes/sec peak.

My NIC is 3c905B, seems to working fine under Win NT in 100mbit
full-duplex mode.

Since I boot from network I have NIC drivers compiled in,
tried to instruct 3c59x.c to be more verbose with
ether=0,0,0x8200,eth0 with no success... why?

I put debug printk in the source, it does not print:
        if (dev->mem_start) {
                /*
                 * The 'options' param is passed in as the third arg to the
                 * LILO 'ether=' argument for non-modular use
                 */
                option = dev->mem_start;
===>            printk(KERN_DEBUG "VDA: ether=xx,xx,0x%08x,xxx\n",dev->mem_start);
        }

Ok, I have recompiled drivers/net/3c59x.c with vortex_debug=4
set manually and now I see I'm having problems.

Do someone know what's up here?

/var/log/syslog.7.debug (abridged):
===================================
Mar  6 10:10:14 manta kernel: Kernel command line: root=/dev/nfs  nfsroot=172.16.42.75:/.rootfs/.std,hard,intr  ip=:172.16.42.75:::manta:eth0:dhcp  devfs=mount  ether=0,0,0x8200,eth0
Mar  6 10:10:14 manta kernel: Initializing CPU#0
Mar  6 10:10:14 manta kernel: Memory: 158480k/163840k available (1403k kernel code, 4972k reserved, 403k data, 152k init, 0k highmem)
Mar  6 10:10:14 manta kernel: PCI: Found IRQ 10 for device 00:06.0
Mar  6 10:10:14 manta kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Mar  6 10:10:14 manta kernel: See Documentation/networking/vortex.txt
Mar  6 10:10:14 manta kernel: 00:06.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xfc00. Vers LK1.1.16
Mar  6 10:10:14 manta kernel:  00:01:02:1a:ff:5f, IRQ 10
Mar  6 10:10:14 manta kernel:   product code 434d rev 00.9 date 03-31-00
Mar  6 10:10:14 manta kernel:   Internal config register is 1800000, transceivers 0xa.
Mar  6 10:10:14 manta kernel:   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
Mar  6 10:10:14 manta kernel:   MII transceiver found at address 24, status 786d.
Mar  6 10:10:14 manta kernel:   Enabling bus-master transmits and whole-frame receives.
Mar  6 10:10:14 manta kernel: 00:06.0: scatter/gather enabled. h/w checksums enabled
Mar  6 10:10:14 manta kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Mar  6 10:10:14 manta kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Mar  6 10:10:14 manta kernel: IP: routing cache hash table of 1024 buckets, 8Kbytes
Mar  6 10:10:14 manta kernel: TCP: Hash tables configured (established 16384 bind 16384)
Mar  6 10:10:14 manta kernel: eth0:  Filling in the Rx ring.
Mar  6 10:10:14 manta kernel: eth0: using NWAY device table, not 8
Mar  6 10:10:14 manta kernel: eth0: Initial media type Autonegotiate.
Mar  6 10:10:14 manta kernel: eth0: MII #24 status 786d, link partner capability 45e1, info1 0010, setting full-duplex.
Mar  6 10:10:14 manta kernel: eth0: vortex_up() InternalConfig 01800000.
Mar  6 10:10:14 manta kernel: eth0: vortex_up() irq 10 media status 8880.
Mar  6 10:10:14 manta kernel: Sending DHCP requests .<7>eth0: Media selection timer tick happened, Autonegotiate.
Mar  6 10:10:14 manta kernel: dev->watchdog_timeo=500
Mar  6 10:10:14 manta kernel: eth0: MII transceiver has status 786d.
Mar  6 10:10:14 manta kernel: eth0: Media selection timer finished, Autonegotiate.
Mar  6 10:10:14 manta kernel: ., OK
Mar  6 10:10:14 manta kernel: IP-Config: Got DHCP answer from 255.255.255.255, my address is 172.16.42.211
Mar  6 10:10:14 manta kernel: IP-Config: Complete:
Mar  6 10:10:14 manta kernel:       device=eth0, addr=172.16.42.211, mask=255.255.255.0, gw=172.16.42.98,
Mar  6 10:10:15 manta kernel:      host=manta, domain=, nis-domain=(none),
Mar  6 10:10:15 manta kernel:      bootserver=255.255.255.255, rootserver=172.16.42.75, rootpath=
Mar  6 10:10:15 manta kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Mar  6 10:10:15 manta kernel: Looking up port of RPC 100003/2 on 172.16.42.75
Mar  6 10:10:15 manta kernel: Looking up port of RPC 100005/1 on 172.16.42.75
Mar  6 10:10:15 manta kernel: VFS: Mounted root (nfs filesystem).
Mar  6 10:10:15 manta kernel: Mounted devfs on /dev
Mar  6 10:10:15 manta kernel: Freeing unused kernel memory: 152k freed
Mar  6 10:10:15 manta kernel: eth0: vortex_error(), status=0xe081
Mar  6 10:10:15 manta kernel: eth0: vortex_error(), status=0xe081
Mar  6 10:10:15 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:15 manta last message repeated 3 times
Mar  6 10:10:15 manta kernel: eth0: vortex_error(), status=0xe081
Mar  6 10:10:15 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:18 manta last message repeated 3 times
Mar  6 10:10:18 manta kernel: eth0: vortex_error(), status=0xe081
Mar  6 10:10:19 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:20 manta last message repeated 2 times
Mar  6 10:10:21 manta kernel: eth0: vortex_error(), status=0xe081
Mar  6 10:10:21 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:23 manta last message repeated 3 times
Mar  6 10:10:24 manta dhcpcd[1576]: broadcasting DHCP_DISCOVER
Mar  6 10:10:24 manta dhcpcd[1576]: broadcastAddr option is missing in DHCP server response. Assuming 172.16.42.255
Mar  6 10:10:24 manta dhcpcd[1576]: broadcasting second DHCP_DISCOVER
Mar  6 10:10:24 manta dhcpcd[1576]: DHCP_OFFER received from  (172.16.42.102)
Mar  6 10:10:24 manta dhcpcd[1576]: broadcasting DHCP_REQUEST for 172.16.42.211 
Mar  6 10:10:24 manta dhcpcd[1576]: DHCP_ACK received from  (172.16.42.102)
Mar  6 10:10:24 manta dhcpcd[1576]: dhcpConfig: ioctl SIOCADDRT: File exists 
Mar  6 10:10:25 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:26 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:27 manta last message repeated 2 times
Mar  6 10:10:29 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:31 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:32 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:33 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:33 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:45 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:47 manta kernel: eth0: vortex_error(), status=0xe081
Mar  6 10:10:50 manta kernel: eth0: vortex_error(), status=0xe081
Mar  6 10:10:50 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:52 manta kernel: eth0: vortex_error(), status=0xe081
Mar  6 10:10:53 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:55 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:10:57 manta kernel: eth0: vortex_error(), status=0xe081
Mar  6 10:10:59 manta kernel: eth0: vortex_error(), status=0xe481
Mar  6 10:11:04 manta kernel: eth0: Media selection timer tick happened, Autonegotiate.
Mar  6 10:11:04 manta kernel: dev->watchdog_timeo=500
Mar  6 10:11:04 manta kernel: eth0: MII transceiver has status 786d.
Mar  6 10:11:04 manta kernel: eth0: Media selection timer finished, Autonegotiate.
