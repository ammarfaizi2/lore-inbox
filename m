Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264611AbRFPRZV>; Sat, 16 Jun 2001 13:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264617AbRFPRZM>; Sat, 16 Jun 2001 13:25:12 -0400
Received: from dsl-213-023-060-038.arcor-ip.net ([213.23.60.38]:11524 "EHLO
	hal.wirthuell.de") by vger.kernel.org with ESMTP id <S264611AbRFPRZA>;
	Sat, 16 Jun 2001 13:25:00 -0400
Date: Sat, 16 Jun 2001 19:24:20 +0200 (MEST)
From: Daniel Wirth <dw@wirthuell.de>
To: <linux-kernel@vger.kernel.org>
Subject: i386 hangs on 2.4.x kernels: DSL, reiserfs on md, ipfilter
Message-ID: <Pine.LNX.4.33.0106161905080.1983-100000@hal.wirthuell.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel-hackers,

my gateway-system easily crashes while using limewire on a client in the
internal network. I've been testing kernels 2.4.3, 2.4.4, 2.4.5 and
currently 2.4.5-ac3 on a SuSE 7.1 System.

The system is connected to the internet via DSL and to the internal
network via eth1.

FW and Masq are working fine until starting Limewire on a client in the
internal net. At that point, the system hangs without any notice,
syslog or console-message. I can easlily reproduce the scenario.
I don't know the protocols Limewire uses.

I do use some "experimental" features: reiserfs on md and dsl.

Please find some info about the system attached below: lspci, ifconfig,
uname, interupts, ioports, mount, mdstat, ipfilter

I'd be grateful for any ideas and be happy to provide any more information
on request.

Best Regards,
Daniel


(19:05 102 dw@hal:~ ) lspci -v
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II]
(rev 01)
        Flags: bus master, medium devsel, latency 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II]
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton
II] (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 32
        I/O ports at 9000 [size=16]

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
        Flags: medium devsel, IRQ 11
        I/O ports at 6000 [size=32]

00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at 6100 [size=256]
        Memory at e4000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:14.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
(rev 53) (prog-if 00 [VGA])
        Flags: medium devsel, IRQ 9
        Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled] [size=64K]



(19:10 103 dw@hal:~ ) ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:00:B4:5A:F3:E4
          inet addr:10.1.1.1  Bcast:10.1.1.255  Mask:255.255.255.0
          inet6 addr: fe80::200:b4ff:fe5a:f3e4/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:310 errors:0 dropped:0 overruns:0 frame:0
          TX packets:318 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:11 Base address:0x6000

eth1      Link encap:Ethernet  HWaddr 00:48:54:6C:01:81
          inet addr:192.168.99.10  Bcast:192.168.99.255
Mask:255.255.255.0
          inet6 addr: fe80::248:54ff:fe6c:181/10 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2957 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2205 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:10

ippp0     Link encap:Ethernet  HWaddr FC:FC:C0:A8:00:01
          inet addr:192.168.0.1  P-t-P:192.168.0.2  Mask:255.255.255.255
          inet6 addr: fe80::fefc:c0ff:fea8:1/10 Scope:Link
          UP POINTOPOINT RUNNING NOARP  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:30

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:5024 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5024 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

ppp0      Link encap:Point-to-Point Protocol
          inet addr:213.23.60.38  P-t-P:145.253.1.223
Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1490  Metric:1
          RX packets:271 errors:0 dropped:0 overruns:0 frame:0
          TX packets:277 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3

sit0      Link encap:IPv6-in-IPv4
          NOARP  MTU:1480  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0


(19:10 104 dw@hal:~ ) uname -a
Linux hal 2.4.5-ac3 #2 Mon May 28 21:28:47 MEST 2001 i586 unknown
(19:10 105 dw@hal:~ ) free
             total       used       free     shared    buffers     cached
Mem:         94988      77592      17396          0      23784      23840
-/+ buffers/cache:      29968      65020
Swap:       202528          0     202528


