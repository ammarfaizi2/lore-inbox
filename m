Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130150AbRBLMWh>; Mon, 12 Feb 2001 07:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129920AbRBLMW3>; Mon, 12 Feb 2001 07:22:29 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:41920 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S129273AbRBLMWN>; Mon, 12 Feb 2001 07:22:13 -0500
Date: Mon, 12 Feb 2001 13:13:34 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>
cc: <linux-net@vger.kernel.org>
Subject: ATM-related (?) kernel crashes (Linux 2.2.13/2.4.1)
Message-ID: <Pine.LNX.4.30.0102121311110.18788-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

For more than 1 year, I had been running a machine with a
ForeRunnerLE ATM NIC (2 LECs in different VLANs, Kernel 2.2.13,
atm-0.59) without any major problems. For some reason, with the
end of the last year, this peaceful time was also over (the
y2k+1-problem ? ;-). Ever since then, the kernel always crashed
after at most 1 week of uptime (usually during the night without
any substantial load).

The configuration of the machine in question has been the same all the
time. There has been a software upgrade on the ATM Switches (also
from Fore System) about 2 weeks before the crashes started - the only
factor I can think of, that might play a role. However, there is
another machine with identical hardware (HP Netserver LC3, PII-350,
128Mb RAM, AIC 7880 SCSI, Intel EtherPro100 NIC, ForeRunnerLE) and
almost identical software, that (at least so far) continues to run
without any problem.

The hardware functions correctly (replacing it doesn't have any
effect). The only differences to the unstable system that I can think
of are:

- The ethernet interface is actually in use
- xntpd
- NFS server
- DHCP server

I could imagine the latter to make a difference, because it causes
some untypical network traffic (UDP broadcast).

Some time ago, I upgraded to Linux 2.4.1 and atm-0.78, hoping that
this might help - no change. Below are oops reports of the last 3
crashes. It looks to me, like a bug somewhere in the ATM driver is
causing the trouble, but I am (fortunately ;-) not an expert for
deciphering kernel crashes. Maybe somebody here can figure out, what
is going on? If you need any further information, please let me know.

Regards,
                Peter Daum

 - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8<
# from /proc/pci:

Bus  1, device   2, function  0:
  ATM network controller: Integrated Device Tech IDT77211 ATM Adapter (rev 3).
    IRQ 10.
    Master Capable.  Latency=32.  Min Gnt=5.Max Lat=5.
    I/O at 0xe800 [0xe8ff].
    Non-prefetchable 32 bit memory at 0xfeafe000 [0xfeafefff].

 - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8<

Options used: -v /boot/vmlinux-2.4.1-atm (specified)
              -o /lib/modules/2.4.1/ (default)
              -k /proc/ksyms (default)
              -l /proc/modules (default)
              -m /boot/lnx-2.4.1-atm.map (specified)
              -c 1 (default)

No modules in ksyms, skipping objects
Oops: 0000
CPU:    0
EIP:    0010:[<c0219b40>]
EFLAGS: 00010202
eax: 00000161   ebx: c6384580   ecx: c638522c   edx: 00000000
esi: 00000000   edi: c63f8800   ebp: 00000286   esp: c029be78
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c029b000)
Stack: c65c0bc0 c6466400 c6384580 c6466400 c6466400 c6466540 c63851c0 c01e4b1e
       c6384580 c6466400 c6466400 00000000 c64442a0 c01e0c8d c6466400 c5cd5160
       c6384580 c01e3b63 c6384580 c64442dc c01e4670 c64442ce c64442c8 c01e37e6
Call Trace: [<c01e4b1e>] [<c01e0c8d>] [<c01e3b63>] [<c01e4670>] [<c01e37e6>] [<c02002bc>] [<c01e110e>]
       [<c0115cdf>] [<c010a151>] [<c01071f0>] [<c01071f0>] [<c0108ed0>] [<c01071f0>] [<c01071f0>] [<c0100018>]
       [<c0107213>] [<c0107279>] [<c0105000>] [<c0100191>]
Code: 3b 82 8c 00 00 00 73 28 8b 43 74 01 87 94 00 00 00 8b 54 24

