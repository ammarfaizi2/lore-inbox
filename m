Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbTIDWi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbTIDWiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:38:25 -0400
Received: from smtp5.wanadoo.nl ([194.134.35.176]:51211 "EHLO smtp5.wanadoo.nl")
	by vger.kernel.org with ESMTP id S265533AbTIDWhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:37:41 -0400
Message-ID: <3F57BEA8.4000005@wanadoo.nl>
Date: Fri, 05 Sep 2003 00:37:28 +0200
From: Erwin Gribnau <e.gribnau@wanadoo.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030816
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS: 2.4.22 unpatched (probably in Myson/fealnx ethernet code)
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Couldn't find the maintainer of the Myson/fealnx driver in MAINTAINERS, 
so I'm posting here.

The oops appears to be related to recently added network cards. I think 
it goes down somewhere in intr_handler in drivers/net/fealnx.c, but as 
this is my first attempt at analyzing an oops, please forgive me if I'm 
wrong.

I'm watching the list.

(Closely following REPORTING-BUGS)
[1] Summary: OOPS on 2.4.22 unpatched, in network code

[2] Description: After adding 2 new network cards (for id see lspci 
output below, sold as Sweex Lancard) last saturday, my system crashed 
twice running 2.4.19 (unpatched) on saturday, once running 2.4.22 
(unpatched) on sunday. Stable after that until this evening, running a 
distcc'ed build from that machine, it went down for the fourth time. :-(
I can supply a ksymoops'ed version of the 2.4.19 crash too (pretty 
similar...) but did not include it yet, the mail is already pretty long. 
Please note the strange output of /proc/ioports and /proc/iomem (the 
symbols)
The network cards were very cheap, so I won't be surprised if it's a 
hardware problem.

[3] Keywords: Hmm, networking I guess...

