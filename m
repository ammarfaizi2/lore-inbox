Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130247AbQLJJ1I>; Sun, 10 Dec 2000 04:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130322AbQLJJ06>; Sun, 10 Dec 2000 04:26:58 -0500
Received: from home.ppetru.net ([193.230.129.57]:59008 "HELO home.ppetru.net")
	by vger.kernel.org with SMTP id <S130247AbQLJJ0t>;
	Sun, 10 Dec 2000 04:26:49 -0500
Date: Sun, 10 Dec 2000 10:55:53 +0200
From: Petru Paler <ppetru@ppetru.net>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: sparc64 network-related problems
Message-ID: <20001210105553.E728@ppetru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me know if you need additional info or testing done.

Bug report (in standard format):

[1.] One line summary of the problem:                                                            

Repeated kernel oopses, after a while of functioning under
heavy load.

[2.] Full description of the problem/report:                                                     

We use 4 E450 clones for DNS and mail servers. They are
always under heavy load, and after a while (usually a day)
of functioning, they start oopsing and eventually (after
a couple more days) they lock up.

[3.] Keywords (i.e., modules, networking, kernel):                                               

kernel, sparc64, networking

[4.] Kernel version (from /proc/version):                                                        

Linux version 2.4.0-test12 (root@grey) (gcc version egcs-2.92.11 19980921 (gcc2 ss-980609 experimental)) #2 SMP Tue Dec 5 11:27:36 EST 2000                                                       

It's actually 2.4.0-test12-pre5, with one minor patch to drivers/pci/pci.c
(I added a missing declaration for "tmp" in pci_read_bases() otherwise it
didn't compile).

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)                                               

This is only one of the repeated oopses, if you need all of them I will
make the logs available.

skput:over: 000000000053ed64:524 put:-428 dev:eth0              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
smtp(29923): Kernel bad trap
CPU[2]: local_irq_count[0] irqs_running[0]
TSTATE: 0000004411009601 TPC: 0000000000528b50 TNPC: 0000000000528b54 Y: 15e00000
g0: 0000000000000020 g1: 000020fa29bf28c5 g2: 0000000000410000 g3: 0000000000628000
g4: fffff80000000000 g5: 0000000000000001 g6: fffff800030e8000 g7: 0000000000000000
o0: 0000000000000032 o1: 0000000000629eae o2: 0000000000000032 o3: 0000000000000000
o4: 0000000000629e7b o5: 0000000000629ead sp: fffff800030eb1c1 ret_pc: 0000000000528b48
l0: 000000000064ec00 l1: 7ffffffffffffff8 l2: 8000000000000000 l3: 0800000000000000
l4: 0000000000000077 l5: 0000000000000002 l6: 0000000000000000 l7: 000000000062a278
i0: fffff80020f59b00 i1: fffffffffffffe54 i2: 000000000053ed64 i3: 00000000fffffe54
i4: 00000000000003b8 i5: 0000000000000000 i6: fffff800030eb281 i7: 000000000053ed68
Caller[000000000053ed68]
Caller[000000000055e4e0]
Caller[00000000005255b4]
Caller[0000000000525818]
Caller[000000000045e894]
Caller[000000000040fc34]
Caller[00000000000228fc]
Instruction DUMP: 981223a8  7ffc5ee6  9010000d <91d02005> 30680003  01000000  01000000  9de3bf40  1100167b
CPU[0]: local_irq_count[0] irqs_running[0]
TSTATE: 0000000011f09602 TPC: 0000000000448f68 TNPC: 0000000000448f6c Y: 00000000
g0: 0000000000691800 g1: 0000000000694800 g2: 00000000003fffff g3: 000000000000738a
g4: fffff80000000000 g5: 0000000000000000 g6: fffff8003ec0c000 g7: 0000000000000000
o0: 00000000000000b9 o1: 0000000001148e1b o2: 00000000005a9400 o3: 000000000000001a
o4: 00000000004de180 o5: 0000000000000000 sp: fffff8003ec0f061 ret_pc: 0000000000448e80
l0: 0000000000000001 l1: 00000000005a9798 l2: 000000000062f400 l3: ffffffffffffffff
l4: fffff8003c2f16a0 l5: 0000000000000002 l6: 0000000000630400 l7: 0000000000585d30
i0: 000000000062e500 i1: 0000000000694800 i2: 00000000005a9790 i3: 0000000000000001
i4: 0000000000000000 i5: 000000000000000f i6: fffff8003ec0f121 i7: 0000000000445510

