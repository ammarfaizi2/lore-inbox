Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266631AbRGJQKM>; Tue, 10 Jul 2001 12:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266633AbRGJQKD>; Tue, 10 Jul 2001 12:10:03 -0400
Received: from FSG1.nws.noaa.gov ([140.90.20.103]:50442 "EHLO
	fsg1.nws.noaa.gov") by vger.kernel.org with ESMTP
	id <S266631AbRGJQJq>; Tue, 10 Jul 2001 12:09:46 -0400
Date: Tue, 10 Jul 2001 12:09:34 -0400 (EDT)
From: Brian McEntire <brianm@fsg1.nws.noaa.gov>
To: <andrewm@uow.edu.au>, <pnorton@ieee.org>
cc: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: memory allocation error with token ring tms380/abyss modules
 [follow-up #2 -- 2nd OOPS analysis included]
In-Reply-To: <Pine.LNX.4.33.0107031407090.22219-100000@fsg1.nws.noaa.gov>
Message-ID: <Pine.LNX.4.33.0107101205040.26350-100000@fsg1.nws.noaa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  Here is another opps analysis. This is a second opps report posting for
on ongoing problem we are experiencing on a Linux system that is crashing
about once a week! Please route this message to the appropriate maintainer
if I haven't picked the correct names already. Thank You! Also, let me
know if there is anything I can do to help, such as test a patch for this
problem.

[root@ohdrouter /root]# ksymoops oops.7.9.2
001
ksymoops 0.7c on i686 2.4.5-ac23.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac23/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

CPU:    0
EIP:    0010:[<c01ab33b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000029   ebx: c4828acc   exc: 00000000   edx: 00000082
esi: 000000a0   edi: 0000020e   ebp: c38ca940   esp: c0235eb0
ds: 0018   es: 0018   ss: 0018
Process Swapper (pid: 0, stackpage=c0235000)
Stack: c02070c0 c4828acc 000013a6 0000020e c114e000 c37425e0 c4828ad4
c37425e0
       0000020e c4828acc c3d31580 04000001 c38ca940 c0235fa8 00000140
c38ca96c
       c38ca9d8 c03391a8 0000020e 00000000 0000001f c4828ed0 c38ca800
c3d31580
Call Trace: [<c01ab5c3>] [<c0107d1d>] [<c0107e87>] [<c0109efe>]
[<c01051a0>]
[<c0109efe>] [<c01051a0>] [<c01051a0>] [<c01051c3>] [<c0105224>]
[<c01050000>]
[<c0105027>]
Code: 0f 0b 83 c4 14 5b c3 89 f6 53 b8 b1 70 20 c0 86 54 24 08 8b

>>EIP; c01ab33b <skb_over_panic+2b/34>   <=====
Trace; c01ab5c3 <skb_release_data+67/70>
Trace; c0107d1d <handle_IRQ_event+31/5c>
Trace; c0107e87 <do_IRQ+6b/a8>
Trace; c0109efe <call_do_IRQ+5/b>
Trace; c01051a0 <default_idle+0/28>
Trace; c0109efe <call_do_IRQ+5/b>
Trace; c01051a0 <default_idle+0/28>
Trace; c01051a0 <default_idle+0/28>
Trace; c01051c3 <default_idle+23/28>
Trace; c0105224 <cpu_idle+3c/50>
Trace; c01050000 <END_OF_CODE+b3c816caa/????>
Trace; c0105027 <rest_init+27/28>
Code;  c01ab33b <skb_over_panic+2b/34>
00000000 <_EIP>:
Code;  c01ab33b <skb_over_panic+2b/34>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01ab33d <skb_over_panic+2d/34>
   2:   83 c4 14                  add    $0x14,%esp
Code;  c01ab340 <skb_over_panic+30/34>
   5:   5b                        pop    %ebx
Code;  c01ab341 <skb_over_panic+31/34>
   6:   c3                        ret
Code;  c01ab342 <skb_over_panic+32/34>
   7:   89 f6                     mov    %esi,%esi
Code;  c01ab344 <skb_under_panic+0/34>
   9:   53                        push   %ebx
Code;  c01ab345 <skb_under_panic+1/34>
   a:   b8 b1 70 20 c0            mov    $0xc02070b1,%eax
Code;  c01ab34a <skb_under_panic+6/34>
   f:   86 54 24 08               xchg   %dl,0x8(%esp,1)
Code;  c01ab34e <skb_under_panic+a/34>
  13:   8b 00                     mov    (%eax),%eax

<0>kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

[root@ohdrouter /root]# exit

----

Hope this report is helpful!

  -Brian

> On Tue, 19 Jun 2001, Brian McEntire wrote:
>
> > [1.] memory allocation error with token ring tms380/abyss modules
> >
> > [2.] a memory allocation error causes the system to go into an infinite
> > loop about once every week or two. This most recent time was 8 days, to
> > the hour from the last crash. Everything on the system stops working and I
> > need to hit the reset button to reboot the system. At crash time, the
> > following message scrolls up the screen:
> >
> > __alloc_pages: 1-order allocation failed
> >
> > * Actually, I did some searching on the web and found this problem
> > discussed but not fixed. According to one e-mail, I patched
> > mm/page_alloc.c and rebuilt the kernel so that I could get the following
> > _slightly_ more informative message after the crash:
> >
> > __alloc_pages: 1-order allocation failed from c01290e8
> >
> > The modification I made to mm/page_alloc.c is:
> > change the line:
> >
> > printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order);
> >
> > to:
> >
> > printk(KERN_ERR "__alloc_pages: %lu-order allocation failed from %p\n",
> >   order, __builtin_return_address(0));
> >
> > Then I'm supposed to be able to look up the hex code from the error
> > message in the /boot/System.map (it is the correct one for my kernel) and
> > find out what function is causing the problem.
> >
> > But, I don't find c01290e8 in my System.map. Two hex addresses close to it
> > are found there:
> >
> > c01290d4 T __get_free_pages
> > c01290f4 T get_zeroed_page
> >
> > Yup, looks like it has something to do with memory allocation alright ;-)
> >
> > Everytime this crash occurs, it is the same hex address given in the error
> > message. I can't cause this error to occur. The system is running as a
> > basic router and has two Netgear FA310TX ethernet cards in it and one
> > Madge Smart 16/4 PCI Ringnode Mk2 token ring card in it.
> >
> > The system logs don't give any indication that the crash is coming or any
> > information about it, not even the 1-order allocation error is listed.
> > One exception (maybe):
> >
> > I get the following messages showing up occasionally in /var/log/messages
> > on weekdays (when I expect network usage to be higher than on weekends).
> > But these don't seem to come in any higher frequency leading up to the
> > crash.
> >
> > Jun 19 15:10:23 ohdrouter kernel: Cancel tx (C04D0068h).
> > Jun 19 15:10:23 ohdrouter kernel: Cancel tx (C04D0098h).
> > Jun 19 15:10:59 ohdrouter kernel: Cancel tx (C04D0068h).
> > Jun 19 15:10:59 ohdrouter kernel: Cancel tx (C04D0098h).
> > Jun 19 15:14:14 ohdrouter kernel: Cancel tx (C04D0068h).
> > Jun 19 15:14:14 ohdrouter kernel: Cancel tx (C04D0098h).
> > Jun 19 15:25:05 ohdrouter kernel: Cancel tx (C04D00C8h).
> >
> > [3.] token ring, tms380, abyss, memory allocation failure, 1-order
> > allocation failed, __alloc_pages, kernel 2.4.5 and previous 2.4 kernels
> >
> > [4.] Linux version 2.4.5 (root@ohdrouter.nws.noaa.gov) (gcc version
> > egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #6 Wed May 30 17:43:06
> > EDT 2001
> >
> > [5.] N/A ... no Oops
> >
> > [6.] N/A ... can't force it to happen, just have to wait a week or so
> >
> > [7.] Red Hat Linux release 6.2 (Zoot)
> >
> > [7.1] output from sh scripts/ver_linux
> >
> > Gnu C                  egcs-2.91.66
> > Gnu make               3.78.1
> > binutils               2.9.5.0.22
> > util-linux             2.10f
> > mount                  2.10r
> > modutils               2.4.5
> > e2fsprogs              1.18
> > pcmcia-cs              3.1.8
> > PPP                    2.3.11
> > Linux C Library        2.1.3
> > Dynamic linker (ldd)   2.1.3
> > Procps                 2.0.6
> > Net-tools              1.54
> > Console-tools          0.3.3
> > Sh-utils               2.0
> > Modules Loaded         ipchains abyss tms380tr tulip
> >
> > [7.2]
> > [root@ohdrouter linux]# cat /proc/cpuinfo
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 3
> > model name      : Pentium II (Klamath)
> > stepping        : 4
> > cpu MHz         : 298.737
> > cache size      : 512 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 2
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
> > mmx
> > bogomips        : 596.37
> >
> > [7.3]
> > [root@ohdrouter linux]# cat /proc/modules
> > ipchains               32320   0 (unused)
> > abyss                   2960   1 (autoclean)
> > tms380tr               43216   0 (autoclean) [abyss]
> > tulip                  39328   2 (autoclean)
> >
> > [7.4]
> > [root@ohdrouter linux]# cat /proc/ioports
> > 0000-001f : dma1
> > 0020-003f : pic1
> > 0040-005f : timer
> > 0060-006f : keyboard
> > 0080-008f : dma page reg
> > 00a0-00bf : pic2
> > 00c0-00df : dma2
> > 00f0-00ff : fpu
> > 0170-0177 : ide1
> > 01f0-01f7 : ide0
> > 02f8-02ff : serial(auto)
> > 0376-0376 : ide1
> > 03c0-03df : vga+
> > 03f6-03f6 : ide0
> > 03f8-03ff : serial(auto)
> > 0cf8-0cff : PCI conf1
> > 4000-403f : Intel Corporation 82371AB PIIX4 ACPI
> > 5000-501f : Intel Corporation 82371AB PIIX4 ACPI
> > d000-dfff : PCI Bus #01
> > e000-e01f : Intel Corporation 82371AB PIIX4 USB
> > e400-e4ff : Lite-On Communications Inc LNE100TX
> >   e400-e4ff : tulip
> > e800-e8ff : Lite-On Communications Inc LNE100TX (#2)
> >   e800-e8ff : tulip
> > ec00-ecff : Madge Networks Smart 16/4 PCI Ringnode Mk2
> >   ec00-ec3f : tr0
> > f000-f00f : Intel Corporation 82371AB PIIX4 IDE
> >
> > [root@ohdrouter linux]# cat /proc/iomem
> > 00000000-0009ffff : System RAM
> > 000a0000-000bffff : Video RAM area
> > 000c0000-000c7fff : Video ROM
> > 000f0000-000fffff : System ROM
> > 00100000-03ffffff : System RAM
> >   00100000-001e11cf : Kernel code
> >   001e11d0-00232c2b : Kernel data
> > e0000000-e3ffffff : Intel Corporation 440LX/EX - 82443LX/EX Host bridge
> > e4000000-e5ffffff : PCI Bus #01
> >   e4000000-e4ffffff : NVidia / SGS Thomson (Joint Venture) Riva128
> > e6000000-e6ffffff : PCI Bus #01
> >   e6000000-e6ffffff : NVidia / SGS Thomson (Joint Venture) Riva128
> > ea000000-ea0000ff : Lite-On Communications Inc LNE100TX
> >   ea000000-ea0000ff : tulip
> > ea001000-ea0010ff : Madge Networks Smart 16/4 PCI Ringnode Mk2
> > ea002000-ea0020ff : Lite-On Communications Inc LNE100TX (#2)
> >   ea002000-ea0020ff : tulip
> > ffff0000-ffffffff : reserved
> >
> > [7.5]
> > [root@ohdrouter linux]# cat lspci -vvv
> > 00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge
> > (rev 03)
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort+ >SERR- <PERR-
> >         Latency: 64 set
> >         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
> >         Capabilities: [a0] AGP version 1.0
> >                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
> >                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> >
> > 00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge
> > (rev 03) (prog-if 00 [Normal decode])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR+ FastB2B-
> >         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 64 set
> >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
> >         I/O behind bridge: 0000d000-0000dfff
> >         Memory behind bridge: e4000000-e5ffffff
> >         Prefetchable memory behind bridge: e6000000-e6ffffff
> >         BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
> >
> > 00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 0 set
> >
> > 00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
> > (prog-if 80 [Master])
> >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 64 set
> >         Region 4: I/O ports at f000 [size=16]
> >
> > 00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
> > (prog-if 00 [UHCI])
> >         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 64 set
> >         Interrupt: pin D routed to IRQ 10
> >         Region 4: I/O ports at e000 [size=32]
> >
> > 00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
> >         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Interrupt: pin ? routed to IRQ 9
> >
> > 00:09.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
> >         Subsystem: Netgear FA310TX
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 64 set
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: I/O ports at e400 [size=256]
> >         Region 1: Memory at ea000000 (32-bit, non-prefetchable) [size=256]
> >         Expansion ROM at e7000000 [disabled] [size=256K]
> >
> > 00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
> >         Subsystem: Netgear FA310TX
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 64 set
> >         Interrupt: pin A routed to IRQ 9
> >         Region 0: I/O ports at e800 [size=256]
> >         Region 1: Memory at ea002000 (32-bit, non-prefetchable) [size=256]
> >         Expansion ROM at e8000000 [disabled] [size=256K]
> >
> > 00:0b.0 Token ring network controller: Madge Networks Smart 16/4 PCI
> > Ringnode Mk2
> >         Subsystem: Madge Networks Smart 16/4 PCI Ringnode Mk2
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 64 set, cache line size 08
> >         Interrupt: pin A routed to IRQ 12
> >         Region 0: I/O ports at ec00 [size=256]
> >         Region 1: Memory at ea001000 (32-bit, non-prefetchable) [size=256]
> >         Expansion ROM at e9000000 [disabled] [size=1M]
> >
> > 01:00.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture)
> > Riva128 (rev 21) (prog-if 00 [VGA])
> >         Subsystem: STB Systems Inc STB Velocity 128
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 3 min, 1 max, 64 set
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
> >         Region 1: Memory at e6000000 (32-bit, prefetchable) [size=16M]
> >         Expansion ROM at e5000000 [disabled] [size=4M]
> >         Capabilities: [44] AGP version 1.0
> >                 Status: RQ=4 SBA- 64bit- FW- Rate=x1,x2
> >                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> >
> > [7.6] N/A ... no SCSI on this system
> >
> > [7.7] Its pretty standard PC hardware with the exception of the token ring
> > card which I know aren't nearly as widely used as ethernet cards.
> >
> > [root@ohdrouter linux]# free
> >              total       used       free     shared    buffers     cached
> > Mem:         62604      60068       2536          0       6120      47944
> > -/+ buffers/cache:       6004      56600
> > Swap:       136512       7280     129232
> >
> > [7.8] No ideas on patches or work arounds other than the mm/page_alloc.c
> > patch mentioned above.
> >
> >
> > * * *
> >
> > Please help!  =)
> >
> > We're only using this "router" in testing at this point but would like to
> > roll it into our department's network. I won't do that as long as it is
> > crashing once a week.
> >
> > If you need more information, I'll be happy to provide it let me know if I
> > can help.
> >
> > Thanks,
> >   Brian
> >
> >
>
>

