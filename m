Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbUBWLCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 06:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUBWLCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 06:02:36 -0500
Received: from smtp1.xs4all.be ([195.144.64.135]:55182 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S261911AbUBWLC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 06:02:26 -0500
From: Bart Janssens <bart.janssens@polytechnic.be>
To: linux-kernel@vger.kernel.org
Subject: OOPS: ext3 on 2.6.3 with high IO
Date: Mon, 23 Feb 2004 12:02:17 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402231202.17307.bart.janssens@polytechnic.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

1. I am getting a kernel oops when having high IO on an ext3 partition in 
2.6.3.

2. So far I have had this problem 3 times (once in 2.6.0, in 2.6.1 and now in 
2.6.3, I never ran 2.6.2). It always happens when I make a backup using 
rdiff-backup, copying files from one ext3 partition to the other or inside 
the same ext3 partition. Moderate IO-activities, like compiling the kernel 
posed no problems so far.

3. Keywords: oops, ext3, high IO

4. Linux version 2.6.3 (root@sofia) (gcc version 3.2.3) #1 Sun Feb 22 10:09:36 
CET 2004

5. ksymoops 2.4.9 on i686 2.6.3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000037
c0223467
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0223467>]    Tainted: P  
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010212
eax: ffffffff   ebx: 00000001   ecx: f7bf1900   edx: ce02a680
esi: 00000008   edi: ce02a680   ebp: 00000001   esp: f7d39d50
ds: 007b   es: 007b   ss: 0068
Stack: f7d39d50 f7d39d50 d9914000 f7e03978 c1bb4610 ce02a680 00000000 00000000 
       00000010 c0156dab f7fee8c0 00000010 00000000 cfe7c270 00000001 00000001 
       00000002 00000029 00000001 c022361d ce02a680 cfe7c270 c01566c3 00000001 
Call Trace:
 [<c0156dab>] bio_alloc+0xcb/0x1a0
 [<c022361d>] submit_bio+0x3d/0x70
 [<c01566c3>] ll_rw_block+0x63/0x90
 [<c01990d7>] journal_commit_transaction+0x1057/0x12c0
 [<c0117a60>] recalc_task_prio+0x90/0x1a0
 [<c019b6aa>] kjournald+0xca/0x260
 [<c011a2c0>] autoremove_wake_function+0x0/0x50
 [<c011a2c0>] autoremove_wake_function+0x0/0x50
 [<c010907e>] ret_from_fork+0x6/0x14
 [<c019b5c0>] commit_timeout+0x0/0x10
 [<c019b5e0>] kjournald+0x0/0x260
 [<c0106fc9>] kernel_thread_helper+0x5/0xc
Code: 8b 50 38 8b 40 34 0f ac d0 09 85 c0 89 c3 0f 84 8b 00 00 00 


>>EIP; c0223467 <generic_make_request+17/190>   <=====

>>eax; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>ecx; f7bf1900 <__crc_tcp_write_xmit+1fb419/8b5736>
>>edx; ce02a680 <__crc_pci_register_driver+16dad2/6ef6a1>
>>edi; ce02a680 <__crc_pci_register_driver+16dad2/6ef6a1>
>>esp; f7d39d50 <__crc_tcp_write_xmit+343869/8b5736>

Trace; c0156dab <bio_alloc+cb/1a0>
Trace; c022361d <submit_bio+3d/70>
Trace; c01566c3 <ll_rw_block+63/90>
Trace; c01990d7 <journal_commit_transaction+1057/12c0>
Trace; c0117a60 <recalc_task_prio+90/1a0>
Trace; c019b6aa <kjournald+ca/260>
Trace; c011a2c0 <autoremove_wake_function+0/50>
Trace; c011a2c0 <autoremove_wake_function+0/50>
Trace; c010907e <ret_from_fork+6/14>
Trace; c019b5c0 <commit_timeout+0/10>
Trace; c019b5e0 <kjournald+0/260>
Trace; c0106fc9 <kernel_thread_helper+5/c>

Code;  c0223467 <generic_make_request+17/190>
00000000 <_EIP>:
Code;  c0223467 <generic_make_request+17/190>   <=====
   0:   8b 50 38                  mov    0x38(%eax),%edx   <=====
Code;  c022346a <generic_make_request+1a/190>
   3:   8b 40 34                  mov    0x34(%eax),%eax
Code;  c022346d <generic_make_request+1d/190>
   6:   0f ac d0 09               shrd   $0x9,%edx,%eax
Code;  c0223471 <generic_make_request+21/190>
   a:   85 c0                     test   %eax,%eax