After running through ksymoops:

ksymoops 2.3.4 on sparc64 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /boot/System.map-2.4.0-test12 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Reading Oops report from the terminal
skput:over: 000000000053ed64:524 put:-428 dev:eth0              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
smtp(29923): Kernel bad trap
CPU[2]: local_irq_count[0] irqs_running[0]
TSTATE: 0000004411009601 TPC: 0000000000528b50 TNPC: 0000000000528b54 Y: 15e00000
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 0000000000000020 g1: 000020fa29bf28c5 g2: 0000000000410000 g3: 0000000000628000
g4: fffff80000000000 g5: 0000000000000001 g6: fffff800030e8000 g7: 0000000000000000
o0: 0000000000000032 o1: 0000000000629eae o2: 0000000000000032 o3: 0000000000000000
o4: 0000000000629e7b o5: 0000000000629ead sp: fffff800030eb1c1 ret_pc: 0000000000528b48
l0: 000000000064ec00 l1: 7ffffffffffffff8 l2: 8000000000000000 l3: 0800000000000000
l4: 0000000000000077 l5: 0000000000000002 l6: 0000000000000000 l7: 000000000062a278
i0: fffff80020f59b00 i1: fffffffffffffe54 i2: 000000000053ed64 i3: 00000000fffffe54
i4: 00000000000003b8 i5: 0000000000000000 i6: fffff800030eb281 i7: 000000000053ed68
Caller[000000000053ed68]
Caller[000000000055e4e0]
Caller[00000000005255b4]
Caller[0000000000525818]
Caller[000000000045e894]
Caller[000000000040fc34]
Caller[00000000000228fc]
Instruction DUMP: 981223a8  7ffc5ee6  9010000d <91d02005> 30680003  01000000  01000000  9de3bf40  1100167b

>>PC;  00528b50 <skb_over_panic+30/40>   <=====
>>O7;  00528b48 <skb_over_panic+28/40>
>>I7;  0053ed68 <tcp_sendmsg+2e8/c60>
Trace; 0053ed68 <tcp_sendmsg+2e8/c60>
Trace; 0055e4e0 <inet_sendmsg+40/60>
Trace; 005255b4 <sock_sendmsg+74/a0>
Trace; 00525818 <sock_write+98/c0>
Trace; 0045e894 <sys_write+b4/100>
Trace; 0040fc34 <linux_sparc_syscall32+34/40>
Trace; 000228fc Before first symbol
Code;  00528b44 <skb_over_panic+24/40>
0000000000000000 <_PC>:
Code;  00528b44 <skb_over_panic+24/40>
   0:   98 12 23 a8       or  %o0, 0x3a8, %o4
Code;  00528b48 <skb_over_panic+28/40>
   4:   7f fc 5e e6       call  fffffffffff17b9c <_PC+0xfffffffffff17b9c> 004406e0 <printk+0/240>
Code;  00528b4c <skb_over_panic+2c/40>
   8:   90 10 00 0d       mov  %o5, %o0
Code;  00528b50 <skb_over_panic+30/40>   <=====
   c:   91 d0 20 05       ta  5   <=====
Code;  00528b54 <skb_over_panic+34/40>
  10:   30 68 00 03       unknown
Code;  00528b58 <skb_over_panic+38/40>
  14:   01 00 00 00       nop 
Code;  00528b5c <skb_over_panic+3c/40>
  18:   01 00 00 00       nop 
Code;  00528b60 <skb_under_panic+0/40>
  1c:   9d e3 bf 40       save  %sp, -192, %sp
Code;  00528b64 <skb_under_panic+4/40>
  20:   11 00 16 7b       sethi  %hi(0x59ec00), %o0

CPU[0]: local_irq_count[0] irqs_running[0]
TSTATE: 0000000011f09602 TPC: 0000000000448f68 TNPC: 0000000000448f6c Y: 00000000
g0: 0000000000691800 g1: 0000000000694800 g2: 00000000003fffff g3: 000000000000738a
g4: fffff80000000000 g5: 0000000000000000 g6: fffff8003ec0c000 g7: 0000000000000000
o0: 00000000000000b9 o1: 0000000001148e1b o2: 00000000005a9400 o3: 000000000000001a
o4: 00000000004de180 o5: 0000000000000000 sp: fffff8003ec0f061 ret_pc: 0000000000448e80
l0: 0000000000000001 l1: 00000000005a9798 l2: 000000000062f400 l3: ffffffffffffffff
l4: fffff8003c2f16a0 l5: 0000000000000002 l6: 0000000000630400 l7: 0000000000585d30
i0: 000000000062e500 i1: 0000000000694800 i2: 00000000005a9790 i3: 0000000000000001
i4: 0000000000000000 i5: 000000000000000f i6: fffff8003ec0f121 i7: 0000000000445510
Warning (Oops_read): Code line not seen, dumping what data is available

