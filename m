Return-Path: <linux-kernel-owner+w=401wt.eu-S932848AbWL1JuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848AbWL1JuR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932849AbWL1JuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:50:16 -0500
Received: (root@vger.kernel.org) by vger.kernel.org id S932848AbWL1JuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:50:16 -0500
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:55369 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964885AbWL1DXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 22:23:30 -0500
Message-ID: <459338AF.6010200@blueyonder.co.uk>
Date: Thu, 28 Dec 2006 03:23:27 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: 2.6.19 and up to  2.6.20-rc2 Ethernet problems x86_64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I first saw the problem on the 64x2 box after upgrading to 2.6.19. The
network appeared OK with ifconfig and route -n, but I had no network
access. Pinging any other box, the box was responding, but no response
was received by the 64x2. I checked cables and the switch which were OK,
so I figured I had a faulty receiver on the on-board ethernet. I plugged
in a PCI eepro100, reconfigured  the network and it's been fine ever since.

I upgraded to 2.6.20-rc2 (also 2.6.19 and later) on the x86_64 laptop
and that also experienced the same problem - different cards in both
boxes. Downgraded to 2.6.19-rc5 and network is up.

================== 64x2 box ======================
64: None 00.0: 10701 Ethernet
   [Created at net.115]
   UDI: /org/freedesktop/Hal/devices/net_00_01_6c_e6_ab_7a
   Unique ID: usDW.ndpeucax6V1
   Parent ID: rBUF.siZp+507g89
   SysFS ID: /class/net/eth0
   SysFS Device Link: /devices/pci0000:00/0000:00:14.0
   Hardware Class: network interface
   Model: "Ethernet network interface"
   Driver: "forcedeth"
   Device File: eth0
   HW Address: 00:01:6c:e6:ab:7a
   Link detected: yes
   Config Status: cfg=new, avail=yes, need=no, active=unknown
   Attached to: #39 (Ethernet controller)
*********** PROBLEM **************
--------------------------------------------------------------------
eepro100 working (64x2)
=======================
65: None 01.0: 10701 Ethernet
   [Created at net.115]
   UDI: /org/freedesktop/Hal/devices/net_00_d0_b7_13_e5_ea
   Unique ID: L2Ua.ndpeucax6V1
   Parent ID: JNkJ.HVgIlgOrmpC
   SysFS ID: /class/net/eth1
   SysFS Device Link: /devices/pci0000:00/0000:00:10.0/0000:04:08.0
   Hardware Class: network interface
   Model: "Ethernet network interface"
   Driver: "eepro100"
   Device File: eth1
   HW Address: 00:d0:b7:13:e5:ea
   Link detected: yes
   Config Status: cfg=new, avail=yes, need=no, active=unknown
   Attached to: #46 (Ethernet controller)
=======================================================================

Acer 1501LCe x86_64 laptop.
============================
49: udi = '/org/freedesktop/Hal/devices/pci_14e4_169c'
   info.bus = 'pci'
   info.linux.driver = 'tg3'
   info.parent = '/org/freedesktop/Hal/devices/computer'
   info.product = 'NetXtreme BCM5788 Gigabit Ethernet'
   info.udi = '/org/freedesktop/Hal/devices/pci_14e4_169c'
   info.vendor = 'Broadcom Corporation'
   linux.hotplug_type = 1 (0x1)
   linux.subsystem = 'pci'
   linux.sysfs_path = '/sys/devices/pci0000:00/0000:00:0c.0'
   linux.sysfs_path_device = '/sys/devices/pci0000:00/0000:00:0c.0'
   pci.device_class = 2 (0x2)
   pci.device_protocol = 0 (0x0)
   pci.device_subclass = 0 (0x0)
   pci.linux.sysfs_path = '/sys/devices/pci0000:00/0000:00:0c.0'
   pci.product = 'NetXtreme BCM5788 Gigabit Ethernet'
   pci.product_id = 5788 (0x169c)
   pci.subsys_product = 'Unknown (0x0046)'
   pci.subsys_product_id = 70 (0x46)
   pci.subsys_vendor = 'Acer Incorporated [ALI]'
   pci.subsys_vendor_id = 4133 (0x1025)
   pci.vendor = 'Broadcom Corporation'
   pci.vendor_id = 5348 (0x14e4)

