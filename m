Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUCSJyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbUCSJyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:54:16 -0500
Received: from vicar.dcs.qmul.ac.uk ([138.37.95.146]:62869 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP id S262194AbUCSJyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:54:11 -0500
Date: Fri, 19 Mar 2004 09:54:10 +0000 (GMT)
From: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.25 oops in do_softirq
Message-ID: <Pine.LNX.4.58.0403190942360.23532@r2-pc.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-clamav-result: clean (1B4Ghe-0007Hn-R1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Our big student fileserver has crashed two nights in a row (while the
dumps were running). I didn't have time to capture the oops the first
time; this time I've copied it by hand. The modules having changed are
credit to my initrd. The machine is a dual-Athlon running Debian woody.

We've recently changed the gigabit NIC from a 33MHz, 64-bit fibre acenic
under 2.4.23 (stable for at least weeks) to a 66MHz, 64-bit copper ns83820
under 2.4.25 while changing our switches. It had run fine for a week.

Here's some possibly irrelevant information: I can provide plenty more if
need be! (I've tried to run a memtest86+ but had to abort at 9am, as our
students have a deadline..)

Cheers,

Matt

Linux version 2.4.25 (mb@absinthe-pc) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-118)) #1 SMP Wed Mar 10 11:22:38 GMT 2004

00:09.0 Ethernet controller: National Semiconductor Corporation DP83820 10/100/1000 Ethernet Controller
        Subsystem: Netgear: Unknown device 622a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2750ns min, 13000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 1000 [size=256]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

Module                  Size  Used by    Not tainted
nfsd                   69168  32  (autoclean)
lockd                  48368   1  (autoclean) [nfsd]
sunrpc                 67228   1  (autoclean) [nfsd lockd]
af_packet              13448   1  (autoclean)
autofs4                 8532  10  (autoclean)
ipv6                  167764  -1  (autoclean)
serial                 45412   0  (autoclean)
isa-pnp                28388   0  (autoclean) [serial]
3c59x                  25072   1
ns83820                13232   1
ipchains               57616 174
rtc                     6876   0  (autoclean)
unix                   16168  28  (autoclean)
ext3                   65956   9
quota_v2                6424   7
jbd                    47204   9  [ext3]
sd_mod                 11308  38
gdth                   77088  19
scsi_mod               96392   2  [sd_mod gdth]

           CPU0       CPU1
  0:     168347     150072    IO-APIC-edge  timer
  1:        364        511    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          3          0    IO-APIC-edge  rtc
 12:          4          8    IO-APIC-edge  PS/2 Mouse
 16:      28021      27929   IO-APIC-level  gdth
 17:     435336     433977   IO-APIC-level  eth0
 19:        676        694   IO-APIC-level  eth1
NMI:          0          0
LOC:     318331     318263
ERR:          0
MIS:          0

ksymoops 2.4.5 on i686 2.4.25.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.25/ (default)
     -m /boot/System.map-2.4.25 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /lib/modules/2.4.25/kernel/fs/ext3/ext3.o for module ext3 has changed since load
Warning (expand_objects): object /lib/modules/2.4.25/kernel/fs/quota_v2.o for module quota_v2 has changed since load
Warning (expand_objects): object /lib/modules/2.4.25/kernel/fs/jbd/jbd.o for module jbd has changed since load
Warning (expand_objects): object /lib/modules/2.4.25/kernel/drivers/scsi/sd_mod.o for module sd_mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.25/kernel/drivers/scsi/gdth.o for module gdth has changed since load
Warning (expand_objects): object /lib/modules/2.4.25/kernel/drivers/scsi/scsi_mod.o for module scsi_mod has changed since load
Unable to handle kernel NULL pointer dereference at virtual address 
00000000 printing eip:
c011e5c0
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c011e5c0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010213
eax: 00000000 ebx: 00000002 ecx: 00000000 edx: c024d688
esi: c024d690 edi: fffffff5 ebp: 00000000 esp: d050df94
ds: 0018 es: 0018 ss: 0018
Process gzip (pid: 5878, stackpage=d050d000)
Stack: 00000046 00000011 c0249e40 00000011 00000000 c010a6a1 f7f9d8c0 0000000e
  080a152e 000083e9 bffffe1c c01ddb50 0000000e 080a152e 0809c669 080a152e
  000083e9 bffffe1c 000083e9 0000002b 0000002b ffffff11 08049436 00000023
Call Trace: [<c010a6a1>]
Code: f7 c3 01 00 00 00 74 04 56 ff 16 5a 83 c6 08 d1 eb 75 ed fa


>>EIP; c011e5c0 <do_softirq+70/e0>   <=====

>>edx; c024d688 <softirq_vec+8/100>
>>esi; c024d690 <softirq_vec+10/100>
>>edi; fffffff5 <END_OF_CODE+74e88a6/????>
>>esp; d050df94 <_end+10290b9c/38582c08>

Trace; c010a6a1 <do_IRQ+e1/f0>

Code;  c011e5c0 <do_softirq+70/e0>
00000000 <_EIP>:
Code;  c011e5c0 <do_softirq+70/e0>   <=====
   0:   f7 c3 01 00 00 00         test   $0x1,%ebx   <=====
Code;  c011e5c6 <do_softirq+76/e0>
   6:   74 04                     je     c <_EIP+0xc> c011e5cc <do_softirq+7c/e0>
Code;  c011e5c8 <do_softirq+78/e0>
   8:   56                        push   %esi
Code;  c011e5c9 <do_softirq+79/e0>
   9:   ff 16                     call   *(%esi)
Code;  c011e5cb <do_softirq+7b/e0>
   b:   5a                        pop    %edx
Code;  c011e5cc <do_softirq+7c/e0>
   c:   83 c6 08                  add    $0x8,%esi
Code;  c011e5cf <do_softirq+7f/e0>
   f:   d1 eb                     shr    %ebx
Code;  c011e5d1 <do_softirq+81/e0>
  11:   75 ed                     jne    0 <_EIP>
Code;  c011e5d3 <do_softirq+83/e0>
  13:   fa                        cli    


7 warnings issued.  Results may not be reliable.