(19:10 106 dw@hal:~ ) cat /proc/interrupts
           CPU0
  0:      44205          XT-PIC  timer
  1:          4          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:         89          XT-PIC
  4:          4          XT-PIC
 10:       6321          XT-PIC  eth1
 11:        628          XT-PIC  eth0
 12:         44          XT-PIC  HiSax
 14:      29239          XT-PIC  ide0
 15:      22157          XT-PIC  ide1
NMI:          0
ERR:          0

(19:10 108 dw@hal:~ ) cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0300-0300 : HiSax hscx A fifo
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0700-071f : HiSax hscx A
0a79-0a79 : isapnp write
0b00-0b00 : HiSax hscx B fifo
0cf8-0cff : PCI conf1
0f00-0f1f : HiSax hscx B
1300-1300 : HiSax isac fifo
1700-171f : HiSax isac
1b00-1b07 : avm cfg
6000-601f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  6000-601f : ne2k-pci
6100-61ff : Realtek Semiconductor Co., Ltd. RTL-8139
  6100-61ff : 8139too
9000-900f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
  9000-9007 : ide0
  9008-900f : ide1

(19:11 115 dw@hal:~ ) mount
/dev/md0 on / type reiserfs (rw)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/md1 on /home type reiserfs (rw)
/dev/hda1 on /boot type ext2 (ro)
shmfs on /dev/shm type shm (rw)
automount(pid727) on /misc type autofs
(rw,fd=5,pgrp=727,minproto=2,maxproto=4)
automount(pid737) on /net type autofs
(rw,fd=5,pgrp=737,minproto=2,maxproto=4)


(19:20 102 dw@hal:~ ) cat /proc/mdstat
Personalities : [raid1] [raid5]
read_ahead 1024 sectors
md1 : active raid5 hdc3[2] hdb3[1] hda3[0]
      2999680 blocks level 5, 32k chunk, algorithm 2 [3/3] [UUU]

md0 : active raid1 hdc4[1] hda4[0]
      891008 blocks [2/2] [UU]

unused devices: <none>

