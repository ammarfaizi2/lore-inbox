Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264541AbRFTSRO>; Wed, 20 Jun 2001 14:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264542AbRFTSRE>; Wed, 20 Jun 2001 14:17:04 -0400
Received: from [194.77.109.75] ([194.77.109.75]:35090 "EHLO warp.zuto.de")
	by vger.kernel.org with ESMTP id <S264541AbRFTSQu>;
	Wed, 20 Jun 2001 14:16:50 -0400
From: Rainer Clasen <bj@zuto.de>
Date: Wed, 20 Jun 2001 20:16:48 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.5 crashes ...
Message-ID: <20010620201648.B12694@zuto.de>
Reply-To: bj@zuto.de
Mail-Followup-To: bj@zuto.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:    

crash - apparently on IP traffic. Maybe related to iptables?

[2.] Full description of the problem/report:

nothing special happened. The box was running for one day. I have no clue
what caused this crash. The box acts as stateful packet filter. When
runnung nmap -sS against a host behind this box, the box crashed again.

[3.] Keywords (i.e., modules, networking, kernel):

network

[4.] Kernel version (from /proc/version):
Linux version 2.4.5 (root@warp) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Mon Jun 18 23:28:41 CEST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoringksymoops 2.3.4 on i586 2.4.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5/ (default)
     -m /boot/System.map-2.4.5-obs.6.1 (specified)

Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address 0902a819
c012610a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012610a>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 0902a801   ebx: 00000000   ecx: 0902a801   edx: 00000000
esi: c13e26e0   edi: c1268ec0   ebp: 00000060   esp: c0203ddc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0203000)
Stack: c01825ad 00000800 c13e26e0 c0182ba3 c13e26e0 c13e26e0 c1431000 c13d30a0
       c1431000 ffffffee c0185add c13e26e0 00000002 c13e26e0 00000000 c0188c58
       c13e26e0 c13e26e0 00000000 00000004 c0195fbc c0196035 c13e26e0 00000001
