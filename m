Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264733AbTFQNts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 09:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbTFQNts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 09:49:48 -0400
Received: from ee.oulu.fi ([130.231.61.23]:38651 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264736AbTFQNtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 09:49:21 -0400
Date: Tue, 17 Jun 2003 17:02:59 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: andre@linux-ide.org
cc: linux-kernel@vger.kernel.org
Subject: PROBLEM: Oops when modprobing alim15x3 (2.4.21)
Message-ID: <Pine.GSO.4.55.0306171656000.10363@stekt37>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Summary:
Oops when modprobing alim15x3 (2.4.21, 2.4.20 works fine)

[2.] Full description:
When ALi support is compiled as module, and I type
	modprobe alim15x3
I get immediately kernel oops message. modprobe crashes with segmentation fault.

If the module is compiled statically into kernel, I get the following messages at
bootup, when a script runs hdparm -d 1 /dev/hda:

Jun 17 00:13:56 acerzone kernel: hda: dma_timer_expiry: dma status == 0x21
Jun 17 00:14:06 acerzone kernel: hda: timeout waiting for DMA
Jun 17 00:14:06 acerzone kernel: hda: timeout waiting for DMA
Jun 17 00:14:06 acerzone kernel: hda: (__ide_dma_test_irq) called while not waiting
Jun 17 00:14:17 acerzone kernel: hda: lost interrupt
Jun 17 00:14:37 acerzone last message repeated 2 times
Jun 17 00:14:57 acerzone kernel: hda: dma_timer_expiry: dma status == 0x21
Jun 17 00:15:07 acerzone kernel: hda: timeout waiting for DMA
Jun 17 00:15:07 acerzone kernel: hda: timeout waiting for DMA
Jun 17 00:15:07 acerzone kernel: hda: (__ide_dma_test_irq) called while not waiting
Jun 17 00:15:07 acerzone kernel: hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Jun 17 00:15:07 acerzone kernel:
Jun 17 00:15:07 acerzone kernel: hda: drive not ready for command

There is a delay of about one minute, then bootup continues. I don't know if this is related.

[3.] Keywords:
ali, alim15x3, ide, dma

[4.] Kernel version:
Linux version 2.4.21 (sys@acerzone) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Tue Jun 17 12:27:26 EEST 2003

[5.] Output of Oops (tested twice):
<1>Unable to handle kernel paging request at virtual address 2efbd814
<4>c0250004
<1>*pde = 00000000
<4>Oops: 0002
<4>CPU:    0
<4>EIP:    0010:[<c0250004>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
<4>EFLAGS: 00010286
<4>eax: c88d3a93   ebx: c3477e56   ecx: 00000cf8   edx: 00000000
<4>esi: c0274340   edi: c1171804   ebp: c3477e58   esp: c3477e40
<4>ds: 0018   es: 0018   ss: 0018
<4>Process modprobe (pid: 777, stackpage=c3477000)
<4>Stack: c0191914 c0274340 c0274340 c88d3ab2 c88df000 00051c4c c3477e94 c0191cbf
<4>       c1171800 c88d3a94 c0274340 c88d3a94 c1171800 c88d3ba0 00000000 00000000
<4>       00000000 00000000 00000000 008d3ba0 00000000 c3477eb0 c0191d31 c3477eac
<4>Call Trace:    [<c0191914>] [<c88d3ab2>] [<c0191cbf>] [<c88d3a94>] [<c88d3a94>]
<4>  [<c88d3ba0>] [<c0191d31>] [<c88d3a94>] [<c88d3105>] [<c88d3a94>] [<c88d3b60>]
<4>  [<c01950f1>] [<c88d3b60>] [<c88d3ba0>] [<c0195157>] [<c88d3ba0>] [<c88d3ba0>]
<4>  [<c0191d83>] [<c88d3ba0>] [<c88d3129>] [<c88d3ba0>] [<c01159a5>] [<c011b482>]
<4>  [<c88d2060>] [<c0106c93>]
<4>Code: 00 8f 10 c0 e4 6d 10 00 00 8f 10 c0 f0 6d 10 00 00 8e 10 c0


>>EIP; c0250004 <idt_table+4/800>   <=====

>>eax; c88d3a93 <[alim15x3].data.start+13/14>
>>ebx; c3477e56 <_end+31fde7a/8588024>
>>ecx; 00000cf8 Before first symbol
>>esi; c0274340 <ide_hwifs+0/2c88>
>>edi; c1171804 <_end+ef7828/8588024>
>>ebp; c3477e58 <_end+31fde7c/8588024>
>>esp; c3477e40 <_end+31fde64/8588024>

Trace; c0191914 <ide_hwif_setup_dma+48/f4>
Trace; c88d3ab2 <[alim15x3]ali15x3_chipsets+1e/60>
Trace; c0191cbf <do_ide_setup_pci_device+21b/274>
Trace; c88d3a94 <[alim15x3]ali15x3_chipsets+0/60>
Trace; c88d3a94 <[alim15x3]ali15x3_chipsets+0/60>
Trace; c88d3ba0 <[alim15x3]driver+0/3f>
Trace; c0191d31 <ide_setup_pci_device+19/20>
Trace; c88d3a94 <[alim15x3]ali15x3_chipsets+0/60>
Trace; c88d3105 <[alim15x3]alim15x3_init_one+45/5c>
Trace; c88d3a94 <[alim15x3]ali15x3_chipsets+0/60>
Trace; c88d3b60 <[alim15x3]alim15x3_pci_tbl+0/40>
Trace; c01950f1 <pci_announce_device+3d/60>
Trace; c88d3b60 <[alim15x3]alim15x3_pci_tbl+0/40>
Trace; c88d3ba0 <[alim15x3]driver+0/3f>
Trace; c0195157 <pci_register_driver+43/60>
Trace; c88d3ba0 <[alim15x3]driver+0/3f>
Trace; c88d3ba0 <[alim15x3]driver+0/3f>
Trace; c0191d83 <ide_pci_register_driver+17/50>
Trace; c88d3ba0 <[alim15x3]driver+0/3f>
Trace; c88d3129 <[alim15x3]ali15x3_ide_init+d/14>
Trace; c88d3ba0 <[alim15x3]driver+0/3f>
Trace; c01159a5 <sys_init_module+5b5/670>
Trace; c011b482 <timer_bh+26/35c>
Trace; c88d2060 <[alim15x3]ali_get_info+0/20>
Trace; c0106c93 <system_call+33/38>

Code;  c0250004 <idt_table+4/800>
00000000 <_EIP>:
Code;  c0250004 <idt_table+4/800>   <=====
   0:   00 8f 10 c0 e4 6d         add    %cl,0x6de4c010(%edi)   <=====
Code;  c025000a <idt_table+a/800>
   6:   10 00                     adc    %al,(%eax)
Code;  c025000c <idt_table+c/800>
   8:   00 8f 10 c0 f0 6d         add    %cl,0x6df0c010(%edi)
Code;  c0250012 <idt_table+12/800>
   e:   10 00                     adc    %al,(%eax)
Code;  c0250014 <idt_table+14/800>
  10:   00 8e 10 c0 00 00         add    %cl,0xc010(%esi)


<1>Unable to handle kernel paging request at virtual address 2efbd814
<4>c0250004
<1>*pde = 00000000
<4>Oops: 0002
<4>CPU:    0
<4>EIP:    0010:[<c0250004>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
<4>EFLAGS: 00010286
<4>eax: c88b8a93   ebx: c74b1e56   ecx: 00000cf8   edx: 00000000
<4>esi: c0274340   edi: c1171804   ebp: c74b1e58   esp: c74b1e40
<4>ds: 0018   es: 0018   ss: 0018
<4>Process modprobe (pid: 832, stackpage=c74b1000)
<4>Stack: c0191914 c0274340 c0274340 c88b8ab2 c88bf000 00051c4c c74b1e94 c0191cbf
<4>       c1171800 c88b8a94 c0274340 c88b8a94 c1171800 c88b8ba0 00000000 00000000
<4>       00000000 00000000 00000000 008b8ba0 00000000 c74b1eb0 c0191d31 c74b1eac
<4>Call Trace:    [<c0191914>] [<c88b8ab2>] [<c0191cbf>] [<c88b8a94>] [<c88b8a94>]
<4>  [<c88b8ba0>] [<c0191d31>] [<c88b8a94>] [<c88b8105>] [<c88b8a94>] [<c88b8b60>]
<4>  [<c01950f1>] [<c88b8b60>] [<c88b8ba0>] [<c0195157>] [<c88b8ba0>] [<c88b8ba0>]
<4>  [<c0191d83>] [<c88b8ba0>] [<c88b8129>] [<c88b8ba0>] [<c01159a5>] [<c88b7060>]
<4>  [<c0106c93>]
<4>Code: 00 8f 10 c0 e4 6d 10 00 00 8f 10 c0 f0 6d 10 00 00 8e 10 c0


>>EIP; c0250004 <idt_table+4/800>   <=====

>>eax; c88b8a93 <[alim15x3].data.start+13/14>
>>ebx; c74b1e56 <_end+7237e7a/8588024>
>>ecx; 00000cf8 Before first symbol
>>esi; c0274340 <ide_hwifs+0/2c88>
>>edi; c1171804 <_end+ef7828/8588024>
>>ebp; c74b1e58 <_end+7237e7c/8588024>
>>esp; c74b1e40 <_end+7237e64/8588024>

Trace; c0191914 <ide_hwif_setup_dma+48/f4>
Trace; c88b8ab2 <[alim15x3]ali15x3_chipsets+1e/60>
Trace; c0191cbf <do_ide_setup_pci_device+21b/274>
Trace; c88b8a94 <[alim15x3]ali15x3_chipsets+0/60>
Trace; c88b8a94 <[alim15x3]ali15x3_chipsets+0/60>
Trace; c88b8ba0 <[alim15x3]driver+0/3f>
Trace; c0191d31 <ide_setup_pci_device+19/20>
Trace; c88b8a94 <[alim15x3]ali15x3_chipsets+0/60>
Trace; c88b8105 <[alim15x3]alim15x3_init_one+45/5c>
Trace; c88b8a94 <[alim15x3]ali15x3_chipsets+0/60>
Trace; c88b8b60 <[alim15x3]alim15x3_pci_tbl+0/40>
Trace; c01950f1 <pci_announce_device+3d/60>
Trace; c88b8b60 <[alim15x3]alim15x3_pci_tbl+0/40>
Trace; c88b8ba0 <[alim15x3]driver+0/3f>
Trace; c0195157 <pci_register_driver+43/60>
Trace; c88b8ba0 <[alim15x3]driver+0/3f>
Trace; c88b8ba0 <[alim15x3]driver+0/3f>
Trace; c0191d83 <ide_pci_register_driver+17/50>
Trace; c88b8ba0 <[alim15x3]driver+0/3f>
Trace; c88b8129 <[alim15x3]ali15x3_ide_init+d/14>
Trace; c88b8ba0 <[alim15x3]driver+0/3f>
Trace; c01159a5 <sys_init_module+5b5/670>
Trace; c88b7060 <[alim15x3]ali_get_info+0/20>
Trace; c0106c93 <system_call+33/38>

Code;  c0250004 <idt_table+4/800>
00000000 <_EIP>:
Code;  c0250004 <idt_table+4/800>   <=====
   0:   00 8f 10 c0 e4 6d         add    %cl,0x6de4c010(%edi)   <=====
Code;  c025000a <idt_table+a/800>
   6:   10 00                     adc    %al,(%eax)
Code;  c025000c <idt_table+c/800>
   8:   00 8f 10 c0 f0 6d         add    %cl,0x6df0c010(%edi)
Code;  c0250012 <idt_table+12/800>
   e:   10 00                     adc    %al,(%eax)
Code;  c0250014 <idt_table+14/800>
  10:   00 8e 10 c0 00 00         add    %cl,0xc010(%esi)

[7.1.] Software Debian 3.0:

Linux acerzone 2.4.21 #3 Tue Jun 17 12:27:26 EEST 2003 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
pcmcia-cs              3.1.29
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         3c589_cs ds i82365 pcmcia_core nfsd autofs4 apm snd-card-es1938 snd-pcm snd-opl3 snd-hwdep snd-timer snd-seq-device snd soundcore ide-cd cdrom floppy serial rtc unix

[7.2.] Processor information
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Mobile Pentium II
stepping        : 10
cpu MHz         : 365.818
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 730.72

[7.3.] Module information:
alim15x3                7148 (initializing)
videodev                5536   0 (unused)
usb-ohci               19904   0 (unused)
usbcore                60992   0 [usb-ohci]
3c589_cs                8800   1
ds                      6592   1 [3c589_cs]
i82365                 22256   1
pcmcia_core            38144   0 [3c589_cs ds i82365]
nfsd                   66848   8 (autoclean)
autofs4                 8292   1 (autoclean)
apm                     9380   2 (autoclean)
snd-card-es1938        10688   0 (autoclean)
snd-pcm                44832   0 (autoclean) [snd-card-es1938]
snd-opl3                5088   0 (autoclean) [snd-card-es1938]
snd-hwdep               3456   0 (autoclean) [snd-opl3]
snd-timer               8960   0 (autoclean) [snd-pcm snd-opl3]
snd-seq-device          3728   0 (autoclean) [snd-opl3]
snd                    23048   0 (autoclean) [snd-card-es1938 snd-pcm snd-opl3 snd-hwdep snd-timer snd-seq-device]
soundcore               3364   1 (autoclean) [snd]
ide-cd                 28800   0 (autoclean)
cdrom                  27008   0 (autoclean) [ide-cd]
floppy                 45184   0 (autoclean)
serial                 41632   1 (autoclean)
rtc                     5756   0 (autoclean)
unix                   13956  25 (autoclean)

[7.4.] Loaded driver and hardware information:
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
0300-030f : 3c589_cs
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
6c20-6c3f : ALi Corporation. [ALi] M7101 PMU
7090-709f : ALi Corporation. [ALi] M5229 IDE
9000-903f : ESS Technology ES1969 Solo-1 Audiodrive
  9000-9007 : ESS Solo-1
9050-905f : ESS Technology ES1969 Solo-1 Audiodrive
  9050-905f : ESS Solo-1 SB
9070-907f : ESS Technology ES1969 Solo-1 Audiodrive
  9070-907f : ESS Solo-1 VC (DMA)
9090-9093 : ESS Technology ES1969 Solo-1 Audiodrive
  9090-9093 : ESS Solo-1 MIDI
90a4-90a7 : ESS Technology ES1969 Solo-1 Audiodrive
  90a4-90a7 : ESS Solo-1 GAME
90b8-90bf : Lucent Microelectronics WinModem 56k
9400-94ff : Lucent Microelectronics WinModem 56k

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-001dbfa3 : Kernel code
  001dbfa4-0023d357 : Kernel data
07ff0000-07ff7fff : ACPI Tables
07ff8000-07ffffff : ACPI Non-volatile Storage
10000000-10000fff : O2 Micro, Inc. OZ6812 Cardbus Controller
  10000000-10000fff : i82365
80500000-810fffff : PCI Bus #01
  80500000-8051ffff : Trident Microsystems Cyber 9525
  80800000-80bfffff : Trident Microsystems Cyber 9525
  80c00000-80ffffff : Trident Microsystems Cyber 9525
81400000-814000ff : Lucent Microelectronics WinModem 56k
81600000-81600fff : ALi Corporation. [ALi] USB 1.1 Controller
a0000000-a0000fff : card services
e0000000-e3ffffff : ALi Corporation. [ALi] M1621
ffff0000-ffffffff : reserved

[7.5.] PCI information:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: ALi Corporation. [ALi] M1621 (rev 5).
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: ALi Corporation. [ALi] PCI to AGP Controller (rev 1).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   6, function  0:
    Communication controller: Lucent Microelectronics WinModem 56k (rev 1).
      IRQ 9.
      Master Capable.  No bursts.  Min Gnt=252.Max Lat=14.
      Non-prefetchable 32 bit memory at 0x81400000 [0x814000ff].
      I/O at 0x90b8 [0x90bf].
      I/O at 0x9400 [0x94ff].
  Bus  0, device   7, function  0:
    ISA bridge: ALi Corporation. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev 10).
  Bus  0, device   8, function  0:
    Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodrive (rev 2).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0x9000 [0x903f].
      I/O at 0x9050 [0x905f].
      I/O at 0x9070 [0x907f].
      I/O at 0x9090 [0x9093].
      I/O at 0x90a4 [0x90a7].
  Bus  0, device  15, function  0:
    IDE interface: ALi Corporation. [ALi] M5229 IDE (rev 32).
      IRQ 15.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0x7090 [0x709f].
  Bus  0, device  17, function  0:
    Bridge: ALi Corporation. [ALi] M7101 PMU (rev 9).
  Bus  0, device  19, function  0:
    CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev 5).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=128.Max Lat=4.
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device  20, function  0:
    USB Controller: ALi Corporation. [ALi] USB 1.1 Controller (rev 3).
      IRQ 10.
      Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0x81600000 [0x81600fff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Trident Microsystems Cyber 9525 (rev 73).
      IRQ 9.
      Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0x80800000 [0x80bfffff].
      Non-prefetchable 32 bit memory at 0x80500000 [0x8051ffff].
      Non-prefetchable 32 bit memory at 0x80c00000 [0x80ffffff].

[7.7.] Other information:
This is Acer Travelmate 332T laptop.

[X.] Other notes:
I didn't have problems with 2.4.20, with it DMA works just fine. 2.4.21
works also fine but without DMA.
The harddisk makes very strange sound, it makes sometimes "snapping"
sounds when idle, especially when starting to read something. There may
be also irritating about 1 sec delay.
I would believe that it's broken, my desktop harddisks have never made
that sound (unless they _were_ broken). However, this is brand new Hitachi
harddisk that I bought after the previous IBM Travelstar went broken
(and it also kept the same sound). Strange. But maybe new laptop harddisks
do this normally. And probably this isn't related to the above bug anyway.

No SMP support compiled in, ... let me know if you need kernel config.
