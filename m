Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312923AbSDBUp0>; Tue, 2 Apr 2002 15:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312924AbSDBUpR>; Tue, 2 Apr 2002 15:45:17 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:50854 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S312923AbSDBUpB>;
	Tue, 2 Apr 2002 15:45:01 -0500
Message-ID: <3CAA184C.6020105@candelatech.com>
Date: Tue, 02 Apr 2002 13:45:00 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RH 7.2.99 SkipJack kernel (2.4.18-XX) oops.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not seen this in the non-redhat kernels, but that
may be for other reasons.  I did open a bug with RH as well.

Here is the info:

Description of problem:
Using SkipJack kernel and applications, with a DFE 570TX 4-port
NIC (tulip) in an FV24 (SpaceWalker) x86 platform (PIII 1Ghz).
I am running heavy network traffic (~24Mbps bi-directional)

I see this oops and others like it in the kernel.

Apr  2 15:26:18 demo2 ntpd[854]: kernel time discipline status change 41
Apr  2 15:27:43 demo2 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Apr  2 15:27:47 demo2 kernel: Unable to handle kernel paging request at virtual
address 8786858c
Apr  2 15:27:47 demo2 kernel:  printing eip:
Apr  2 15:27:47 demo2 kernel: c01d26c6
Apr  2 15:27:47 demo2 kernel: *pde = 00000000
Apr  2 15:27:47 demo2 kernel: Oops: 0000
Apr  2 15:27:47 demo2 kernel: CPU:    0
Apr  2 15:27:47 demo2 kernel: EIP:    0010:[rtnetlink_fill_ifinfo+758/1056]
Not tainted
Apr  2 15:27:47 demo2 kernel: EIP:    0010:[<c01d26c6>]    Not tainted
Apr  2 15:27:47 demo2 kernel: EFLAGS: 00010282
Apr  2 15:27:47 demo2 kernel: EIP is at rtnetlink_put_metrics_Raea2f6a7 [] 0x406
Apr  2 15:27:47 demo2 kernel: eax: 00000000   ebx: 8786858c   ecx: ffffffff
edx: 00000000
Apr  2 15:27:47 demo2 kernel: esi: 00000da4   edi: 8786858c   ebp: 00000000
esp: ca779c98
Apr  2 15:27:47 demo2 kernel: ds: 0018   es: 0018   ss: 0018
Apr  2 15:27:47 demo2 kernel: Process ip (pid: 1862, stackpage=ca779000)
Apr  2 15:27:47 demo2 kernel: Stack: cf708ed4 cc495170 cc495170 000005dc
cd552000 00000002 cac4bd1c ca941414
Apr  2 15:27:47 demo2 kernel:        c01d2835 ca941414 cd552000 00000010
00000746 3caa1444 00000000 00000000
Apr  2 15:27:47 demo2 kernel:        ca941414 ca8f1904 cac4bd1c cae1f0e0
c01d98d5 ca941414 cac4bd1c cac4bd5b
Apr  2 15:27:47 demo2 kernel: Call Trace: [rtnetlink_dump_ifinfo+69/96]
rtnetlink_dump_ifinfo_R41074f66 [] 0x45
Apr  2 15:27:47 demo2 kernel: Call Trace: [<c01d2835>]
rtnetlink_dump_ifinfo_R41074f66 [] 0x45
Apr  2 15:27:47 demo2 kernel: [netlink_dump+101/400]
netlink_kernel_create_R1c6e148c [] 0x105
Apr  2 15:27:47 demo2 kernel: [<c01d98d5>] netlink_kernel_create_R1c6e148c [] 0x105
Apr  2 15:27:47 demo2 kernel: [netlink_dump_start+217/240]
netlink_dump_start_Rbe82e2fd [] 0xd9
Apr  2 15:27:47 demo2 kernel: [<c01d9ad9>] netlink_dump_start_Rbe82e2fd [] 0xd9
Apr  2 15:27:47 demo2 kernel: [__alloc_pages+117/768] __alloc_pages_R1c3fd81e []
0x75
Apr  2 15:27:47 demo2 kernel: [<c0131615>] __alloc_pages_R1c3fd81e [] 0x75
Apr  2 15:27:47 demo2 kernel: [rtnetlink_rcv+469/1072]
rtnetlink_dump_ifinfo_R41074f66 [] 0x375
Apr  2 15:27:47 demo2 kernel: [<c01d2b65>] rtnetlink_dump_ifinfo_R41074f66 [] 0x375
Apr  2 15:27:47 demo2 kernel: [rtnetlink_dump_ifinfo+0/96]
rtnetlink_dump_ifinfo_R41074f66 [] 0x0
Apr  2 15:27:47 demo2 kernel: [<c01d27f0>] rtnetlink_dump_ifinfo_R41074f66 [] 0x0
Apr  2 15:27:47 demo2 kernel: [rtnetlink_done+0/16]
rtnetlink_dump_ifinfo_R41074f66 [] 0x190
Apr  2 15:27:47 demo2 kernel: [<c01d2980>] rtnetlink_dump_ifinfo_R41074f66 [] 0x190
Apr  2 15:27:47 demo2 kernel: [handle_mm_fault+202/336] vmtruncate_R9c202b8b []
0x80a
Apr  2 15:27:47 demo2 kernel: [<c012596a>] vmtruncate_R9c202b8b [] 0x80a
Apr  2 15:27:47 demo2 kernel: [netlink_data_ready+26/112]
netlink_set_err_Rd01a585a [] 0x3da
Apr  2 15:27:47 demo2 kernel: [<c01d977a>] netlink_set_err_Rd01a585a [] 0x3da
Apr  2 15:27:47 demo2 kernel: [netlink_unicast+624/704]
netlink_unicast_R45ffd7af [] 0x270
Apr  2 15:27:47 demo2 kernel: [<c01d9180>] netlink_unicast_R45ffd7af [] 0x270
Apr  2 15:27:47 demo2 kernel: [netlink_sendmsg+506/528]
netlink_set_err_Rd01a585a [] 0x26a
Apr  2 15:27:47 demo2 kernel: [<c01d960a>] netlink_set_err_Rd01a585a [] 0x26a
Apr  2 15:27:47 demo2 kernel: [filemap_nopage+188/608] filemap_nopage_Rdd6c2f52
[] 0xbc
Apr  2 15:27:47 demo2 kernel: [<c01293fc>] filemap_nopage_Rdd6c2f52 [] 0xbc
Apr  2 15:27:47 demo2 kernel: [sock_sendmsg+108/144] sock_sendmsg_R95dd64b9 [] 0x6c
Apr  2 15:27:47 demo2 kernel: [<c01c64ac>] sock_sendmsg_R95dd64b9 [] 0x6c
Apr  2 15:27:47 demo2 kernel: [move_addr_to_kernel+50/80]
move_addr_to_kernel_R5dfa4696 [] 0x32
Apr  2 15:27:47 demo2 kernel: [<c01c5fd2>] move_addr_to_kernel_R5dfa4696 [] 0x32
Apr  2 15:27:47 demo2 kernel: [sys_sendto+208/240] sys_sendto_R599b4265 [] 0xd0
Apr  2 15:27:47 demo2 kernel: [<c01c7270>] sys_sendto_R599b4265 [] 0xd0
Apr  2 15:27:47 demo2 kernel: [sock_def_readable+41/96]
sock_no_sendpage_R46005802 [] 0x1b9
Apr  2 15:27:47 demo2 kernel: [<c01c91d9>] sock_no_sendpage_R46005802 [] 0x1b9
Apr  2 15:27:47 demo2 kernel: [tulip:tulip_refill_rx+83/1328] tulip_refill_rx
[tulip] 0x53
Apr  2 15:27:47 demo2 kernel: [<d009b813>] tulip_refill_rx [tulip] 0x53
Apr  2 15:27:47 demo2 kernel: [packet_rcv+550/640] ip_rt_ioctl_R94208e84 [] 0x9d96
Apr  2 15:27:47 demo2 kernel: [<c020c086>] ip_rt_ioctl_R94208e84 [] 0x9d96
Apr  2 15:27:47 demo2 kernel: [tulip:tulip_interrupt+2372/2480] tulip_interrupt
[tulip] 0x944
Apr  2 15:27:47 demo2 kernel: [<d009c634>] tulip_interrupt [tulip] 0x944
Apr  2 15:27:47 demo2 kernel: [tulip:tulip_media_cap+12749/14752]
tulip_media_cap [tulip] 0x31cd
Apr  2 15:27:47 demo2 kernel: [<d00a646d>] tulip_media_cap [tulip] 0x31cd
Apr  2 15:27:47 demo2 kernel: [net_rx_action+426/640]
net_call_rx_atomic_Rf23efb98 [] 0x1da
Apr  2 15:27:47 demo2 kernel: [<c01cdaea>] net_call_rx_atomic_Rf23efb98 [] 0x1da
Apr  2 15:27:47 demo2 kernel: [sys_socketcall+315/512] sys_socketcall_R3de7ffe4
[] 0x13b
Apr  2 15:27:47 demo2 kernel: [<c01c7a6b>] sys_socketcall_R3de7ffe4 [] 0x13b
Apr  2 15:27:47 demo2 kernel: [system_call+51/56] sys_sigaltstack_Rab65536b []
0xdbb
Apr  2 15:27:47 demo2 kernel: [<c010897b>] sys_sigaltstack_Rab65536b [] 0xdbb
Apr  2 15:27:47 demo2 kernel:
Apr  2 15:27:47 demo2 kernel:
Apr  2 15:27:47 demo2 kernel: Code: f2 ae f7 d1 49 83 c1 08 83 e1 fc 39 ce 0f 8c
cb 00 00 00 53
Apr  2 15:27:51 demo2 kernel:  <6>NETDEV WATCHDOG: eth1: transmit timed out
Apr  2 15:27:59 demo2 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Apr  2 15:28:23 demo2 last message repeated 3 times
Apr  2 15:28:25 demo2 login(pam_unix)[1221]: session opened for user root by
LOGIN(uid=0)
Apr  2 15:28:25 demo2  -- root[1221]: ROOT LOGIN ON tty2
Apr  2 15:28:31 demo2 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Apr  2 15:29:03 demo2 last message repeated 4 times



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


