Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTHGPRp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270322AbTHGPRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:17:44 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:59076 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265069AbTHGPKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:10:10 -0400
Date: Thu, 07 Aug 2003 08:09:34 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: temnota@kmv.ru
Subject: [Bug 1054] New: loading iptables modules kill raid5 kernel thread 
Message-ID: <33160000.1060268974@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1054

           Summary: loading iptables modules kill raid5 kernel thread
    Kernel Version: 2.4.22-pre10
            Status: NEW
          Severity: normal
             Owner: laforge@gnumonks.org
         Submitter: temnota@kmv.ru


Distribution: RedHat 7.1
Hardware Environment: HP NetServer 5/LS

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 5
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse msr mce cx8 apic
bogomips        : 53.04

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 5
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse msr mce cx8 apic
bogomips        : 53.24

$ lspci -v
00:00.0 Host bridge: Intel Corporation 82452KX/GX [Orion] (rev 02)
        Flags: bus master, medium devsel, latency 6

00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
01)        Flags: bus master, medium devsel, latency 66, IRQ 10
        Memory at ffe7f000 (32-bit, prefetchable) [size=4K]
        I/O ports at ef80 [size=32]
        Memory at ff600000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]

00:0e.0 Non-VGA unclassified device: Intel Corporation 82375EB (rev 05)
        Flags: bus master, medium devsel, latency 248

00:0f.0 Class ff00: Intel Corporation: Unknown device 0008
        Subsystem: Unknown device ec08:ffe7
        Flags: fast devsel
        Memory at ffe7ec00 (32-bit, prefetchable) [size=1K]
        Memory at 12000000 (32-bit, prefetchable) [size=1K]
        Memory at 12000400 (32-bit, prefetchable) [size=1K]
        Memory at 12000800 (32-bit, prefetchable) [size=1K]
        Memory at 12000c00 (32-bit, prefetchable) [size=1K]
        Memory at 12001000 (32-bit, prefetchable) [size=1K]
        Expansion ROM at fffff800 [disabled] [size=2K]

01:00.0 Host bridge: Intel Corporation 82452KX/GX [Orion] (rev 02)
        Flags: bus master, medium devsel, latency 6

01:0c.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
       Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
        Flags: bus master, medium devsel, latency 66, IRQ 9
        Memory at ffcfe000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at f8c0 [size=64]
        Memory at ffb00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

01:0d.0 SCSI storage controller: Adaptec AHA-294x / AIC-7870 (rev 03)
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at fc00 [disabled] [size=256]
        Memory at ffcff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

01:0e.0 SCSI storage controller: Adaptec AHA-294x / AIC-7870 (rev 03)
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at f400 [disabled] [size=256]
        Memory at ffcfd000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

$ cat /proc/modules

ipt_TOS                 1008   0
ipt_tos                  448   0 (unused)
iptable_mangle          2144   1
ipt_TCPMSS              2336   3
ipt_tcpmss               800   0 (unused)
ipt_LOG                 3568  20
ipt_MARK                 720   0 (unused)
ipt_REDIRECT             768   0 (unused)
iptable_nat            23264   1 [ipt_REDIRECT]
ipt_REJECT              3136   0 (unused)
ipt_mac                  656  12
ipt_mark                 464   0 (unused)
ipt_multiport            640   0 (unused)
iptable_filter          1712   1
ipt_state                576   8
ipt_limit               1216 171
ip_conntrack_ftp        4512   0 (unused)
ip_conntrack           29664   3 [ipt_REDIRECT iptable_nat ipt_state ip_conntrack_ftp]
ip_tables              15008  18 [ipt_TOS ipt_tos iptable_mangle ipt_TCPMSS ipt_tcpmss ipt_LOG ipt_MARK ipt_REDIRECT iptable_nat ipt_REJECT ipt_mac ipt_mark ipt_multiport iptable_filter ipt_state ipt_limit]

Software Environment:
Software Raid5 + iptables modules

Problem Description: 
When raid recovery discs (after unclean shutdown), loading iptables modules 
kill radi5 kernel thread

