Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKVL2S>; Wed, 22 Nov 2000 06:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129520AbQKVL2H>; Wed, 22 Nov 2000 06:28:07 -0500
Received: from zeus.kernel.org ([209.10.41.242]:55564 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129150AbQKVL1z>;
	Wed, 22 Nov 2000 06:27:55 -0500
Message-ID: <3A1BA0D5.54918887@connex.ro>
Date: Wed, 22 Nov 2000 12:32:53 +0200
From: Sergiu Partenie <sergiu.partenie@connex.ro>
Organization: MobiFon S.A.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en, ro
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ne2k-pci freezes with APIC error on 2.4.0-testX SMP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] ne2k-pci freezes with APIC error on 2.4.0-testX SMP

[2.] bug. (as i don't think it is a feature :)
found in all 2.4.0 versions i tried: test5, 6, 7, 8, 9, 10, 11

When doing massive NFS transfers (2.4 machine as the client) on my SMP
box
(Abit BP6 2x celeronA 533mhz (non-overclocked) 64Mb ram, latest
apt-get-ed
debian woody) my ne2k-pci card (Realtek Semiconductor Co., Ltd.
RTL-8029(AS)
 (rev 0)) suddenly stops working. test5 spits that in syslog:

Aug  4 23:08:51 sonic kernel: Linux version 2.4.0-test5 (root@sonic)
(gcc version 2.9
5.2 20000220 (Debian GNU/Linux)) #2 SMP Tue Aug 1 08:31:01 EEST 2000
....
Aug  4 23:08:51 sonic kernel: ne2k-pci.c:vpre-1.00e 5/27/99 D. Becker/P.
Gortmaker ht
tp://cesdis.gsfc.nasa.gov/linux/drivers/ne2k-pci.html
Aug  4 23:08:51 sonic kernel: eth0: RealTek RTL-8029 found at 0xd400,
IRQ 17, 00:4F:4
9:00:AF:E4.
....
Aug  4 23:39:42 sonic kernel: APIC error interrupt on CPU#1, should
never happen.
Aug  4 23:39:42 sonic kernel: ... APIC ESR0: 00000000
Aug  4 23:39:42 sonic kernel: ... APIC ESR1: 00000008
Aug  4 23:39:42 sonic kernel: ... bit 3: APIC Receive Accept Error.
Aug  4 23:47:58 sonic kernel: APIC error interrupt on CPU#1, should
never happen.
Aug  4 23:47:58 sonic kernel: ... APIC ESR0: 00000008
Aug  4 23:47:58 sonic kernel: ... APIC ESR1: 00000008
Aug  4 23:47:58 sonic kernel: ... bit 3: APIC Receive Accept Error.

in test 6,7 and 8 it dies silently (no syslog messages)

also in test11 is quiet

in test9 and 10 dmesg will show:
kernel: APIC error on CPU1: 00(02)
kernel: APIC error on CPU1: 02(08)

the errors usually apear in pair and on CPU1 but sometimes also on CPU0.
if
it'll helps i'll send you `grep "APIC error" syslog`

those errors will apear immediatelly before the net card hangs but also
at
random times with no effect on the network card (ex: when the sound card
plays soething it spits the APIC errs and immediately after a Sound: DMA
(output) timed out )

The card acts like the UTP cable is cut (but the hub led is still on).
ifconfig down/up does not help. rmmod insmod neither. Neither resetting
the
hub or trying to connect the card trough BNC and back to trigger media
autosense. Only reboot helps.

[3.] kernel 2.4 network smp ne2k-pci apic

[4.] 2.4.0test5 trough test11 - kernel from ftp.kernel.org

[5.] no oops

[6.] This fennomenon is usually triggered by large nfs transfers
(watching a
divx from a directory mounted from another machine - after 100-300Mb it
dies) but sometimes even by simple telnet/http/ftp sessions.

The bug is not reproductible with small transfers - sometimes it will
die,
sometimes not. It will certainly lockup after transfering fast (cat,dd)
some
1G file over nfs of ftp-ing that file.

[7.]
[7.1.]
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux sonic 2.4.0-test11 #27 SMP Tue Nov 21 07:27:02 EET 2000 i686
unknown
Kernel modules         2.3.19
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.91
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10p
Net-tools              2.05
Kbd                    command
Sh-utils               2.0i
Modules Loaded         eeprom w83781d sensors i2c-isa i2c-piix4 i2c-core
mad16 ad1848 uart401

[7.2.]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 534.000555
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr
bogomips        : 1064.96

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 534.000555
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr
bogomips        : 1068.24

[7.3.]
eeprom                  3232   0 (unused)
w83781d                17312   0 (unused)
sensors                 6112   0 [eeprom w83781d]
i2c-isa                 1200   0 (unused)
i2c-piix4               3712   0 (unused)
i2c-core               12592   0 [eeprom w83781d sensors i2c-isa
i2c-piix4]
mad16                   7664   0 (unused)
ad1848                 16816   1 [mad16]
uart401                 6320   0 [mad16]

[7.4.]
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
0290-0297 : w83782d
02f8-02ff : serial(set)
0330-0333 : MPU-401 UART
0376-0376 : ide1
0378-037a : parport1
03b0-03bb : hgafb
03bc-03be : parport0
03bf-03bf : hgafb
03c0-03df : vga+
03e8-03ef : serial(set)
03f6-03f6 : ide0
03f8-03ff : serial(set)
0530-0533 : MAD16 WSS config
0534-0537 : MAD16 WSS
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
  5000-5007 : piix4-smbus
c000-cfff : PCI Bus #01
d000-d01f : Intel Corporation 82371AB PIIX4 USB
d400-d41f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  d400-d41f : ne2k-pci
d800-d807 : Triones Technologies, Inc. HPT366
dc00-dc03 : Triones Technologies, Inc. HPT366
e000-e0ff : Triones Technologies, Inc. HPT366
  e000-e007 : ide2
  e010-e0ff : HPT366
e400-e407 : Triones Technologies, Inc. HPT366 (#2)
e800-e803 : Triones Technologies, Inc. HPT366 (#2)
ec00-ecff : Triones Technologies, Inc. HPT366 (#2)
  ec00-ec07 : ide3
  ec10-ecff : HPT366
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03feffff : System RAM
  00100000-0029ed57 : Kernel code
  0029ed58-002b9e3f : Kernel data
03ff0000-03ff2fff : ACPI Non-volatile Storage
03ff3000-03ffffff : ACPI Tables
e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
e4000000-e7ffffff : PCI Bus #01
  e4000000-e4003fff : Matrox Graphics, Inc. MGA G400 AGP
  e5000000-e57fffff : Matrox Graphics, Inc. MGA G400 AGP
e8000000-e9ffffff : PCI Bus #01
  e8000000-e9ffffff : Matrox Graphics, Inc. MGA G400 AGP
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.]
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog
-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e4000000-e7ffffff
        Prefetchable memory behind bridge: e8000000-e9ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Mast
er])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHC
I])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 0
        Region 4: I/O ports at d000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at d400 [size=32]