Call Trace: [<c01825ad>] [<c0182ba3>] [<c0185add>] [<c0188c58>] [<c0195fbc>] [<
       [<c01936b0>] [<c0195fa2>] [<c0195fbc>] [<c01936fa>] [<c018ac72>] [<c0193
       [<c01928a8>] [<c018ac72>] [<c01926f6>] [<c01928a8>] [<c018603d>] [<c0113
       [<c0106b80>] [<c0105120>] [<c0105143>] [<c01051a7>] [<c0105000>] [<c0100
Code: 8b 41 18 85 c0 7c 11 ff 49 14 0f 94 c0 84 c0 74 07 89 c8 e8

>>EIP; c012610a <__free_pages+2/1c>   <=====
Trace; c01825ad <skb_release_data+41/74>
Trace; c0182ba3 <skb_linearize+cf/130>
Trace; c0185add <dev_queue_xmit+6d/1f4>
Trace; c0188c58 <neigh_connected_output+84/b4>
Trace; c0195fbc <ip_finish_output2+0/b4>
Trace; c01936b0 <ip_forward_finish+0/50>
Trace; c0195fa2 <ip_finish_output+e2/e8>
Trace; c0195fbc <ip_finish_output2+0/b4>
Trace; c01936fa <ip_forward_finish+4a/50>
Trace; c018ac72 <nf_hook_slow+ee/134>
Trace; c01928a8 <ip_rcv_finish+0/1f8>
Trace; c018ac72 <nf_hook_slow+ee/134>
Trace; c01926f6 <ip_rcv+376/3b0>
Trace; c01928a8 <ip_rcv_finish+0/1f8>
Trace; c018603d <net_rx_action+135/210>
Trace; c0106b80 <ret_from_intr+0/20>
Trace; c0105120 <default_idle+0/28>
Trace; c0105143 <default_idle+23/28>
Trace; c01051a7 <cpu_idle+3f/54>
Trace; c0105000 <prepare_namespace+0/8>
Code;  c012610a <__free_pages+2/1c>
00000000 <_EIP>:
Code;  c012610a <__free_pages+2/1c>   <=====
   0:   8b 41 18                  mov    0x18(%ecx),%eax   <=====
Code;  c012610d <__free_pages+5/1c>
   3:   85 c0                     test   %eax,%eax
Code;  c012610f <__free_pages+7/1c>
   5:   7c 11                     jl     18 <_EIP+0x18> c0126122 <__free_pages+1a/1c>
Code;  c0126111 <__free_pages+9/1c>
   7:   ff 49 14                  decl   0x14(%ecx)
Code;  c0126114 <__free_pages+c/1c>
   a:   0f 94 c0                  sete   %al
Code;  c0126117 <__free_pages+f/1c>
   d:   84 c0                     test   %al,%al
Code;  c0126119 <__free_pages+11/1c>
   f:   74 07                     je     18 <_EIP+0x18> c0126122 <__free_pages+1a/1c>
Code;  c012611b <__free_pages+13/1c>
  11:   89 c8                     mov    %ecx,%eax
Code;  c012611d <__free_pages+15/1c>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0126122 <__free_pages+1a/1c>

Kernel panic: Aiee, killing interrupt handler!

[6.] A small shell script or example program which triggers the
     problem (if possible)

none

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
mount                  2.10f
modutils               2.3.17
e2fsprogs              1.18
reiserfsck: not found
cardmgr: not found
PPP                    2.3.11
isdn4k-utils           3.1pre1
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 1
model name      : Pentium 60/66
stepping        : 5
cpu MHz         : 60.000
fdiv_bug        : yes
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 119.60

[7.3.] Module information (from /proc/modules):
tulip                  36992   1
nfs                    73664   1 (autoclean)
lockd                  49168   0 (autoclean) [nfs]
sunrpc                 61376   1 (autoclean) [nfs lockd]
ipt_tos                  800   0 (unused)
ipt_mark                 816   0 (unused)
iptable_mangle          2016   0 (unused)
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1424   1
ip_nat_irc              3056   0 (unused)
ip_nat_ftp              3200   0 (unused)
iptable_nat            14704   2 [ipt_REDIRECT ipt_MASQUERADE ip_nat_irc ip_nat_ftp]
ip_conntrack_irc        3200   0 (unused)
ip_conntrack_ftp        3536   0 (unused)
ipt_state                896   6
ip_conntrack           13792   4 [ipt_REDIRECT ipt_MASQUERADE ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc 
ip_conntrack_ftp ipt_state]
ipt_limit               1168   5
ipt_multiport           1008   0 (unused)
ipt_TOS                 1216   0 (unused)
ipt_REJECT              3264   0 (unused)
ipt_LOG                 3504   4
iptable_filter          2080   0 (unused)
ip_tables              10528  15 [ipt_tos ipt_mark iptable_mangle ipt_REDIRECT ipt_MASQUERADE iptable_nat ipt_sta
te ipt_limit ipt_multiport ipt_TOS ipt_REJECT ipt_LOG iptable_filter]
ip_gre                  7008   1
isdn_bsdcomp            6384   0 (unused)
hisax                 131632  12
isdn                  117168  13 [isdn_bsdcomp hisax]
slhc                    4832   6 [isdn]
dummy                   1280   1


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0268-026f : sportster
02f8-02ff : serial(set)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0668-066f : sportster
0a68-0a6f : sportster
0cf8-0cfb : PCI conf2
0e68-0e6f : sportster
1268-126f : sportster
1668-166f : sportster
1a68-1a6f : sportster
1e68-1e6f : sportster
2268-226f : sportster
2668-266f : sportster
2a68-2a6f : sportster
2e68-2e6f : sportster
3268-326f : sportster
3668-366f : sportster
3a68-3a6f : sportster
3e68-3e6f : sportster
4268-426f : sportster
4668-466f : sportster
4a68-4a6f : sportster
4e68-4e6f : sportster
5268-526f : sportster
5668-566f : sportster
5a68-5a6f : sportster
5e68-5e6f : sportster
6268-626f : sportster
6668-666f : sportster
6a68-6a6f : sportster
6e68-6e6f : sportster
7268-726f : sportster
7668-766f : sportster
7a68-7a6f : sportster
7e68-7e6f : sportster
8268-826f : sportster
8668-866f : sportster
8a68-8a6f : sportster
8e68-8e6f : sportster
9268-926f : sportster
9668-966f : sportster
9a68-9a6f : sportster
9e68-9e6f : sportster
a268-a26f : sportster
a668-a66f : sportster
aa68-aa6f : sportster
ae68-ae6f : sportster
b268-b26f : sportster
b668-b66f : sportster
ba68-ba6f : sportster
be68-be6f : sportster
c268-c26f : sportster
c668-c66f : sportster
ca68-ca6f : sportster
ce68-ce6f : sportster
d268-d26f : sportster
d668-d66f : sportster
da68-da6f : sportster
de68-de6f : sportster
e268-e26f : sportster
e668-e66f : sportster
ea68-ea6f : sportster
ee68-ee6f : sportster
f268-f26f : sportster
f668-f66f : sportster
fa68-fa6f : sportster
fc80-fcff : Digital Equipment Corporation DECchip 21142/43
  fc80-fcff : tulip
fe68-fe6f : sportster

# cat /proc/iomem   
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-017fffff : System RAM
  00100000-001c0681 : Kernel code
  001c0682-00201137 : Kernel data
ffbffc00-ffbfffff : Digital Equipment Corporation DECchip 21142/43
  ffbffc00-ffbfffff : tulip



[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 82434LX [Mercury/Neptune] (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 set

00:02.0 Non-VGA unclassified device: Intel Corporation 82378IB [SIO ISA Bridge]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
        Subsystem: Compu-Shack: Unknown device 4235
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 20 min, 40 max, 64 set, cache line size 20
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at fc80 [size=128]
        Region 1: Memory at ffbffc00 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at fe000000 [disabled] [size=256K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
no SCSI

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you think to be relevant): 

# free
             total       used       free     shared    buffers     cached
Mem:         22524      21824        700          0        420       9296
-/+ buffers/cache:      12108      10416
Swap:        49036         40      48996


[X.] Other notes, patches, fixes, workarounds:
      iptables-2001-06-02 (fixes, nat_irc, match_ipsec)
      tulip-1.1.8 + MTU fix


Rainer

-- 
KeyID=759975BD fingerprint=887A 4BE3 6AB7 EE3C 4AE0  B0E1 0556 E25A 7599 75BD
