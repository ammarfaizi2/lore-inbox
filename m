Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311572AbSDBME5>; Tue, 2 Apr 2002 07:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311424AbSDBMEk>; Tue, 2 Apr 2002 07:04:40 -0500
Received: from radium.jvb.tudelft.nl ([130.161.82.13]:54657 "EHLO
	radium.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S311572AbSDBME2>; Tue, 2 Apr 2002 07:04:28 -0500
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Oopses in 2.4.18-ac3 TEQL networking code
Date: Tue, 2 Apr 2002 14:03:16 +0200
Message-ID: <00f701c1da3e$61356000$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since a while now I experience oopses on one of my machines once in a
while. The machine is a samba file server with a trunked 2x100 mbit
network connection (2 3com905's), and currently using kernel 2.4.18-ac3.
I been following the latest 18-pre-ac kernels and the problem is present
for a while now. The machine hard locks from time to time (approximately
once or twice a week). Below two decoded oopses. I hand copied them from
screen, as the machine was stuck dead. It appears to oops in the
interface trunking code.

Anyone know what's going on here?

Regards,
- Robbert Kouprie

First trace:

server:~$ ksymoops -m /System.map < oops_20020401.txt 
ksymoops 2.4.3 on i686 2.4.18-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-ac3/ (default)
     -m /System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid
lsmod file?
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01bf98a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000060   ebx: efc6b400   ecx: ef4726a0   edx: edb76340
esi: c024d760   edi: ef4726a0   ebp: ced1b220   esp: d346bc74
ds: 0018   es: 0018   ss: 0018
Process smbd (pid: 26395, stackpage=d346b000)
Stack: efc6b400 c024d760 ef4726a0 ced1b220 00000060 c01bfb62 ced1b220
00000000
       efc6b400 efe1bb60 c024d7a0 ced1b220 d66916e0 00000000 000005dc
00000000
       00000000 ef4726a0 c01bd0de ced1b220 c024d7a0 c028ff88 c024d7a0
00000000
Call Trace: [<c01bfb62>] [<c01bd0de>] [<c01b6f2e>] [<c01c786f>]
[<c01c8e6a>]
   [<c01c8d2c>] [<c01bc906>] [<c01c7d6d>] [<c01c8d2c>] [<c01da3b7>]
[<c01d599e>]
   [<c01d5a3b>] [<c01d5d2f>] [<c01ccb12>] [<c01db0d8>] [<c01e5786>]
[<c01b0915>]
   [<c01b1675>] [<c01e5735>] [<c0122761>] [<c012296d>] [<c0122c66>]
[<c01b16b2>]
   [<c01b1e51>] [<c0106b3b>]
Code: 8b 58 08 8b 4a 04 85 c9 75 0c b8 ea ff ff ff e9 20 01 00 00

>>EIP; c01bf98a <__teql_resolve+26/160>   <=====
Trace; c01bfb62 <teql_master_xmit+9e/228>
Trace; c01bd0de <qdisc_restart+4e/c8>
Trace; c01b6f2e <dev_queue_xmit+f2/238>
Trace; c01c786e <ip_output+b2/11c>
Trace; c01c8e6a <ip_queue_xmit2+13e/20e>
Trace; c01c8d2c <ip_queue_xmit2+0/20e>
Trace; c01bc906 <nf_hook_slow+ee/144>
Trace; c01c7d6c <ip_queue_xmit+494/4e4>
Trace; c01c8d2c <ip_queue_xmit2+0/20e>
Trace; c01da3b6 <tcp_v4_send_check+6e/ac>
Trace; c01d599e <tcp_transmit_skb+43a/58c>
Trace; c01d5a3a <tcp_transmit_skb+4d6/58c>
Trace; c01d5d2e <tcp_push_one+72/fc>
Trace; c01ccb12 <tcp_sendmsg+a12/1050>
Trace; c01db0d8 <tcp_v4_do_rcv+78/154>
Trace; c01e5786 <inet_sendmsg+3a/40>
Trace; c01b0914 <sock_sendmsg+68/88>
Trace; c01b1674 <sys_sendto+d8/f8>
Trace; c01e5734 <inet_recvmsg+3c/54>
Trace; c0122760 <do_generic_file_read+250/468>
Trace; c012296c <do_generic_file_read+45c/468>
Trace; c0122c66 <generic_file_read+7e/130>
Trace; c01b16b2 <sys_send+1e/24>
Trace; c01b1e50 <sys_socketcall+118/200>
Trace; c0106b3a <system_call+32/38>
Code;  c01bf98a <__teql_resolve+26/160>
00000000 <_EIP>:
Code;  c01bf98a <__teql_resolve+26/160>   <=====
   0:   8b 58 08                  mov    0x8(%eax),%ebx   <=====
Code;  c01bf98c <__teql_resolve+28/160>
   3:   8b 4a 04                  mov    0x4(%edx),%ecx
Code;  c01bf990 <__teql_resolve+2c/160>
   6:   85 c9                     test   %ecx,%ecx
Code;  c01bf992 <__teql_resolve+2e/160>
   8:   75 0c                     jne    16 <_EIP+0x16> c01bf9a0
<__teql_resolve+3c/160>
Code;  c01bf994 <__teql_resolve+30/160>
   a:   b8 ea ff ff ff            mov    $0xffffffea,%eax
Code;  c01bf998 <__teql_resolve+34/160>
   f:   e9 20 01 00 00            jmp    134 <_EIP+0x134> c01bfabe
<__teql_resolve+15a/160>

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


Second trace:

server:~$ ksymoops -m /System.map < oops_20020402.txt  
ksymoops 2.4.3 on i686 2.4.18-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-ac3/ (default)
     -m /System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid
lsmod file?
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01bf96f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: efc6b000   ecx: e5897720   edx: 000005dc
esi: c024d760   edi: e5897720   ebp: cc5e9f00   esp: def4bc74
ds: 0018   es: 0018   ss: 0018
Process smbd (pid: 14055, stackpage=def4b000)
Stack: efc6b000 c024d760 e5897720 cc5e9f00 c024d7a0 c01bfb62 cc5e9f00
00000000
       efc6b000 efe1bb60 c024d7a0 cc5e9f00 e861bb80 00000000 000005dc
00000000
       00000000 e5897720 c01bd0de cc5e9f00 c024d7a0 c028ff88 c024d7a0
00000000
Call Trace: [<c01bfb62>] [<c01bd0de>] [<c01b6f2e>] [<c01c786f>]
[<c01c8e6a>]
   [<c01c8d2c>] [<c01bc906>] [<c01c7d6d>] [<c01c8d2c>] [<c01da3b7>]
[<c01d599e>]
   [<c01d5a3b>] [<c01d5d2f>] [<c01ccb12>] [<c01e5786>] [<c01b0915>]
[<c01b1675>]
   [<c0122505>] [<c0122761>] [<c012296d>] [<c0122c66>] [<c01b16b2>]
[<c01b1e51>]
   [<c0106b3b>]
Code: 8b 90 bc 00 00 00 83 c2 60 89 54 24 10 8b 54 24 18 8b 42 28

>>EIP; c01bf96e <__teql_resolve+a/160>   <=====
Trace; c01bfb62 <teql_master_xmit+9e/228>
Trace; c01bd0de <qdisc_restart+4e/c8>
Trace; c01b6f2e <dev_queue_xmit+f2/238>
Trace; c01c786e <ip_output+b2/11c>
Trace; c01c8e6a <ip_queue_xmit2+13e/20e>
Trace; c01c8d2c <ip_queue_xmit2+0/20e>
Trace; c01bc906 <nf_hook_slow+ee/144>
Trace; c01c7d6c <ip_queue_xmit+494/4e4>
Trace; c01c8d2c <ip_queue_xmit2+0/20e>
Trace; c01da3b6 <tcp_v4_send_check+6e/ac>
Trace; c01d599e <tcp_transmit_skb+43a/58c>
Trace; c01d5a3a <tcp_transmit_skb+4d6/58c>
Trace; c01d5d2e <tcp_push_one+72/fc>
Trace; c01ccb12 <tcp_sendmsg+a12/1050>
Trace; c01e5786 <inet_sendmsg+3a/40>
Trace; c01b0914 <sock_sendmsg+68/88>
Trace; c01b1674 <sys_sendto+d8/f8>
Trace; c0122504 <generic_file_readahead+144/150>
Trace; c0122760 <do_generic_file_read+250/468>
Trace; c012296c <do_generic_file_read+45c/468>
Trace; c0122c66 <generic_file_read+7e/130>
Trace; c01b16b2 <sys_send+1e/24>
Trace; c01b1e50 <sys_socketcall+118/200>
Trace; c0106b3a <system_call+32/38>
Code;  c01bf96e <__teql_resolve+a/160>
00000000 <_EIP>:
Code;  c01bf96e <__teql_resolve+a/160>   <=====
   0:   8b 90 bc 00 00 00         mov    0xbc(%eax),%edx   <=====
Code;  c01bf974 <__teql_resolve+10/160>
   6:   83 c2 60                  add    $0x60,%edx
Code;  c01bf976 <__teql_resolve+12/160>
   9:   89 54 24 10               mov    %edx,0x10(%esp,1)
Code;  c01bf97a <__teql_resolve+16/160>
   d:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c01bf97e <__teql_resolve+1a/160>
  11:   8b 42 28                  mov    0x28(%edx),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


lspci -vx output:

server:~$ lspci -vx
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
        Flags: bus master, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2
00: 06 11 91 06 06 00 10 22 c4 00 00 06 00 00 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e4000000-ebffffff
        Capabilities: [80] Power Management version 2
00: 06 11 98 85 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 00 e4 f0 eb f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at a000 [size=16]
        Capabilities: [c0] Power Management version 2
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 a0 00 00 00 00 00 00 00 00 00 00 06 11 71 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
        Flags: medium devsel
        Capabilities: [68] Power Management version 2
00: 06 11 57 30 00 00 90 02 40 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at b800 [size=128]
        Memory at ed024000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
00: b7 10 00 92 07 00 10 02 74 00 00 02 08 20 00 00
10: 01 b8 00 00 00 40 02 ed 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 0a 0a

00:0a.0 Unknown mass storage controller: Promise Technology, Inc.:
Unknown device 4d69 (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 11
        I/O ports at bc00 [size=8]
        I/O ports at c000 [size=4]
        I/O ports at c400 [size=8]
        I/O ports at c800 [size=4]
        I/O ports at cc00 [size=16]
        Memory at ed020000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
00: 5a 10 69 4d 07 00 30 04 02 85 80 01 08 20 00 00
10: 01 bc 00 00 01 c0 00 00 01 c4 00 00 01 c8 00 00
20: 01 cc 00 00 00 00 02 ed 00 00 00 00 5a 10 68 4d
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 04 12

00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20267
(rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d000 [size=8]
        I/O ports at d400 [size=4]
        I/O ports at d800 [size=8]
        I/O ports at dc00 [size=4]
        I/O ports at e000 [size=64]
        Memory at ed000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
00: 5a 10 30 4d 07 00 10 02 02 00 80 01 00 20 00 00
10: 01 d0 00 00 01 d4 00 00 01 d8 00 00 01 dc 00 00
20: 01 e0 00 00 00 00 00 ed 00 00 00 00 5a 10 33 4d
30: 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 00 00

00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 78)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at e400 [size=128]
        Memory at ed025000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
00: b7 10 00 92 07 00 10 02 78 00 00 02 08 20 00 00
10: 01 e4 00 00 00 50 02 ed 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0c 01 0a 0a

01:00.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev 02)
(prog-if 00 [VGA])
        Subsystem: S3 Inc. Trio3D/2X
        Flags: bus master, medium devsel, latency 32
        Memory at e4000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
        Capabilities: [80] AGP version 1.0
00: 33 53 13 8a 07 00 10 02 02 00 00 03 00 20 00 00
10: 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 33 53 13 8a
30: 00 00 00 00 dc 00 00 00 00 00 00 00 ff 00 04 ff

