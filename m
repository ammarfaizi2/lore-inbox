Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUDBKVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 05:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbUDBKVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 05:21:45 -0500
Received: from [151.39.82.11] ([151.39.82.11]:62371 "HELO abbeynet.it")
	by vger.kernel.org with SMTP id S263578AbUDBKVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 05:21:07 -0500
Message-ID: <406D3E8F.20902@abbeynet.it>
Date: Fri, 02 Apr 2004 12:21:03 +0200
From: Marco Fais <marco.fais@abbeynet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.4.2) Gecko/20040308
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc.c:98 -- compiling with distcc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.24.0.7; VDF: 6.24.0.82; host: abbeynet.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


[1.] Kernel panic while using distcc

[2.] I have 5-6 development linux systems that we use without problem
under a normal development workload. Trying distcc for speeding up
compilation, we have a fully reproducible kernel panic in a very short
time (seconds after compilation start). The kernel panic happens *only*
when the systems are "remotely controlled" (the distcc daemon is
receiving source files from remote systems, compile and send back
compiled objects). When compiling with distcc the local system doesn't
show any kernel panic, while the same system used as a "remote compiler
system" dies very quickly.

[3.] Keywords: distcc BUG page_alloc.c

[4.] Linux version 2.4.25 (root@test1) (gcc version 3.2 20020903 (Red
Hat Linux 8.0 3.2-7)) #1 mer mar 31 10:28:36 CEST 2004

[5.]
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

kernel BUG at page_alloc.c:98!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01372ae>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000002   ebx: c14b3f00   ecx: c14b3f00   edx: 00000000
esi: 00000000   edi: dec11340   ebp: c02f1d04   esp: c02f1cd4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02f1000)
Stack: ddd46000 c02f1cfc c0135a76 c158f6f0 de9bcdf4 ddd45800 de9bcdf4
005207dc
       ddd45800 00000001 dec4d894 dec11340 c02f1d18 c021667b 00000282
dec4d894
       dec4d8c4 c02f1d2c c02166b4 dec4d894 dec4d894 dec4d894 c02f1d44
c0216816
Call Trace:    [<c0135a76>] [<c021667b>] [<c02166b4>] [<c0216816>]
[<c023be39>]
  [<c023c385>] [<c023f51c>] [<c02465a9>] [<c0246a76>] [<c022dad0>]
[<c022dc25>]
  [<c0222780>] [<c022dad0>] [<c022d88f>] [<c022dad0>] [<c022de3a>]
[<e08d7eab>]
  [<c021ad14>] [<c021ae3f>] [<c021af5a>] [<c0121cd7>] [<c010a66d>]
[<c01070a0>]
  [<c010cb58>] [<c01070a0>] [<c01070c6>] [<c0107142>] [<c0105000>]
Code: 0f 0b 62 00 f7 60 27 c0 e9 ad fd ff ff 90 8d 74 26 00 55 89


> >EIP; c01372ae <__free_pages_ok+26e/280>   <=====

> >ebx; c14b3f00 <_end+116e728/204d48a8>
> >ecx; c14b3f00 <_end+116e728/204d48a8>
> >edi; dec11340 <_end+1e8cbb68/204d48a8>
> >ebp; c02f1d04 <init_task_union+1d04/2000>
> >esp; c02f1cd4 <init_task_union+1cd4/2000>

Trace; c0135a76 <kmem_cache_free_one+f6/210>
Trace; c021667b <skb_release_data+6b/90>
Trace; c02166b4 <kfree_skbmem+14/70>
Trace; c0216816 <__kfree_skb+106/160>
Trace; c023be39 <tcp_clean_rtx_queue+139/330>
Trace; c023c385 <tcp_ack+c5/380>
Trace; c023f51c <tcp_rcv_state_process+19c/a90>
Trace; c02465a9 <tcp_v4_do_rcv+a9/130>
Trace; c0246a76 <tcp_v4_rcv+446/560>
Trace; c022dad0 <ip_local_deliver_finish+0/180>
Trace; c022dc25 <ip_local_deliver_finish+155/180>
Trace; c0222780 <nf_hook_slow+b0/170>
Trace; c022dad0 <ip_local_deliver_finish+0/180>
Trace; c022d88f <ip_local_deliver+4f/70>
Trace; c022dad0 <ip_local_deliver_finish+0/180>
Trace; c022de3a <ip_rcv_finish+1ea/270>
Trace; e08d7eab <[8139too]rtl8139_rx_interrupt+6b/3b0>
Trace; c021ad14 <netif_receive_skb+c4/180>
Trace; c021ae3f <process_backlog+6f/120>
Trace; c021af5a <net_rx_action+6a/100>
Trace; c0121cd7 <do_softirq+97/a0>
Trace; c010a66d <do_IRQ+bd/f0>
Trace; c01070a0 <default_idle+0/30>
Trace; c010cb58 <call_do_IRQ+5/d>
Trace; c01070a0 <default_idle+0/30>
Trace; c01070c6 <default_idle+26/30>
Trace; c0107142 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>

Code;  c01372ae <__free_pages_ok+26e/280>
00000000 <_EIP>:
Code;  c01372ae <__free_pages_ok+26e/280>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01372b0 <__free_pages_ok+270/280>
   2:   62 00                     bound  %eax,(%eax)
