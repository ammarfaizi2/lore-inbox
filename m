Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbTBGRjB>; Fri, 7 Feb 2003 12:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbTBGRjB>; Fri, 7 Feb 2003 12:39:01 -0500
Received: from rdu25-10-178.nc.rr.com ([24.25.10.178]:55170 "EHLO
	louka.scot.billman.name") by vger.kernel.org with ESMTP
	id <S266114AbTBGRi6>; Fri, 7 Feb 2003 12:38:58 -0500
Date: Fri, 7 Feb 2003 12:42:24 -0500
From: Scot Billman <gsb@nc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: HomePNA driver causes kernel panic
Message-ID: <20030207174224.GA10829@louka.scot.billman.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DESCRIPTION]
I have a Linksys "HomeLink Phoneline 10M Network Card" installed in my
machine.  This enables a HomePNA network, which connects machines though
the telephone wiring in a building.

After a short period of traffic on this card, there is a kernel panic.
To me, the problem appears random, ie, I cannot predict how much network
traffic will cause the problem.  The problem does not occur when I use
an older kernel.


[KEYWORDS]
modules, networking, kernel, hpna, il


[KERNEL VERSION]
versions with problem:   2.4.8-26mdk (from Mandrake 8.2)
                         2.4.18-3    (from Redhat 7.3)
version without problem: 2.4.3-20mdk (from Mandrake 8.0)


[OUTPUT]
I recorded this output from the 2.4.8-26mdk kernel:

KERNEL: assertion (atomic_read(&skb_users) ==0) failed at dev.c(1332):net_tx_action

(repeats several times, then...)

Warning: kfree_skb passed an skb still on a list (from c01c8f15).
Kernel BUG at skbuff.c:316!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01c514c>]
EFLAGS: 00010286
eax: 0000001c   ebx: c032a6ec   ecx: c025dddc   edx: 0001c482
esi: c30ecc20   edi: c01c8f15   ebp: 00000046   esp: c0275f5c
ds: 0018   es: 0018   ss: 0018
Stack: c0241fa0 0000013c fffffff9 c01c8f15 c30ecc20 00000003 c032a5c8 fffffff9
       c0118933 c032a5c8 c0275fac 00000009 c0328a20 c49bbe80 c010870c c0274000
       c0105380 c0274000 0008e000 c0211784 c0274000 00000000 00000019 c0105380
Call Trace: [<c01c8f15>] [<c0118933>] [<c010870c>] [<c0105380>] [<c0105380>]
   [<c01053a4>] [<c0105412>] [<c0105000>]

Code: 0f 0b 5f 58 8b 54 24 08 8b 42 28 85 c0 74 07 ff 48 04 8b 54
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


[ENVIRONMENT]
The following information was taken from the machine after installing the
working kernel (2.4.3-20mdk).


[HARDWARE]
The machine is (I believe) a stock Compaq Prosignia 300.  To it, I have
added two network cards.  One requires the 3c59x driver.  The other
is the Phoneline card, product #HPN200.  It requires the il driver.


[SOFTWARE]
The source for the il driver, installation information, etc. is available
at <http://www.homepna.org/support/faqs.asp#FAQ6>.


[/proc/cpuinfo]
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 6
cpu MHz		: 120.275
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8
bogomips	: 240.02


[/proc/meminfo]
        total:    used:    free:  shared: buffers:  cached:
Mem:  96972800 94801920  2170880        0 19791872 50110464
Swap: 197365760        0 197365760
MemTotal:        94700 kB
MemFree:          2120 kB
MemShared:           0 kB
Buffers:         19328 kB
Cached:          48936 kB
Active:           7564 kB
Inact_dirty:     58652 kB
Inact_clean:      2048 kB
Inact_target:        0 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        94700 kB
LowFree:          2120 kB
SwapTotal:      192740 kB
SwapFree:       192740 kB


[/proc/modules]
il                     57952   1
ipt_TOS                  912  22 (autoclean)
ipt_MASQUERADE          1104   1 (autoclean)
ipt_state                576   3 (autoclean)
ipt_REJECT              1888   9 (autoclean)
ipt_LOG                 3120   9 (autoclean)
ipt_limit                864   3 (autoclean)
iptable_nat            11616   0 (autoclean) [ipt_MASQUERADE]
ip_conntrack           12096   2 (autoclean) [ipt_MASQUERADE ipt_state iptable_nat]
iptable_mangle          1680   0 (autoclean) (unused)
iptable_filter          1696   0 (autoclean) (unused)
ip_tables              10528  11 [ipt_TOS ipt_MASQUERADE ipt_state ipt_REJECT ipt_LOG ipt_limit iptable_nat iptable_mangle iptable_filter]
nls_iso8859-1           2848   1 (autoclean)
sr_mod                 13952   1 (autoclean)
isofs                  17808   1 (autoclean)
af_packet              11280   1 (autoclean)
3c59x                  24640   1 (autoclean)
pcnet32                11728   1 (autoclean)
supermount             32496   4 (autoclean)
53c7,8xx               52072   4
sd_mod                 11048   3
scsi_mod               86036   3 [sr_mod 53c7,8xx sd_mod]


[/proc/ioports]
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
7000-701f : Advanced Micro Devices [AMD] 79c970 [PCnet LANCE]
  7000-701f : PCnet/PCI 79C970
7100-71ff : Symbios Logic Inc. (formerly NCR) 53c810
  7100-717f : ncr53c7,8xx
7200-727f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
  7200-727f : eth1


[/proc/iomem]
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-05ffffff : System RAM
  00100000-001f412b : Kernel code
  001f412c-0023bfab : Kernel data
06200000-062000ff : Symbios Logic Inc. (formerly NCR) 53c810
06300000-0630007f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
06400000-06400fff : PCI device feda:a0fa (Epigram Inc)


[/proc/pci]
PCI devices found:
  Bus  0, device  11, function  0:
    Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 2).
      IRQ 3.
      I/O at 0x7000 [0x701f].
  Bus  0, device  12, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c810 (rev 2).
      IRQ 11.
      Master Capable.  Latency=255.  
      I/O at 0x7100 [0x71ff].
      Non-prefetchable 32 bit memory at 0x6200000 [0x62000ff].
  Bus  0, device  13, function  0:
    Ethernet controller: PCI device feda:a0fa (Epigram Inc) (rev 1).
      IRQ 9.
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0x6400000 [0x6400fff].
  Bus  0, device  14, function  0:
    Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] (rev 4).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=10.Max Lat=48.
      I/O at 0x7200 [0x727f].
      Non-prefetchable 32 bit memory at 0x6300000 [0x630007f].
  Bus  0, device  15, function  0:
    EISA bridge: Compaq Computer Corporation PCI to EISA Bridge (rev 7).