[4] Kernel version: Linux version 2.4.22 (root@server.thuis.nl) (gcc 
version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #6 Sat 
Aug 30 15:01:58 CEST 2003

[5] Oops message through ksymoops:
ksymoops 2.4.9 on i586 2.4.22.  Options used
      -V (default)
      -k /proc/ksyms (specified)
      -l /proc/modules (specified)
      -o /lib/modules/2.4.22/ (specified)
      -m /usr/src/linux/System.map (specified)

CPU: 0
EIP: 0010:[<c019edd3>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010266
eax: 00045ab2 ebx: 00000000 ecx: c1086020 edx: 00000000
esi: c1088160 edi: 00000018 ebp: 00000001 esp: c1531cec
ds: 0018 es: 0018 ss: 0018
Process gcc (pid: 16668, stackpage=c1531000)
Stack: 00000014 00006100 c0a8ea00 04000001 c1531d48 00000009 c010822d 
00000009
        c1088000 c1531d48 c0290a20 00000009 c1531d48 c0a8ea00 c01083a8 
00000009
        c1531d48 c0a8ea00 c11a719c c1df3880 c11a70e0 c1085080 c010a828 
c11a719c
Call Trace:     [<c010822d>] [<c01083a8>] [<c010a828>] [<c01e658e>] 
[<c01e6ab2>]
    [<c01dc27d>] [<c01d4400>] [<c01d4060>] [<c01f7ff3>] [<c01bff7c>] 
[<c01c75b0>]
    [<c01c2992>] [<c01dbb67>] [<c01c0206>] [<c0128711>] [<c0127f6c>] 
[<c01286d0>]
    [<c012890a>] [<c01286d0>] [<c01289a1>] [<c01070d3>]
Code: ff 4a 74 0f 94 c0 84 c0 0f 85 8f 01 00 00 8b 86 a0 00 00 00
 >>EIP; c019edd3 <intr_handler+163/390>   <=====

 >>ecx; c1086020 <_end+dcbc88/2d65cc8>
 >>esi; c1088160 <_end+dcddc8/2d65cc8>
 >>esp; c1531cec <_end+1277954/2d65cc8>

Trace; c010822d <handle_IRQ_event+3d/70>
Trace; c01083a8 <do_IRQ+68/b0>
Trace; c010a828 <call_do_IRQ+5/d>
Trace; c01e658e <tcp_transmit_skb+13e/450>
Trace; c01e6ab2 <tcp_push_one+72/b0>
Trace; c01dc27d <tcp_sendmsg+64d/f90>
Trace; c01d4400 <ip_rcv_finish+0/1d0>
Trace; c01d4060 <ip_local_deliver+30/60>
Trace; c01f7ff3 <inet_sendmsg+33/40>
Trace; c01bff7c <sock_sendmsg+5c/90>
Trace; c01c75b0 <netif_receive_skb+b0/140>
Trace; c01c2992 <sock_no_sendpage+b2/c0>
Trace; c01dbb67 <tcp_sendpage+37/100>
Trace; c01c0206 <sock_sendpage+56/60>
Trace; c0128711 <file_send_actor+41/f0>
Trace; c0127f6c <do_generic_file_read+20c/440>
Trace; c01286d0 <file_send_actor+0/f0>
Trace; c012890a <common_sendfile+14a/1a0>
Trace; c01286d0 <file_send_actor+0/f0>
Trace; c01289a1 <sys_sendfile+41/70>
Trace; c01070d3 <system_call+33/40>

Code;  c019edd3 <intr_handler+163/390>
00000000 <_EIP>:
Code;  c019edd3 <intr_handler+163/390>   <=====
    0:   ff 4a 74                  decl   0x74(%edx)   <=====
Code;  c019edd6 <intr_handler+166/390>
    3:   0f 94 c0                  sete   %al
Code;  c019edd9 <intr_handler+169/390>
    6:   84 c0                     test   %al,%al
Code;  c019eddb <intr_handler+16b/390>
    8:   0f 85 8f 01 00 00         jne    19d <_EIP+0x19d>
Code;  c019ede1 <intr_handler+171/390>
    e:   8b 86 a0 00 00 00         mov    0xa0(%esi),%eax

<0>Kernel panic: Aiee, killing interrupt handler!

[6] Sorry, cannot include code to recreate it, seems to be related to 
network traffic

[7.1] Software (add the output of the ver_linux script here)
Linux server.thuis.nl 2.4.22 #6 Sat Aug 30 15:01:58 CEST 2003 i586 
Pentium MMX GenuineIntel GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.33
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15
Modules Loaded         ppp_synctty ppp_async ppp_generic slhc 
ipt_MASQUERADE iptable_mangle ipt_state iptable_filter ip_nat_ftp 
iptable_nat ip_tables ip_conntrack_ftp ip_conntrack

[7.2] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 200.457
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 399.76

[7.3.] Module information (from /proc/modules):
ppp_synctty             5856   0 (unused)
ppp_async               7360   1
ppp_generic            15644   3 [ppp_synctty ppp_async]
slhc                    5088   0 [ppp_generic]
ipt_MASQUERADE          1240   1 (autoclean)
iptable_mangle          2072   0 (autoclean) (unused)
ipt_state                536   2 (autoclean)
iptable_filter          1644   1 (autoclean)
ip_nat_ftp              2672   0 (unused)
iptable_nat            15960   2 [ipt_MASQUERADE ip_nat_ftp]
ip_tables              12256   7 [ipt_MASQUERADE iptable_mangle 
ipt_state iptable_filter iptable_nat]
ip_conntrack_ftp        3824   1
ip_conntrack           18376   3 [ipt_MASQUERADE ipt_state ip_nat_ftp 
iptable_nat ip_conntrack_ftp]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
6000-601f : Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II]
6100-61ff : MYSON Technology Inc SURECOM EP-320X-S 100/10M Ethernet PCI 
Adapter
   6100-61ff : 
6200-62ff : MYSON Technology Inc SURECOM EP-320X-S 100/10M Ethernet PCI 
Adapter (#2)
   6200-62ff : 
f000-f00f : Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
   f000-f007 : ide0
   f008-f00f : ide1

/proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-027fffff : System RAM
   00100000-0020b81a : Kernel code
   0020b81b-0027d043 : Kernel data
e0000000-e00003ff : MYSON Technology Inc SURECOM EP-320X-S 100/10M 
Ethernet PCI Adapter
   e0000000-e00003ff : 
e0001000-e00013ff : MYSON Technology Inc SURECOM EP-320X-S 100/10M 
Ethernet PCI Adapter (#2)
   e0001000-e00013ff : 
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 430VX - 82437VX TVX [Triton VX] (rev 02)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32

00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] 
(rev 01)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] 
(prog-if 80 [Master])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II] 
(rev 01) (prog-if 00 [UHCI])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at 6000 [size=32]

00:0b.0 Ethernet controller: MYSON Technology Inc SURECOM EP-320X-S 
100/10M Ethernet PCI Adapter
         Subsystem: MYSON Technology Inc SURECOM EP-320X-S 100/10M 
Ethernet PCI Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (8000ns min, 16000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at 6100 [size=256]
         Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [88] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA 
PME(D0-,D1+,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: MYSON Technology Inc SURECOM EP-320X-S 
100/10M Ethernet PCI Adapter
         Subsystem: MYSON Technology Inc SURECOM EP-320X-S 100/10M 
Ethernet PCI Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (8000ns min, 16000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at 6200 [size=256]
         Region 1: Memory at e0001000 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [88] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA 
PME(D0-,D1+,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
No SCSI


-- 
If it doesn't fit, use a bigger hammer...