>>EIP: c0219b40 <lec_send_packet+29c/2f8>
Trace: c01e4b1e <qdisc_restart+4e/c8>
Trace: c01e0c8d <dev_queue_xmit+35/11c>
Trace: c01e3b63 <neigh_resolve_output+e7/158>
Trace: c01e4670 <eth_header_cache_update+0/2c>
Trace: c01e37e6 <neigh_update+256/308>
Trace: c02002bc <arp_rcv+3a0/400>
Trace: c01e110e <net_rx_action+12e/208>
Trace: c0115cdf <do_softirq+3f/64>
Trace: c0107213 <default_idle+23/28>
Code:  c0219b40 <lec_send_packet+29c/2f8>      00000000 <_EIP>: <===
Code:  c0219b40 <lec_send_packet+29c/2f8>         0:	3b 82 8c 00 00 00    	cmp    0x8c(%edx),%eax <===
Code:  c0219b46 <lec_send_packet+2a2/2f8>         6:	73 28                	jae     c0219b70 <lec_send_packet+2cc/2f8>
Code:  c0219b48 <lec_send_packet+2a4/2f8>         8:	8b 43 74             	mov    0x74(%ebx),%eax
Code:  c0219b4b <lec_send_packet+2a7/2f8>         b:	01 87 94 00 00 00    	add    %eax,0x94(%edi)
Code:  c0219b51 <lec_send_packet+2ad/2f8>        11:	8b 54 24 00          	mov    0x0(%esp,1),%edx

Kernel panic: Aiee, killing interrup

5 warnings issued.  Results may not be reliable.
Warning: ksyms_base symbol drive_info_R__ver_drive_info not found in vmlinux.  Ignoring ksyms_base entry
Warning: trailing garbage ignored on Code: line
  Text: 'Code: 3b 82 8c 00 00 00 73 28 8b 43 74 01 87 94 00 00 00 8b 54 24 '
  Garbage: ' '

 - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8<

Oops: 0000
CPU:    0
EIP:    0010:[<c0219ac6>]
EFLAGS: 00010206
eax: 0000005c   ebx: c12d18a0   ecx: c2821f2c   edx: 00000000
esi: c12d06e0   edi: c288da00   ebp: 00000286   esp: c1aa1d94
ds: 0018   es: 0018   ss: 0018
Process ping (pid: 386, stackpage=c1aa1000)
Stack: c6957be0 c3efd000 c12d18a0 00000040 c3efd000 c3efd140 c2821ec0 c01e4b1e
       c12d18a0 c3efd000 c3efd000 00000000 c12d18a0 c01e0c8d c3efd000 c12d18a0
       c7a659a0 c01ea43d c12d18a0 c01fda78 c2862e70 c01eaf4c c12d18a0 fffffff3
Call Trace: [<c01e4b1e>] [<c01e0c8d>] [<c01ea43d>] [<c01fda78>] [<c01eaf4c>] [<c01fddd5>] [<c01fda78>]
       [<c0203519>] [<c01dc4e5>] [<c01dd13c>] [<ffff0000>] [<c01dd90b>] [<c0108e27>]
Code: 3b 82 8c 00 00 00 73 25 8b 46 74 01 87 94 00 00 00 8b 54 24

>>EIP: c0219ac6 <lec_send_packet+222/2f8>
Trace: c01e4b1e <qdisc_restart+4e/c8>
Trace: c01e0c8d <dev_queue_xmit+35/11c>
Trace: c01ea43d <ip_output+99/d0>
Trace: c01fda78 <raw_getfrag+0/24>
Trace: c01eaf4c <ip_build_xmit+26c/2ec>
Trace: c01fddd5 <raw_sendmsg+285/2f0>
Trace: c01fda78 <raw_getfrag+0/24>
Trace: c0203519 <inet_sendmsg+39/40>
Code:  c0219ac6 <lec_send_packet+222/2f8>      00000000 <_EIP>: <===
Code:  c0219ac6 <lec_send_packet+222/2f8>         0:	3b 82 8c 00 00 00    	cmp    0x8c(%edx),%eax <===
Code:  c0219acc <lec_send_packet+228/2f8>         6:	73 25                	jae     c0219af3 <lec_send_packet+24f/2f8>
Code:  c0219ace <lec_send_packet+22a/2f8>         8:	8b 46 74             	mov    0x74(%esi),%eax
Code:  c0219ad1 <lec_send_packet+22d/2f8>         b:	01 87 94 00 00 00    	add    %eax,0x94(%edi)
Code:  c0219ad7 <lec_send_packet+233/2f8>        11:	8b 54 24 00          	mov    0x0(%esp,1),%edx