>>PC;  00448f68 <timer_bh+128/3c0>   <=====
>>O7;  00448e80 <timer_bh+40/3c0>
>>I7;  00445510 <bh_action+70/120>


3 warnings issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)                                                                       

N/A. The problem appears after about one day of heavy load.

[7.] Environment                                                                                 

[7.1.] Software (add the output of the ver_linux script here)                                    

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux grey 2.4.0-test12 #2 SMP Tue Dec 5 11:27:36 EST 2000 sparc64 unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded                                                                                   

DNS server: tinydns (from the djbdns 1.02 package)
Mail server: Postfix (Snapshot-20001030)

[7.2.] Processor information (from /proc/cpuinfo):                                               

Two of the servers are:

cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU
promlib         : Version 3 Revision 10
prom            : 3.10.7
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
Cpu0Bogo        : 398.95
Cpu2Bogo        : 399.76
MMU Type        : Spitfire
State:
CPU0:           online
CPU2:           online                                                                           

The other two are:

cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU
promlib         : Version 3 Revision 10
prom            : 3.10.7
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
Cpu0Bogo        : 591.46
Cpu2Bogo        : 591.46
MMU Type        : Spitfire
State:
CPU0:           online
CPU2:           online                                                                           

[7.3.] Module information (from /proc/modules):                                                  

N/A (no modules loaded)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)                       

