Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbSKMGE4>; Wed, 13 Nov 2002 01:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267114AbSKMGE4>; Wed, 13 Nov 2002 01:04:56 -0500
Received: from pa13.bydgoszcz.sdi.tpnet.pl ([213.25.7.13]:4891 "HELO
	pa13.bydgoszcz.sdi.tpnet.pl") by vger.kernel.org with SMTP
	id <S266717AbSKMGEx>; Wed, 13 Nov 2002 01:04:53 -0500
Date: Wed, 13 Nov 2002 07:11:47 +0100
From: "Tomasz Torcz, BG" <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Uninitialised timer in 2.5.47
Message-ID: <20021113061147.GB19447@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

today I've booted 2.5.47 and got some unpleasant, oopslooking
messages. It's looks like some debugging info.
I'm including dmegs output, as it seems to contain enough info.
If any more info is needed, I will happily provide it.

(please CC me if replying).

dmesg follows:

matroxfb' as minor 0
i2c-dev.o: Registered 'DDC:fb0 #1 on i2c-matroxfb' as minor 1
i2c-dev.o: Registered 'MAVEN:fb0 on i2c-matroxfb' as minor 2
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
register interface 'joystick' with class 'input
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-core.o: i2c core module version 2.6.4 (20020719)
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
devfs_mk_dir(i2c): could not append to dir: c7fb9320 "", err: -17
i2c-proc.o version 2.6.4 (20020719)
Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Sun Nov 10 19:48:18 2002 UT
C).
request_module[snd-card-0]: not ready
request_module[snd-card-1]: not ready
request_module[snd-card-2]: not ready
request_module[snd-card-3]: not ready
request_module[snd-card-4]: not ready
request_module[snd-card-5]: not ready
request_module[snd-card-6]: not ready
request_module[snd-card-7]: not ready
ALSA device list:
  #0: Ensoniq AudioPCI ES1370 at 0xec00, irq 10
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack version 2.1 (1023 buckets, 8184 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
BIOS EDD facility v0.07 2002-Oct-24, 2 devices found
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,3), size 8192, journal first block 18, max tran
s len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,3)) for (ide0(3,3))
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 128k freed
Adding 251488k swap on /dev/ide/host0/bus0/target1/lun0/part2.  Priority:-1 extents:1
Removing [49380 98972 0x0 SD]..done
There were 1 uncompleted unlinks/truncates. Completed
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,65), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: 3c5x9 at 0x320, BNC port, address  00 60 08 17 de 2f, IRQ 5.
3c509.c:1.19a 28Oct2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
eth0: Setting Rx mode to 1 addresses.
eth0: Setting Rx mode to 2 addresses.
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc03528bc, data=0xc77f7840
Call Trace:
 [<c0120370>] check_timer_failed+0x40/0x4c
 [<c03528bc>] igmp6_timer_handler+0x0/0x50
 [<c01207a1>] del_timer+0x15/0x74
 [<c035277e>] igmp6_join_group+0x8a/0x104
 [<c0351a3c>] igmp6_group_added+0xb0/0xbc
 [<c03500ef>] rawv6_sendmsg+0x3a7/0x3f8
 [<c0351d89>] ipv6_dev_mc_inc+0x281/0x294
 [<c0342eee>] addrconf_join_solict+0x3a/0x44
 [<c0344343>] addrconf_dad_start+0x13/0x12c
 [<c0343d14>] addrconf_add_linklocal+0x28/0x40
 [<c0343dc5>] addrconf_dev_config+0x99/0xa4
 [<c0343eae>] addrconf_notify+0x52/0xc0
 [<c01235ba>] notifier_call_chain+0x1e/0x38
 [<c02f6819>] dev_open+0x99/0xa4
 [<c02f78f5>] dev_change_flags+0x51/0x104
 [<c0328390>] devinet_ioctl+0x2bc/0x598
 [<c032a7d7>] inet_ioctl+0x7b/0xb8
 [<c02f0792>] sock_ioctl+0x24e/0x278
 [<c014f559>] sys_ioctl+0x21d/0x274
 [<c0108b29>] error_code+0x2d/0x38
 [<c0108947>] syscall_call+0x7/0xb