Kernel panic: Aiee, killing interrupt handler!

5 warnings issued.  Results may not be reliable.
Warning: ksyms_base symbol drive_info_R__ver_drive_info not found in vmlinux.  Ignoring ksyms_base entry
Warning: trailing garbage ignored on Code: line
  Text: 'Code: 3b 82 8c 00 00 00 73 25 8b 46 74 01 87 94 00 00 00 8b 54 24 '
  Garbage: ' '

 - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8< -

ksymoops 2.3.7 on i686 2.4.1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1/ (default)
     -m /boot/lnx-2.4.1-atm.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol drive_info_R__ver_drive_info not found in System.map.  Ignoring ksyms_base entry
Oops: 0000
CPU:    0
EIP:    0010:[<c01103e8>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010017
eax: c62c14d4   ebx: 00150011   ecx: 00000001   edx: c62c14d8
esi: c12c25af   edi: 00150009   ebp: c029bee8   esp: c029becc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c029b000)
Stack: c6314660 c12c25af c631466f c62c14d8 00000086 00000001 00000003 c6314664
       c0216b86 c021a6e4 c62c1400 ffffffe0 c6314660 c021ac58 c6314660 c63d9140
       c021aabc 00000000 c029bfa4 00109693 c63146cc 0000000d 00000246 00000001
Call Trace: [<c0216b86>] [<c021a6e4>] [<c21ac58>] [<c021aabc>] [<c0118962>] [<c010ccbb>] [<c0115e9f>]
       [<c0115dd8>] [<c0115cdf>] [<c010a151>] [<c01071f0>] [<c01071f0>] [<c0108ed0>] [<c01071f0>] [<c01071f0>]
       [<c0100018>] [<c0107213>] [<c0107279>] [<c0105000>] [<c0100191>]
Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 4c 9c 5e fa c7 01 00 00 00

>>EIP; c01103e8 <__wake_up+28/98>   <=====
Trace; c0216b86 <atm_async_release_vcc+2a/2c>
Trace; c021a6e4 <lec_arp_clear_vccs+20/54>
Trace; 0c21ac58 Before first symbol
Trace; c021aabc <lec_arp_check_expire+0/2c8>
Trace; c0118962 <timer_bh+222/25c>
Trace; c010ccbb <timer_interrupt+5f/108>
Trace; c0115e9f <bh_action+1b/60>
Trace; c0115dd8 <tasklet_hi_action+3c/60>
Trace; c0115cdf <do_softirq+3f/64>
Trace; c010a151 <do_IRQ+a1/b0>
Trace; c01071f0 <default_idle+0/28>
Trace; c01071f0 <default_idle+0/28>
Trace; c0108ed0 <ret_from_intr+0/20>
Trace; c01071f0 <default_idle+0/28>
Trace; c01071f0 <default_idle+0/28>
Trace; c0100018 <startup_32+18/139>
Trace; c0107213 <default_idle+23/28>
Trace; c0107279 <cpu_idle+41/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c01103e8 <__wake_up+28/98>
00000000 <_EIP>:
Code;  c01103e8 <__wake_up+28/98>   <=====
   0:   8b 4f 04                  mov    0x4(%edi),%ecx   <=====
Code;  c01103eb <__wake_up+2b/98>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c01103ed <__wake_up+2d/98>
   5:   8b 01                     mov    (%ecx),%eax
Code;  c01103ef <__wake_up+2f/98>
   7:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c01103f2 <__wake_up+32/98>
   a:   74 4c                     je     58 <_EIP+0x58> c0110440 <__wake_up+80/98>
Code;  c01103f4 <__wake_up+34/98>
   c:   9c                        pushf
Code;  c01103f5 <__wake_up+35/98>
   d:   5e                        pop    %esi
Code;  c01103f6 <__wake_up+36/98>
   e:   fa                        cli
Code;  c01103f7 <__wake_up+37/98>
   f:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Kernel panic: Aiee, killing interrupt handler!

2 warnings issued.  Results may not be reliable.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