Unable to handle kernel NULL pointer dereference at virtual address
00000212
c102c04d
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c102c04d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: d0355bb3   ebx: 00000001   ecx: c102c01c   edx: 00000212
esi: 00000019   edi: d1af3000   ebp: d1af4000   esp: d1d95dec
ds: 0018   es: 0018   ss: 0018
Process raid5d (pid: 13, stackpage=d1d95000)
Stack: c0113b18 00000212 d1af3cc0 c010ca6a d1af3cc0 d1af5cc0 d1af4cc0 00000019
       d1af3000 d1af4000 0080e85d 00000018 00000018 fffffffb c01fb83a 00000010
       00000282 00000003 d1af6c00 c01fbef7 00001000 d1af4000 d1af3000 d1af5000
Call Trace:    [<c0113b18>] [<c010ca6a>] [<c01fb83a>] [<c01fbef7>] [<c01f734e>]
  [<c01b1261>] [<c01f82e6>] [<c01bb224>] [<c01f8ae1>] [<c01f8a10>] [<c0200515>]
  [<c0105883>] [<c0200370>]
Code: c0 02 c1 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

>> EIP; c102c04d <_end+cae92d/124d9940>   <=====
Trace; c0113b18 <smp_call_function_interrupt+28/3e>
Trace; c010ca6a <call_call_function_interrupt+5/b>
Trace; c01fb83a <xor_8regs_3+3a/70>
Trace; c01fbef7 <xor_block+87/b0>
Trace; c01f734e <compute_block+8e/d0>
Trace; c01b1261 <generic_make_request+d1/130>
Trace; c01f82e6 <handle_stripe+af6/de0>
Trace; c01bb224 <scsi_dispatch_cmd+144/520>
Trace; c01f8ae1 <raid5d+d1/1e0>
Trace; c01f8a10 <raid5d+0/1e0>
Trace; c0200515 <md_thread+1a5/2a0>
Trace; c0105883 <arch_kernel_thread+23/30>
Trace; c0200370 <md_thread+0/2a0>
Code;  c102c04d <_end+cae92d/124d9940>
00000000 <_EIP>:
Code;  c102c04d <_end+cae92d/124d9940>
   0:   c0 02 c1                  rolb   $0xc1,(%edx)

Unable to handle kernel NULL pointer dereference at virtual address 00000217
c102c04d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c102c04d>]    Not tainted
EFLAGS: 00010082
eax: cb189bb3   ebx: 00000001   ecx: c102c01c   edx: 00000217
esi: 00000021   edi: d1c51000   ebp: d1c52000   esp: d1d95dec
ds: 0018   es: 0018   ss: 0018
Process raid5d (pid: 13, stackpage=d1d95000)
Stack: c0113b18 00000217 d1c51bc0 c010ca6a d1c51bc0 d1c53be0 d1c52bc0 00000021
       d1c51000 d1c52000 807944a9 00000018 00000018 fffffffb c01fb85b 00000010
       00000286 00000003 d1c54c00 c01fbef7 00001000 d1c52000 d1c51000 d1c53000
Call Trace:    [<c0113b18>] [<c010ca6a>] [<c01fb85b>] [<c01fbef7>] [<c01f734e>]
  [<c01b1261>] [<c01f82e6>] [<c01bb224>] [<c01f8ae1>] [<c01f8a10>] [<c0200515>]
  [<c0105883>] [<c0200370>]
Code: c0 02 c1 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

>> EIP; c102c04d <_end+cae92d/124d9940>   <=====
Trace; c0113b18 <smp_call_function_interrupt+28/3e>
Trace; c010ca6a <call_call_function_interrupt+5/b>
Trace; c01fb85b <xor_8regs_3+5b/70>
Trace; c01fbef7 <xor_block+87/b0>
Trace; c01f734e <compute_block+8e/d0>
Trace; c01b1261 <generic_make_request+d1/130>
Trace; c01f82e6 <handle_stripe+af6/de0>
Trace; c01bb224 <scsi_dispatch_cmd+144/520>
Trace; c01f8ae1 <raid5d+d1/1e0>
Trace; c01f8a10 <raid5d+0/1e0>
Trace; c0200515 <md_thread+1a5/2a0>
Trace; c0105883 <arch_kernel_thread+23/30>
Trace; c0200370 <md_thread+0/2a0>
Code;  c102c04d <_end+cae92d/124d9940>
00000000 <_EIP>:
Code;  c102c04d <_end+cae92d/124d9940>
   0:   c0 02 c1                  rolb   $0xc1,(%edx)

Steps to reproduce:

raidsetfaulty /dev/md0 /dev/sde1
raidhotremove /dev/md0 /dev/sde1
raidhotadd /dev/md0 /dev/sde1

and load iptables modules. OOPS