grey:~# cat /proc/ioports
1c802000000-1c80200ffff : PSYCHO1 PBMA
1c802010000-1c80201ffff : PSYCHO1 PBMB
  1c802010400-1c8020104ff : Symbios Logic Inc. (formerly NCR) 53c875
    1c802010400-1c80201047f : sym53c8xx
  1c802010800-1c8020108ff : Symbios Logic Inc. (formerly NCR) 53c875 (#2)
    1c802010800-1c80201087f : sym53c8xx
1fe02000000-1fe0200ffff : PSYCHO0 PBMA
1fe02010000-1fe0201ffff : PSYCHO0 PBMB
  1fe02010400-1fe020104ff : Emulex Corporation LP7000 Fibre Channel Host Adapter
  1fe02010500-1fe020105ff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
  1fe02010800-1fe020108ff : Emulex Corporation LP7000 Fibre Channel Host Adapter (#2)            

grey:~# cat /proc/iomem
1c900000000-1c97fffffff : PSYCHO1 PBMA
1c980000000-1c9ffffffff : PSYCHO1 PBMB
  1c980002000-1c9800020ff : Symbios Logic Inc. (formerly NCR) 53c875
  1c980004000-1c980004fff : Symbios Logic Inc. (formerly NCR) 53c875
  1c980006000-1c9800060ff : Symbios Logic Inc. (formerly NCR) 53c875 (#2)
  1c980008000-1c980008fff : Symbios Logic Inc. (formerly NCR) 53c875 (#2)
1ff00000000-1ff7fffffff : PSYCHO0 PBMA
1ff80000000-1ffffffffff : PSYCHO0 PBMB
  1ff80000000-1ff80000fff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
  1ff80008000-1ff8000ffff : Sun Microsystems Computer Corp. Happy Meal
  1ff80020000-1ff8003ffff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
  1ff80040000-1ff8005ffff : Emulex Corporation LP7000 Fibre Channel Host Adapter
  1ff80060000-1ff8007ffff : Emulex Corporation LP7000 Fibre Channel Host Adapter (#2)
  1ff81000000-1ff81ffffff : ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
    1ff81000000-1ff81ffffff : atyfb
  1ff82000000-1ff82000fff : Emulex Corporation LP7000 Fibre Channel Host Adapter
  1ff82002000-1ff820020ff : Emulex Corporation LP7000 Fibre Channel Host Adapter
  1ff82004000-1ff82004fff : Emulex Corporation LP7000 Fibre Channel Host Adapter (#2)
  1ff82006000-1ff820060ff : Emulex Corporation LP7000 Fibre Channel Host Adapter (#2)
  1ff83000000-1ff83ffffff : Sun Microsystems Computer Corp. EBUS
  1ff84000000-1ff84ffffff : Sun Microsystems Computer Corp. Happy Meal
  1fff0000000-1fff0ffffff : Sun Microsystems Computer Corp. EBUS
    1fff0000000-1fff00fffff : flashprom
  1fff1000000-1fff17fffff : Sun Microsystems Computer Corp. EBUS
    1fff1000000-1fff1001fff : eeprom
    1fff130015c-1fff130015d : ecpp
    1fff13203f0-1fff13203f7 : fdthree
    1fff1340278-1fff1340287 : ecpp
    1fff13602f8-1fff13602ff : su_pnp
    1fff13803f8-1fff13803ff : su_pnp
    1fff1400000-1fff140007f : se
    1fff1500000-1fff1500007 : sc
    1fff1504000-1fff1504002 : SUNW,pll
    1fff1600000-1fff1600003 : i2c
    1fff1700000-1fff170000f : ecpp
    1fff1706000-1fff170600f : fdthree
    1fff1720000-1fff1720003 : fdthree
    1fff1724000-1fff1724003 : power
    1fff1726000-1fff1726003 : auxio
    1fff1728000-1fff1728003 : auxio
    1fff172a000-1fff172a003 : auxio
    1fff172c000-1fff172c003 : auxio
    1fff172f000-1fff172f003 : auxio                                                              

[7.5.] PCI information ('lspci -vvv' as root)                                                    

grey:~# lspci -vvv
00:00.0 Host bridge: Sun Microsystems Computer Corp. PCI Bus Module
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 set

00:06.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 14)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 17 min, 64 max, 17 set, cache line size 10
        Interrupt: pin A routed to IRQ 6627584
        Region 0: I/O ports at 2010400 [size=256]
        Region 1: Memory at 000001c980002000 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at 000001c980004000 (32-bit, non-prefetchable) [size=4K]

00:06.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 14)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 17 min, 64 max, 17 set, cache line size 10
        Interrupt: pin A routed to IRQ 6627584
        Region 0: I/O ports at 2010800 [size=256]
        Region 1: Memory at 000001c980006000 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at 000001c980008000 (32-bit, non-prefetchable) [size=4K]

01:00.0 Host bridge: Sun Microsystems Computer Corp. PCI Bus Module
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 set

02:00.0 Host bridge: Sun Microsystems Computer Corp. PCI Bus Module
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 set

02:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 min, 25 max, 10 set, cache line size 10
        Region 0: Memory at 000001fff0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at 000001fff1000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at 0000000083000000 [disabled] [size=16M]

02:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Meal (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 min, 5 max, 10 set, cache line size 10
        Interrupt: pin ? routed to IRQ 6682912
        Region 0: Memory at 000001ff80008000 (32-bit, non-prefetchable) [size=32K]
        Expansion ROM at 0000000084000000 [disabled] [size=16M]

02:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC] (rev 3a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0088
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 set, cache line size 10
        Interrupt: pin A routed to IRQ 6682368
        Region 0: Memory at 000001ff81000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at 2010500 [size=256]
        Region 2: [virtual] Memory at 000001ff80000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 0000000080020000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.0 Fiber Channel: Emulex Corporation LP7000 Fibre Channel Host Adapter (rev 03)
        Subsystem: Emulex Corporation: Unknown device f700
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 set, cache line size 10
  

[7.6.] SCSI information (from /proc/scsi/scsi)                                                   

Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST39236LW        Rev: 0010
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST39103LW        Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST39102LW        Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 02                                

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):                                                                    

The servers are hooked into a Cisco switch. The link up line says:

eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.

The default gateway is an Intel box running FreeBSD, also having a 
full-duplex link to the switch (but with an EtherExpress Pro card).

grey:/proc# cat mdstat
Personalities : [raid0]
read_ahead 1024 sectors
md0 : active raid0 sdc1[1] sdb1[0]
      17776896 blocks 8k chunks                                                                  

Other kernel log errors:

(only seen once):
eth0: Happy Meal out of receive descriptors, packet dropped.                                     

(very often):
UDP: short packet: 1/48                                                                          
or
UDP: short packet: 0/36

and a couple of:
sending pkt_too_big to self                                                                      

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