Code;  c01372b2 <__free_pages_ok+272/280>
   4:   f7 60 27                  mull   0x27(%eax)
Code;  c01372b5 <__free_pages_ok+275/280>
   7:   c0 e9 ad                  shr    $0xad,%cl
Code;  c01372b8 <__free_pages_ok+278/280>
   a:   fd                        std
Code;  c01372b9 <__free_pages_ok+279/280>
   b:   ff                        (bad)
Code;  c01372ba <__free_pages_ok+27a/280>
   c:   ff 90 8d 74 26 00         call   *0x26748d(%eax)
Code;  c01372c0 <rmqueue+0/230>
  12:   55                        push   %ebp
Code;  c01372c1 <rmqueue+1/230>
  13:   89 00                     mov    %eax,(%eax)

<0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


[6.] Launch distccd --daemon on the affected system, then on the remote
host, set DISTCC_HOSTS="<problematic remote system>" and launch, for
example, a kernel compile: make -j2 CC=distcc bzImage.

[7.] All system are AthlonXP 2.6+, on a VIA KT400 chipset (various
motherboard vendors). All using EXT3 filesystems, with various redhat
distributions (8.0, 9, RHEL3 -- not using NPTL)

[7.1.]
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2600+
stepping        : 1
cpu MHz         : 2075.355
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4141.87

[7.3.] Module information (from /proc/modules):

Module                  Size  Used by    Not tainted
nfs                    78968   1  (autoclean)
binfmt_misc             7304   1
nfsd                   80304   8  (autoclean)
lockd                  58480   1  (autoclean) [nfs nfsd]
sunrpc                 84188   1  (autoclean) [nfs nfsd lockd]
8139too                19784   2
mii                     3944   0  [8139too]
crc32                   3680   0  [8139too]
iptable_filter          2412   0  (autoclean) (unused)
ip_tables              15392   1  [iptable_filter]
ohci1394               33608   0  (unused)
ieee1394               64676   0  [ohci1394]
mousedev                5428   0  (unused)
keybdev                 3072   0  (unused)
input                   5824   0  [mousedev keybdev]
hid                    12248   0  (unused)
rtc                     8764   0  (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-c0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  c000-c0ff : 8139too
c400-c4ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (#2)
  c400-c4ff : 8139too
d400-d47f : VIA Technologies, Inc. IEEE 1394 Host Controller
d800-d8ff : C-Media Electronics Inc CM8738
dc00-dc1f : VIA Technologies, Inc. USB
e000-e01f : VIA Technologies, Inc. USB (#2)
e400-e41f : VIA Technologies, Inc. USB (#3)
e800-e80f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C
PIPC Bus Master IDE
  e800-e807 : ide0
  e808-e80f : ide1

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002667cb : Kernel code
  002667cc-002ef563 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV17 [GeForce4 MX 440]
  d8000000-d807ffff : nVidia Corporation NV17 [GeForce4 MX 440]
e0000000-e3ffffff : VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
e4000000-e5ffffff : PCI Bus #01
  e4000000-e4ffffff : nVidia Corporation NV17 [GeForce4 MX 440]
e6020000-e60200ff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (#2)
  e6020000-e60200ff : 8139too
e6022000-e60220ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  e6022000-e60220ff : 8139too
e6023000-e60237ff : VIA Technologies, Inc. IEEE 1394 Host Controller
  e6023000-e60237ff : ohci1394
e6024000-e60240ff : VIA Technologies, Inc. USB 2.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189
        Subsystem: VIA Technologies, Inc.: Unknown device 3189
        Flags: bus master, 66Mhz, medium devsel, latency 8
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b168 (prog-if
00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        Capabilities: [80] Power Management version 2

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 17
        I/O ports at c000 [size=256]
        Memory at e6022000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at c400 [size=256]
        Memory at e6020000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:0e.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: Biostar Microtech Int'l Corp: Unknown device 4200
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at e6023000 (32-bit, non-prefetchable) [size=2K]
        I/O ports at d400 [size=128]
        Capabilities: [50] Power Management version 2

00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: Biostar Microtech Int'l Corp: Unknown device 8738
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at d800 [size=256]
        Capabilities: [c0] Power Management version 2

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if
20 [EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Flags: bus master, medium devsel, latency 32, IRQ 19
        Memory at e6024000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8233A ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master
IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at e800 [size=16]
        Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4
MX440] (rev a3) (prog-if 00 [VGA])
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
        Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Memory at d8000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0

         CPU0
  0:     292363    IO-APIC-edge  timer
  1:          3    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
12:          0          XT-PIC  PS/2 Mouse
14:       8958    IO-APIC-edge  ide0
15:          4    IO-APIC-edge  ide1
17:       6482   IO-APIC-level  eth0
18:          2   IO-APIC-level  ohci1394
19:         28   IO-APIC-level  eth1
NMI:          0
LOC:     292280
ERR:          0
MIS:          0

[7.7.] Other information that might be relevant to the problem

Other systems (DL-360G3 dual Xeon 2.8 GHz, RHEL3, SMP or UP kernel)
doesn't show the problem.