00:13.0 Unknown mass storage controller: Triones Technologies, Inc.
HPT366 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d800 [size=8]
        Region 1: I/O ports at dc00 [size=4]
        Region 4: I/O ports at e000 [size=256]
        Expansion ROM at ea000000 [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc.
HPT366 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 18
        Region 0: I/O ports at e400 [size=8]
        Region 1: I/O ports at e800 [size=4]
        Region 4: I/O ports at ec00 [size=256]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 04) (prog-
if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head
32Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at e4000000 (32-bit, non-prefetchable)
[size=16K]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable)
[size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1

[7.7.]
/proc/interrupts:
           CPU0       CPU1       
  0:      39517      37316    IO-APIC-edge  timer
  1:        513        633    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:         44          7    IO-APIC-edge  serial
  8:          0          1    IO-APIC-edge  rtc
  9:          2          0    IO-APIC-edge  MPU-401 UART
 11:          0          0    IO-APIC-edge  MAD16 WSS
 12:        410        433    IO-APIC-edge  PS/2 Mouse
 14:       1240       1899    IO-APIC-edge  ide0
 15:          4         11    IO-APIC-edge  ide1
 16:          0          0   IO-APIC-level  mga@PCI:1:0:0
 17:         99        107   IO-APIC-level  eth0
NMI:      76772      76772 
LOC:      76616      76589 
ERR:          0

[X.]
after a freeze the interrupt count in /proc/interrupts for the network
card
does no longer increase 

the other machine used for the test runs 2.2.13, has a Xircom cem33
pcmcia
net card, latest Debian woody, tried with kernel-nfs-server and
user-nfs-server.

2.2.x SMP/nonSMP works O.K. 

2.4.x SMP booted with "nosmp" or "numcpus=1" will act funny (at least
the
versions 5 trough 8 ) - the network card remains on IRQ17 but the
machine
with only one cpu is not able see beyond IRQ15 .

the Realtek card never gave a glitch before.

i'l be happy to run any dang test you'll want me to run.

PLEASE help me. This bug is REALLY annoying. I don't want to switch back
to
2.2 as 2.4 is WAY faster and i certainly don't want to remove one cpu :)

if you have some questions or answers - reply to this e-mail address as
i am 
not subscribed to linux-kernel

Thank you very much... (and congrats to Linux for the new daughter :)

--
Sergiu Partenie - UNIX System Administrator - MobiFon S.A.
sergiu.partenie@connex.ro psergiu@xmail.ro #1764 093250006
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