Code;  c0223473 <generic_make_request+23/190>
   c:   89 c3                     mov    %eax,%ebx
Code;  c0223475 <generic_make_request+25/190>
   e:   0f 84 8b 00 00 00         je     9f <_EIP+0x9f>


1 warning and 1 error issued.  Results may not be reliable.

Sorry about the warnings in the oops-trace, but it seems ksymoops is not 
updated for 2.6, unless I missed something.

6. My backup script (probably not that relevant :)
#!/bin/bash
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.3/site-packages/
backup_dir=/home/backup
exclude_file=exclude_list
rdiff-backup --exclude-globbing-filelist $exclude_file --exclude $backup_dir / 
$backup_dir

/ is /dev/hda1
/home is /dev/hda2

7. My system: slackware 9.1
7.1 Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.14
e2fsprogs              1.34
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         snd_pcm_oss snd_mixer_oss snd_via82xx snd_pcm snd_timer 
snd_ac97_codec snd_page_alloc snd_mpu401_uart snd_rawmidi snd soundcore lp 
nvidia parport_pc parport uhci_hcd usb_storage hid usbcore sd_mod via_rhine 
agpgart

7.2 cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) XP 2600+
stepping        : 1
cpu MHz         : 2083.203
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4104.19

7.3 cat /proc/modules
snd_pcm_oss 54084 0 - Live 0xf8963000
snd_mixer_oss 19968 1 snd_pcm_oss, Live 0xf8800000
snd_via82xx 25184 1 - Live 0xf88b4000
snd_pcm 101248 3 snd_pcm_oss,snd_via82xx, Live 0xf88d2000
snd_timer 26240 1 snd_pcm, Live 0xf8898000
snd_ac97_codec 63492 1 snd_via82xx, Live 0xf88a3000
snd_page_alloc 12164 2 snd_via82xx,snd_pcm, Live 0xf886e000
snd_mpu401_uart 7872 1 snd_via82xx, Live 0xf8834000
snd_rawmidi 24832 1 snd_mpu401_uart, Live 0xf8877000
snd 55300 9 
snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_pcm,snd_timer,snd_ac97_cod
ec,snd_mpu401_uart,snd_rawmidi, Live 0xf8880000
soundcore 9888 1 snd, Live 0xf8830000
lp 9956 0 - Live 0xf882c000
nvidia 2075176 12 - Live 0xf8ab4000
parport_pc 23112 1 - Live 0xf8867000
parport 28736 2 lp,parport_pc, Live 0xf885e000
uhci_hcd 32648 0 - Live 0xf8855000
usb_storage 29696 0 - Live 0xf881b000
hid 25280 0 - Live 0xf8824000
usbcore 105940 5 uhci_hcd,usb_storage,hid, Live 0xf883a000
sd_mod 14816 0 - Live 0xf8806000
via_rhine 21384 0 - Live 0xf8814000
agpgart 32456 0 - Live 0xf880b000

7.4 cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3fffbfff : System RAM
  00100000-002e0ca2 : Kernel code
  002e0ca3-003a20ff : Kernel data
3fffc000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
ec000000-ec0000ff : 0000:00:12.0
  ec000000-ec0000ff : via-rhine
ec800000-ec8000ff : 0000:00:10.3
ed000000-ed00007f : 0000:00:0f.0
ed800000-ed800fff : 0000:00:0d.0
ee000000-efdfffff : PCI Bus #01
  ee000000-eeffffff : 0000:01:00.0
eff00000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : 0000:01:00.0
f8000000-fbffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0278-027a : parport0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
a800-a8ff : 0000:00:12.0
  a800-a8ff : via-rhine
b000-b00f : 0000:00:11.1
  b000-b007 : ide0
  b008-b00f : ide1
b400-b41f : 0000:00:10.2
  b400-b41f : uhci_hcd
b800-b81f : 0000:00:10.1
  b800-b81f : uhci_hcd
d000-d01f : 0000:00:10.0
  d000-d01f : uhci_hcd
d400-d47f : 0000:00:0f.0
d800-d8ff : 0000:00:0d.0
e000-e0ff : 0000:00:11.5
  e000-e0ff : VIA8233

7.5 lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:0d.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
00:0f.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] 
(rev 04)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio 
Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 
AGP 8x] (rev a2)

lspci -vvv for the IDE controller:
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a1
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at b000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.7
The HD on which this happened:
hda: Maxtor 6Y080L0, ATA DISK drive
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)

EXT3-information from dmesg:
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
EXT3 FS on hda1, internal journal
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

regards,

-- 
Bart Janssens