eth0: Setting Rx mode to 3 addresses.
eth0: Setting Rx mode to 4 addresses.
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc03528bc, data=0xc759eb00
Call Trace:
 [<c0120370>] check_timer_failed+0x40/0x4c
 [<c03528bc>] igmp6_timer_handler+0x0/0x50
 [<c01207a1>] del_timer+0x15/0x74
 [<c035277e>] igmp6_join_group+0x8a/0x104
 [<c0351a3c>] igmp6_group_added+0xb0/0xbc
 [<c0351000>] icmpv6_notify+0xbc/0x158
 [<c0351d89>] ipv6_dev_mc_inc+0x281/0x294
 [<c0342eee>] addrconf_join_solict+0x3a/0x44
 [<c0344343>] addrconf_dad_start+0x13/0x12c
 [<c034374e>] inet6_addr_add+0xa2/0xc4
 [<c0344b47>] inet6_rtm_newaddr+0x5b/0x70
 [<c02fc604>] rtnetlink_rcv+0x2ac/0x400
 [<c02ff71b>] netlink_dump_start+0x127/0x130
 [<c02ff2f1>] netlink_data_ready+0x1d/0x58
 [<c02fecb6>] netlink_unicast+0x2a6/0x2ec
 [<c0115e30>] default_wake_function+0x0/0x34
 [<c0115e30>] default_wake_function+0x0/0x34
 [<c02ff18b>] netlink_sendmsg+0x1ef/0x200
 [<c02f004f>] __sock_sendmsg+0xa3/0xd0
 [<c02f00e8>] sock_sendmsg+0x6c/0x90
 [<c02f00e8>] sock_sendmsg+0x6c/0x90
 [<c021bcd3>] copy_from_user+0x2f/0x3c
 [<c021bcd3>] copy_from_user+0x2f/0x3c
 [<c02f49dc>] verify_iovec+0x5c/0x84
 [<c02f15d0>] sys_sendmsg+0xe4/0x1ec
 [<c02f1675>] sys_sendmsg+0x189/0x1ec
 [<c012c909>] handle_mm_fault+0x6d/0x100
 [<c01148b7>] do_page_fault+0x137/0x434
 [<c0114780>] do_page_fault+0x0/0x434
 [<c012de35>] do_brk+0x189/0x1c0
 [<c021bcd3>] copy_from_user+0x2f/0x3c
 [<c02f1a7c>] sys_socketcall+0x1d8/0x1f4
 [<c0108b29>] error_code+0x2d/0x38
 [<c0108947>] syscall_call+0x7/0xb

eth0: Setting Rx mode to 5 addresses.
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc03528bc, data=0xc759ea40
Call Trace:
 [<c0120370>] check_timer_failed+0x40/0x4c
 [<c03528bc>] igmp6_timer_handler+0x0/0x50
 [<c01207a1>] del_timer+0x15/0x74
 [<c035277e>] igmp6_join_group+0x8a/0x104
 [<c0351a3c>] igmp6_group_added+0xb0/0xbc
 [<c0350100>] rawv6_sendmsg+0x3b8/0x3f8
 [<c0351d89>] ipv6_dev_mc_inc+0x281/0x294
 [<c0342eee>] addrconf_join_solict+0x3a/0x44
 [<c0344343>] addrconf_dad_start+0x13/0x12c
 [<c034374e>] inet6_addr_add+0xa2/0xc4
 [<c0344b47>] inet6_rtm_newaddr+0x5b/0x70
 [<c02fc604>] rtnetlink_rcv+0x2ac/0x400
 [<c02ff71b>] netlink_dump_start+0x127/0x130
 [<c02ff2f1>] netlink_data_ready+0x1d/0x58
 [<c02fecb6>] netlink_unicast+0x2a6/0x2ec
 [<c0115e30>] default_wake_function+0x0/0x34
 [<c0115e30>] default_wake_function+0x0/0x34
 [<c02ff18b>] netlink_sendmsg+0x1ef/0x200
 [<c02f004f>] __sock_sendmsg+0xa3/0xd0
 [<c02f00e8>] sock_sendmsg+0x6c/0x90
 [<c02f00e8>] sock_sendmsg+0x6c/0x90
 [<c021bcd3>] copy_from_user+0x2f/0x3c
 [<c021bcd3>] copy_from_user+0x2f/0x3c
 [<c02f49dc>] verify_iovec+0x5c/0x84
 [<c02f15d0>] sys_sendmsg+0xe4/0x1ec
 [<c02f1675>] sys_sendmsg+0x189/0x1ec
 [<c012c909>] handle_mm_fault+0x6d/0x100
 [<c01148b7>] do_page_fault+0x137/0x434
 [<c0114780>] do_page_fault+0x0/0x434
 [<c012de35>] do_brk+0x189/0x1c0
 [<c021bcd3>] copy_from_user+0x2f/0x3c
 [<c02f1a7c>] sys_socketcall+0x1d8/0x1f4
 [<c0108b29>] error_code+0x2d/0x38
 [<c0108947>] syscall_call+0x7/0xb

8139too Fast Ethernet driver 0.9.26
eth1: RealTek RTL8139 Fast Ethernet at 0xca920000, 00:06:4f:00:e8:99, IRQ 12
eth1:  Identified 8139 chip type 'RTL-8139C'
eth1: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc03528bc, data=0xc759e0e0
Call Trace:
 [<c0120370>] check_timer_failed+0x40/0x4c
 [<c03528bc>] igmp6_timer_handler+0x0/0x50
 [<c01207a1>] del_timer+0x15/0x74
 [<c035277e>] igmp6_join_group+0x8a/0x104
 [<c0351a3c>] igmp6_group_added+0xb0/0xbc
 [<c03500ef>] rawv6_sendmsg+0x3a7/0x3f8
 [<c0351d89>] ipv6_dev_mc_inc+0x281/0x294
 [<c0342eee>] addrconf_join_solict+0x3a/0x44
 [<c0344343>] addrconf_dad_start+0x13/0x12c
 [<c0343d14>] addrconf_add_linklocal+0x28/0x40
 [<c0343dc5>] addrconf_dev_config+0x99/0xa4
 [<c0343eae>] addrconf_notify+0x52/0xc0
 [<c01235ba>] notifier_call_chain+0x1e/0x38
 [<c02f6819>] dev_open+0x99/0xa4
 [<c02f78f5>] dev_change_flags+0x51/0x104
 [<c0328390>] devinet_ioctl+0x2bc/0x598
 [<c032a7d7>] inet_ioctl+0x7b/0xb8
 [<c02f0792>] sock_ioctl+0x24e/0x278
 [<c014f559>] sys_ioctl+0x21d/0x274
 [<c0108b29>] error_code+0x2d/0x38
 [<c0108947>] syscall_call+0x7/0xb

eth0: no IPv6 routers present
eth1: no IPv6 routers present
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, Tx_status 00 status 2000 Tx FIFO room 1488.
Buffer I/O error on device loop(7,0), logical block 0
Buffer I/O error on device loop(7,0), logical block 1
Buffer I/O error on device loop(7,0), logical block 2
Buffer I/O error on device loop(7,0), logical block 3
Buffer I/O error on device loop(7,0), logical block 4
Buffer I/O error on device loop(7,0), logical block 5
Buffer I/O error on device loop(7,0), logical block 6
Buffer I/O error on device loop(7,0), logical block 7
Buffer I/O error on device loop(7,0), logical block 8
Buffer I/O error on device loop(7,0), logical block 9
Buffer I/O error on device loop(7,0), logical block 10
Buffer I/O error on device loop(7,0), logical block 11
Buffer I/O error on device loop(7,0), logical block 12
Buffer I/O error on device loop(7,0), logical block 13
Buffer I/O error on device loop(7,0), logical block 14
Buffer I/O error on device loop(7,0), logical block 15
Buffer I/O error on device loop(7,0), logical block 16
(buffer errors till the end).

-- 
Tomasz Torcz           Zjadanie martwych dzieci
zdzichu@irc.pl           jest barbarzynstwem!