(19:23 101 dw@hal:~ ) /etc/init.d/SuSEfirewall status
Checking the status of the Firewall:
Chain INPUT (policy DROP 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
13471 1560K ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0
   14  2915 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp dpts:137:138
    0     0 LOG        all  --  *      *       127.0.0.0/8          0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOFING'
    0     0 LOG        all  --  *      *       0.0.0.0/0            127.0.0.0/8        LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOFING'
    0     0 DROP       all  --  *      *       127.0.0.0/8          0.0.0.0/0
    0     0 DROP       all  --  *      *       0.0.0.0/0            127.0.0.0/8
    0     0 LOG        all  --  *      *       192.168.99.10        0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOFING'
    0     0 DROP       all  --  *      *       192.168.99.10        0.0.0.0/0
    0     0 LOG        all  --  *      *       213.23.60.38         0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOFING'
    0     0 DROP       all  --  *      *       213.23.60.38         0.0.0.0/0
  428 86043 input_ext  all  --  ppp0   *       0.0.0.0/0            213.23.60.38
 8086  654K input_int  all  --  eth1   *       0.0.0.0/0            192.168.99.10
    0     0 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-UNALLOWED-TARGET'
    0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0

Chain FORWARD (policy DROP 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
    0     0 ACCEPT     all  --  eth1   eth1    0.0.0.0/0            0.0.0.0/0
    0     0 ACCEPT     all  --  ppp0   ppp0    0.0.0.0/0            0.0.0.0/0
    0     0 forward_ext  all  --  ppp0   *       0.0.0.0/0            0.0.0.0/0
    1    62 forward_int  all  --  eth1   *       0.0.0.0/0            0.0.0.0/0
    0     0 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-UNALLOWED-ROUTING'
    0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0
    0     0 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED
    0     0 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-FORWARD-ERROR'

Chain OUTPUT (policy ACCEPT 7 packets, 1051 bytes)
 pkts bytes target     prot opt in     out     source               destination
13471 1560K ACCEPT     all  --  *      lo      0.0.0.0/0            0.0.0.0/0
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 11 LOG flags 6 level 4 prefix `SuSE-FW-TRACEROUTE-ATTEMPT'
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 11
    1   176 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 3 code 3
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 3 code 4
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 3 code 9
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 3 code 10
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 3 code 13
    0     0 DROP       icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 3
 6780 1216K ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED
    0     0 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-OUTPUT-ERROR'

Chain forward_dmz (0 references)
 pkts bytes target     prot opt in     out     source               destination
    0     0 LOG        all  --  *      *       213.23.60.38         0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOF'
    0     0 DROP       all  --  *      *       213.23.60.38         0.0.0.0/0
    0     0 LOG        all  --  *      *       192.168.99.0/24      0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOF'
    0     0 DROP       all  --  *      *       192.168.99.0/24      0.0.0.0/0
    0     0 LOG        all  --  *      *       0.0.0.0/0            192.168.99.10      LOG flags 6 level 4 prefix `SuSE-FW-DROP-CIRCUMVENTION'
    0     0 DROP       all  --  *      *       0.0.0.0/0            192.168.99.10
    0     0 LOG        all  --  *      *       0.0.0.0/0            213.23.60.38       LOG flags 6 level 4 prefix `SuSE-FW-DROP-CIRCUMVENTION'
    0     0 DROP       all  --  *      *       0.0.0.0/0            213.23.60.38
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED icmp type 3
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 0
    0     0 ACCEPT     all  --  *      ppp0    192.168.99.0/24      0.0.0.0/0          state NEW,RELATED,ESTABLISHED
    0     0 ACCEPT     all  --  ppp0   *       0.0.0.0/0            192.168.99.0/24    state RELATED,ESTABLISHED
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 4 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 5 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 8 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 13 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 17 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0/0          state INVALID LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT-INVALID'
    0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0

Chain forward_ext (1 references)
 pkts bytes target     prot opt in     out     source               destination
    0     0 LOG        all  --  *      *       192.168.99.0/24      0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOF'
    0     0 DROP       all  --  *      *       192.168.99.0/24      0.0.0.0/0
    0     0 LOG        all  --  *      *       192.168.99.0/24      0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOF'
    0     0 DROP       all  --  *      *       192.168.99.0/24      0.0.0.0/0
    0     0 LOG        all  --  *      *       0.0.0.0/0            192.168.99.10      LOG flags 6 level 4 prefix `SuSE-FW-DROP-CIRCUMVENTION'
    0     0 DROP       all  --  *      *       0.0.0.0/0            192.168.99.10
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED icmp type 3
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 0
    0     0 ACCEPT     all  --  *      ppp0    192.168.99.0/24      0.0.0.0/0          state NEW,RELATED,ESTABLISHED
    0     0 ACCEPT     all  --  ppp0   *       0.0.0.0/0            192.168.99.0/24    state RELATED,ESTABLISHED
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 4 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 5 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 8 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 13 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 17 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0/0          state INVALID LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT-INVALID'
    0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0

Chain forward_int (1 references)
 pkts bytes target     prot opt in     out     source               destination
    0     0 LOG        all  --  *      *       213.23.60.38         0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOF'
    0     0 DROP       all  --  *      *       213.23.60.38         0.0.0.0/0
    0     0 LOG        all  --  *      *       0.0.0.0/0            213.23.60.38       LOG flags 6 level 4 prefix `SuSE-FW-DROP-CIRCUMVENTION'
    0     0 DROP       all  --  *      *       0.0.0.0/0            213.23.60.38
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED icmp type 3
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 0
    1    62 ACCEPT     all  --  *      ppp0    192.168.99.0/24      0.0.0.0/0          state NEW,RELATED,ESTABLISHED
    0     0 ACCEPT     all  --  ppp0   *       0.0.0.0/0            192.168.99.0/24    state RELATED,ESTABLISHED
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 4 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 5 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 8 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 13 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 17 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0/0          state INVALID LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT-INVALID'
    0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0

Chain input_dmz (0 references)
 pkts bytes target     prot opt in     out     source               destination
    0     0 LOG        all  --  *      *       213.23.60.38         0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOF'
    0     0 DROP       all  --  *      *       213.23.60.38         0.0.0.0/0
    0     0 LOG        all  --  *      *       192.168.99.0/24      0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOF'
    0     0 DROP       all  --  *      *       192.168.99.0/24      0.0.0.0/0
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 0
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 3
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 11
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 12
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 14
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 18
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 5 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 4 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 13 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 17 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 2 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 DROP       icmp --  *      *       0.0.0.0/0            0.0.0.0/0
    0     0 REJECT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:113 flags:0x16/0x02 reject-with tcp-reset
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:22 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:22 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:25 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:25 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:111 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:111 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:139 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:139 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:515 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:515 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:979 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:979 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:1024 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:1024 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:3128 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:3128 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:20011 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:20011 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp spt:20 dpts:1024:65535 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-ACCEPT'
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:20 dpts:1024:65535
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp spt:53 dpts:1024:65535 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-ACCEPT'
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:53 dpts:1024:65535
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state ESTABLISHED tcp dpts:600:65535 flags:!0x16/0x02
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state ESTABLISHED tcp dpt:20 flags:!0x16/0x02
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp dpt:1024
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:22
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:25
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:111
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:111
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:123
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:137
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:138
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:139
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:514
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:515
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:977
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:979
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:1027
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:1028
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:1035
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:2049
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:3128
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:3130
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:20011
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp spt:53 dpts:1024:65535
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp spt:123 dpts:1024:65535
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 4 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 5 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 8 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 13 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 17 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0/0          state INVALID LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT-INVALID'
    0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0

Chain input_ext (1 references)
 pkts bytes target     prot opt in     out     source               destination
    0     0 LOG        all  --  *      *       192.168.99.0/24      0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOF'
    0     0 DROP       all  --  *      *       192.168.99.0/24      0.0.0.0/0
    0     0 LOG        all  --  *      *       192.168.99.0/24      0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOF'
    0     0 DROP       all  --  *      *       192.168.99.0/24      0.0.0.0/0
    0     0 LOG        icmp --  *      *       213.23.60.38         0.0.0.0/0          icmp type 4 LOG flags 6 level 4 prefix `SuSE-FW-ACCEPT-SOURCEQUENCH'
    0     0 ACCEPT     icmp --  *      *       213.23.60.38         0.0.0.0/0          icmp type 4
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 0
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 3
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 11
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 12
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 14
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 18
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 5 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 4 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 13 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 17 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 2 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    1  1006 DROP       icmp --  *      *       0.0.0.0/0            0.0.0.0/0
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:22 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-ACCEPT'
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp dpt:22
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:15472 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-ACCEPT'
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp dpt:15472
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:123 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-ACCEPT'
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp dpt:123
    0     0 REJECT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:113 flags:0x16/0x02 reject-with tcp-reset
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp spt:20 dpts:1024:65535 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-ACCEPT'
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:20 dpts:1024:65535
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp spt:53 dpts:1024:65535 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-ACCEPT'
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:53 dpts:1024:65535
  290 58674 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state ESTABLISHED tcp dpts:600:65535 flags:!0x16/0x02
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state ESTABLISHED tcp dpt:20 flags:!0x16/0x02
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp dpt:53
   13   988 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp dpt:123
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp dpt:1024
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:22
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:25
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:111
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:111
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:123
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:123
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:137
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:138
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:139
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:514
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:515
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:977
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:979
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:1027
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:1028
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:1035
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:2049
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:3128
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:3130
    0     0 DROP       udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:20011
  108 23839 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp spt:53 dpts:1024:65535
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp spt:123 dpts:1024:65535
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state ESTABLISHED udp dpts:61000:65095
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 4 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 5 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 8 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 13 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 17 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0/0          state INVALID LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT-INVALID'
   16  1536 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0

Chain input_int (1 references)
 pkts bytes target     prot opt in     out     source               destination
    0     0 LOG        all  --  *      *       213.23.60.38         0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-ANTI-SPOOF'
    0     0 DROP       all  --  *      *       213.23.60.38         0.0.0.0/0
 8086  654K ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 0
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 3
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 11
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 12
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 14
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0          state RELATED,ESTABLISHED icmp type 18
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 5 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 4 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 13 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 17 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 2 LOG flags 6 level 4 prefix `SuSE-FW-DROP-ICMP-CRIT'
    0     0 DROP       icmp --  *      *       0.0.0.0/0            0.0.0.0/0
    0     0 REJECT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:113 flags:0x16/0x02 reject-with tcp-reset
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:22 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:22 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:25 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:25 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:111 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:111 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:139 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:139 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:515 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:515 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:979 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:979 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:1024 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:1024 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:3128 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:3128 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:20011 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP'
    0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp dpt:20011 flags:0x16/0x02
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp spt:20 dpts:1024:65535 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-ACCEPT'
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:20 dpts:1024:65535
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp spt:53 dpts:1024:65535 flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-ACCEPT'
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:53 dpts:1024:65535
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state ESTABLISHED tcp dpts:600:65535 flags:!0x16/0x02
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state ESTABLISHED tcp dpt:20 flags:!0x16/0x02
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp dpt:1024
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp spt:53 dpts:1024:65535
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp spt:123 dpts:1024:65535
    0     0 LOG        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          tcp flags:0x16/0x02 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 4 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 5 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 8 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 13 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        icmp --  *      *       0.0.0.0/0            0.0.0.0/0          icmp type 17 LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT'
    0     0 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0/0          state INVALID LOG flags 6 level 4 prefix `SuSE-FW-DROP-DEFAULT-INVALID'
    0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0
Chain PREROUTING (policy ACCEPT 25 packets, 4542 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain POSTROUTING (policy ACCEPT 96 packets, 6987 bytes)
 pkts bytes target     prot opt in     out     source               destination
    1    62 MASQUERADE  all  --  *      ppp0    192.168.99.0/24      0.0.0.0/0

Chain OUTPUT (policy ACCEPT 96 packets, 6987 bytes)
 pkts bytes target     prot opt in     out     source               destination
Chain PREROUTING (policy ACCEPT 22158 packets, 2319K bytes)
 pkts bytes target     prot opt in     out     source               destination
   22  1939 TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:22 TOS set 0x10
 7980  637K TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp dpt:22 TOS set 0x10
    0     0 TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:20 TOS set 0x08
    0     0 TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp dpt:20 TOS set 0x08
    0     0 TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:80 TOS set 0x08
    0     0 TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp dpt:80 TOS set 0x08
    0     0 TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:53 TOS set 0x10
    0     0 TOS        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp dpt:53 TOS set 0x10
    0     0 TOS        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp dpt:161 TOS set 0x04
    0     0 TOS        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp dpt:162 TOS set 0x04
    0     0 TOS        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:514 TOS set 0x04

Chain OUTPUT (policy ACCEPT 20430 packets, 2829K bytes)
 pkts bytes target     prot opt in     out     source               destination
 6240 1209K TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:22 TOS set 0x10
   21  1916 TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp dpt:22 TOS set 0x10
    0     0 TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:20 TOS set 0x08
    0     0 TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp dpt:20 TOS set 0x08
    0     0 TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:80 TOS set 0x08
    0     0 TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp dpt:80 TOS set 0x08
    0     0 TOS        tcp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED tcp spt:53 TOS set 0x10
  109  6707 TOS        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp dpt:53 TOS set 0x10
    0     0 TOS        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp dpt:161 TOS set 0x04
    0     0 TOS        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          state NEW,RELATED,ESTABLISHED udp dpt:162 TOS set 0x04
    0     0 TOS        udp  --  *      *       0.0.0.0/0            0.0.0.0/0          udp dpt:514 TOS set 0x04