============== tcpdump on barrabas when pinged from Boycie =====
01:45:32.089245 arp who-has Boycie.site tell barrabas.site
01:45:32.089323 arp reply Boycie.site is-at 00:0a:e4:4e:a1:42 (oui Unknown)
01:45:32.172445 IP Boycie.site > barrabas.site: ICMP echo request, id
8463, seq 41, length 64
01:45:32.172480 IP barrabas.site > Boycie.site: ICMP echo reply, id 8463,
seq 41, length 64
01:45:33.189534 IP Boycie.site > barrabas.site: ICMP echo request, id
8463, seq 42, length 64
01:45:33.189569 IP barrabas.site > Boycie.site: ICMP echo reply, id 8463,
seq 42, length 64
01:45:34.205635 IP Boycie.site > barrabas.site: ICMP echo request, id
8463, seq 43, length 64
01:45:34.205667 IP barrabas.site > Boycie.site: ICMP echo reply, id 8463,
seq 43, length 64
01:45:35.221734 IP Boycie.site > barrabas.site: ICMP echo request, id
8463, seq 44, length 64
01:45:35.221767 IP barrabas.site > Boycie.site: ICMP echo reply, id 8463,
seq 44, length 64
01:45:36.237835 IP Boycie.site > barrabas.site: ICMP echo request, id
8463, seq 45, length 64
01:45:36.237868 IP barrabas.site > Boycie.site: ICMP echo reply, id 8463,
seq 45, length 64
01:45:37.254956 IP Boycie.site > barrabas.site: ICMP echo request, id
8463, seq 46, length 64
01:45:37.254991 IP barrabas.site > Boycie.site: ICMP echo reply, id 8463,
seq 46, length 64
01:45:38.272044 IP Boycie.site > barrabas.site: ICMP echo request, id
8463, seq 47, length 64
01:45:38.272077 IP barrabas.site > Boycie.site: ICMP echo reply, id 8463,
seq 47, length 64
01:45:39.288136 IP Boycie.site > barrabas.site: ICMP echo request, id
8463, seq 48, length 64
01:45:39.288170 IP barrabas.site > Boycie.site: ICMP echo reply, id 8463,
seq 48, length 64
170 packets captured
340 packets received by filter
0 packets dropped by kernel


Boycie sees just a few packets occasionally when pinged from barrabas,
but says its dropped no packets.

Also strange, I can scp a file from Boycie.
barrabas:/usr/src/linux-2.6.20-rc1-git5 # scp Boycie:/IFCONFIG /
Password:
IFCONFIG                                                    100%  907
0.9KB/s   00:00
barrabas:/usr/src/linux-2.6.20-rc1-git5 # o /IFCONFIG
eth0      Link encap:Ethernet  HWaddr 00:0A:E4:4E:A1:42
           inet addr:192.168.10.5  Bcast:255.255.255.255  Mask:255.255.255.0
           inet6 addr: fe80::20a:e4ff:fe4e:a142/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:577 errors:0 dropped:0 overruns:0 frame:0
           TX packets:569 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:65202 (63.6 Kb)  TX bytes:49404 (48.2 Kb)
           Interrupt:20

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           inet6 addr: ::1/128 Scope:Host
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:26 errors:0 dropped:0 overruns:0 frame:0
           TX packets:26 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:1866 (1.8 Kb)  TX bytes:1866 (1.8 Kb)

barrabas:/usr/src/linux-2.6.20-rc1-git5 # ssh Boycie ifconfig
Password:
eth0      Link encap:Ethernet  HWaddr 00:0A:E4:4E:A1:42
           inet addr:192.168.10.5  Bcast:255.255.255.255  Mask:255.255.255.0
           inet6 addr: fe80::20a:e4ff:fe4e:a142/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:728 errors:0 dropped:0 overruns:0 frame:0
           TX packets:710 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:83960 (81.9 Kb)  TX bytes:65125 (63.5 Kb)
           Interrupt:20

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           inet6 addr: ::1/128 Scope:Host
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:26 errors:0 dropped:0 overruns:0 frame:0
           TX packets:26 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:1866 (1.8 Kb)  TX bytes:1866 (1.8 Kb)
Regards
Sid.


-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks
