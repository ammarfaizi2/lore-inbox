Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbTFLSGn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTFLSGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:06:37 -0400
Received: from mx03.stofanet.dk ([212.10.30.233]:11243 "EHLO mx03.stofanet.dk")
	by vger.kernel.org with ESMTP id S264932AbTFLSGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:06:02 -0400
Date: Thu, 12 Jun 2003 20:19:41 +0200
Reply-To: mok@imsb.au.dk
Subject: PROBLEM: fatal error with nForce2 system
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
From: Morten Kjeldgaard <mortenkjeldgaard@stofanet.dk>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6F57D57C-9D02-11D7-AF71-003065529A02@stofanet.dk>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel-people,

I built my computer on an ASUS A7N8X GD/Deluxe mother board. I have 
RedHat
Linux 9.0 installed, and I installed the nForce2 drivers
NVIDIA_kernel-1.0-4191.

The machine seems to be quite stable, but I have had a bunch of 
mysterious crashes
that I finally tracked to a script run every night that calls bzip2. I
have since experimented with bzip2, and I have found that I can
occasionally make the machine crash, but it is not really reproducible. 
I
noticed some dumps in the system log that I am attaching to this 
message.

Bzip2 is not the only application that can crash the machine, I have had
problems with the konqueror browser and CNS which is a number crunching
program for crystallography.

  I first reported the problem to nVidia, and they were very quick to 
repond. I was in contact with a very helpful engineer, and after some 
experimentation we concluded that the problem is probably not in their 
drivers, since the machine crashes under the same circumstances without 
the nvidia drivers loaded. However, I have only seen error messages in 
the syslog when the nvidia driver is loaded, but that is most likely a 
coincidence. Sometimes the machine freezes instantly, other times it 
goes down in a less spectacular manner...

I therefore report the problem to the kernel. I am including the 
relevant messages from the syslog, plus a number of the stuff mentioned 
in the reporting_bugs guide.

Cheers,
Morten

-- 
Morten Kjeldgaard <mok@imsb.au.dk>
Department of Molecular Biology, Aarhus University
Gustav Wieds Vej 10 C, DK-8000 Aarhus C, Denmark.
Lab +45 89425026 * Mobile +45 89428063 * Fax +45 86123178
Home +45 86188180 * ICQ 27224900 * http://imsb.au.dk/~mok

--------
snips from /var/log/messages

May 26 00:33:00 ghost automount[858]: attempting to mount entry /u/mok
May 26 00:35:39 ghost kernel: Page has mapping still set. This is a 
serious situation. However if you
May 26 00:35:39 ghost kernel: are using the NVidia binary only module 
please report this bug to
May 26 00:35:39 ghost kernel: NVidia and not to the linux kernel 
mailinglist.
May 26 00:35:39 ghost kernel: ------------[ cut here ]------------
May 26 00:35:39 ghost kernel: kernel BUG at page_alloc.c:122!
May 26 00:35:39 ghost kernel: invalid operand: 0000
May 26 00:35:39 ghost kernel: i810_audio ac97_codec soundcore nfs 
nvidia eeprom i2c-proc i2c-core binfmt_misc nfsd lockd sunrpc autofs 
3c59x ohci1394 ieee1394 st loop lvm-mod keybdev mouse
May 26 00:35:39 ghost kernel: CPU:    0
May 26 00:35:39 ghost kernel: EIP:    0060:[<c013b7c3>]    Tainted: P
May 26 00:35:39 ghost kernel: EFLAGS: 00010282
May 26 00:35:39 ghost kernel:
May 26 00:35:39 ghost kernel: EIP is at __free_pages_ok [kernel] 0x323 
(2.4.20-8)
May 26 00:35:39 ghost kernel: eax: 00000033   ebx: c10cdad8   ecx: 
f6fd2000   edx: f6fd3f7c
May 26 00:35:39 ghost kernel: esi: d3c25e28   edi: 00000000   ebp: 
00000000   esp: ce3c7eb4
May 26 00:35:39 ghost kernel: ds: 0068   es: 0068   ss: 0068
May 26 00:35:39 ghost kernel: Process bzip2 (pid: 28951, 
stackpage=ce3c7000)
May 26 00:35:39 ghost kernel: Stack: c0256940 00000002 c0303b84 
c15ef538 c0303900 c1038030 c0303b0c d3c25e28
May 26 00:35:39 ghost kernel:        c897dfcc 000c2000 c10cdad8 
c897dfcc 000c2000 03ac3067 c012c6c8 c10cdad8
May 26 00:35:39 ghost kernel:        000b5000 c012eab7 d48d1a40 
400b5000 c897dfcc c011694c 000000b6 40400000
May 26 00:35:39 ghost kernel: Call Trace:   [<c012c6c8>] __free_pte 
[kernel] 0x4c (0xce3c7eec))
May 26 00:35:39 ghost kernel: [<c012eab7>] zap_pte_range [kernel] 0x12f 
(0xce3c7ef8))
May 26 00:35:39 ghost kernel: [<c011694c>] do_page_fault [kernel] 0x178 
(0xce3c7f08))
May 26 00:35:39 ghost kernel: [<c012cd1b>] zap_page_range [kernel] 0xc7 
(0xce3c7f20))
May 26 00:35:39 ghost kernel: [<c012ffcf>] exit_mmap [kernel] 0xb3 
(0xce3c7f60))
May 26 00:35:39 ghost kernel: [<c01196bb>] mmput [kernel] 0x47 
(0xce3c7f84))
May 26 00:35:39 ghost kernel: [<c011e991>] do_exit [kernel] 0xf1 
(0xce3c7f94))
May 26 00:35:39 ghost kernel: [<c011ec08>] do_group_exit [kernel] 0x50 
(0xce3c7fb0))
May 26 00:35:39 ghost kernel: [<c01093b3>] system_call [kernel] 0x33 
(0xce3c7fc0))
May 26 00:35:39 ghost kernel:
May 26 00:35:39 ghost kernel:
May 26 00:35:40 ghost kernel: Code: 0f 0b 7a 00 9b 61 25 c0 e9 1b fd ff 
ff 0f 0b 69 00 9b 61 25
May 26 00:41:59 ghost automount[29609]: expired /u/mok



May 28 00:33:00 ghost automount[857]: attempting to mount entry /u/mok
May 28 00:35:30 ghost kernel: swap_dup: Bad swap file entry 0006fb04
May 28 00:35:30 ghost kernel: VM: killing process bzip2
May 28 00:35:30 ghost kernel: swap_free: Bad swap file entry 0006fb04
May 28 00:35:30 ghost kernel: ------------[ cut here ]------------
May 28 00:35:30 ghost kernel: kernel BUG at page_alloc.c:139!
May 28 00:35:30 ghost kernel: invalid operand: 0000
May 28 00:35:30 ghost kernel: i810_audio ac97_codec soundcore nfs 
nvidia eeprom i2c-proc i2c-core binfmt_misc nfsd lockd sunrpc autofs 
3c59x ohci1394 ieee1394 st loop lvm-mod keybdev mouse
May 28 00:35:30 ghost kernel: CPU:    0
May 28 00:35:30 ghost kernel: EIP:    0060:[<c013b57d>]    Tainted: P
May 28 00:35:30 ghost kernel: EFLAGS: 00010206
May 28 00:35:30 ghost kernel:
May 28 00:35:30 ghost kernel: EIP is at __free_pages_ok [kernel] 0xdd 
(2.4.20-8)
May 28 00:35:30 ghost kernel: eax: 01000050   ebx: c18846a8   ecx: 
c1000030   edx: 1857e044
May 28 00:35:30 ghost kernel: esi: 00000000   edi: 00000000   ebp: 
00000000   esp: eb695e0c
May 28 00:35:30 ghost kernel: ds: 0068   es: 0068   ss: 0068
May 28 00:35:30 ghost kernel: Process bzip2 (pid: 32142, 
stackpage=eb695000)
May 28 00:35:30 ghost kernel: Stack: c0303640 00000002 c0303b84 
0006fb04 c0303900 c1038030 c0303b0c d857e064
May 28 00:35:30 ghost kernel:        d857e064 0003e000 c18846a8 
d857e064 0003e000 26ef9067 c012c6c8 c18846a8
May 28 00:35:30 ghost kernel:        00019000 c012eab7 f6215640 
40419000 d857e064 00000006 00000019 40800000
May 28 00:35:30 ghost kernel: Call Trace:   [<c012c6c8>] __free_pte 
[kernel] 0x4c (0xeb695e44))
May 28 00:35:30 ghost kernel: [<c012eab7>] zap_pte_range [kernel] 0x12f 
(0xeb695e50))
May 28 00:35:30 ghost kernel: [<c012cd1b>] zap_page_range [kernel] 0xc7 
(0xeb695e78))
May 28 00:35:30 ghost kernel: [<c012ffcf>] exit_mmap [kernel] 0xb3 
(0xeb695eb8))
May 28 00:35:30 ghost kernel: [<c01196bb>] mmput [kernel] 0x47 
(0xeb695edc))
May 28 00:35:30 ghost kernel: [<c011e991>] do_exit [kernel] 0xf1 
(0xeb695eec))
May 28 00:35:30 ghost kernel: [<c0116cdd>] .text.lock.fault [kernel] 
0x0 (0xeb695f08))
May 28 00:35:30 ghost kernel: [<f8b30200>] nv_linux_devices [nvidia] 
0x0 (0xeb695f1c))
May 28 00:35:30 ghost kernel: [<f89cf71b>] __nvsym00654 [nvidia] 0x83 
(0xeb695f28))
May 28 00:35:30 ghost kernel: [<f89cf65d>] __nvsym00728 [nvidia] 0x31 
(0xeb695f3c))
May 28 00:35:30 ghost kernel: [<f89d02c0>] rm_isr [nvidia] 0x10 
(0xeb695f50))
May 28 00:35:30 ghost kernel: [<f89b8aab>] nv_kern_isr [nvidia] 0x25 
(0xeb695f60))
May 28 00:35:30 ghost kernel: [<c010a7e5>] handle_IRQ_event [kernel] 
0x4d (0xeb695f80))
May 28 00:35:30 ghost kernel: [<f8b30200>] nv_linux_devices [nvidia] 
0x0 (0xeb695f88))
May 28 00:35:30 ghost kernel: [<c010a992>] do_IRQ [kernel] 0x96 
(0xeb695fa0))
May 28 00:35:30 ghost kernel: [<c01167d4>] do_page_fault [kernel] 0x0 
(0xeb695fb0))
May 28 00:35:30 ghost kernel: [<c01094a4>] error_code [kernel] 0x34 
(0xeb695fb8))
May 28 00:35:30 ghost kernel:
May 28 00:35:30 ghost kernel:
May 28 00:35:30 ghost kernel: Code: 0f 0b 8b 00 9b 61 25 c0 8b 43 18 89 
f9 89 de 83 e0 eb 89 43
May 28 16:42:54 ghost syslogd 1.4.1: restart.
------------------------------
sh /usr/src/linux-2.4.20-8/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux ghost.imsb.au.dk 2.4.20-8 #1 Thu Mar 13 17:18:24 EST 2003 i686 
athlon i386 GNU/Linux

Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
reiserfsprogs          3.6.4
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         i810_audio ac97_codec soundcore nfs nvidia 
eeprom i2c-proc i2c-core binfmt_misc nfsd lockd sunrpc autofs 3c59x 
ohci1394 ieee1394 st loop lvm-mod keybdev mousedev hid input ehci-hcd 
usb-ohci usbcore ext3 jbd aic7xxx sd_mod scsi_mod
------------------------------
cat /proc/version
Linux version 2.4.20-8 (bhcompile@stripples.devel.redhat.com) (gcc 
version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Thu Mar 13 17:18:24 
EST 2003
------------------------------
cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2600+
stepping        : 1
cpu MHz         : 2079.551
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
----------
cat /proc/ioports
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
   c000-c0ff : Adaptec AIC-7892A U160/m
d000-dfff : PCI Bus #02
   d000-d07f : PCI device 10b7:9201 (3Com Corporation)
     d000-d07f : 02:01.0
e000-e07f : PCI device 10de:006a (nVidia Corporation)
   e000-e03f : NVIDIA nForce Audio
e400-e41f : PCI device 10de:0064 (nVidia Corporation)
e800-e8ff : PCI device 10de:006a (nVidia Corporation)
   e800-e8ff : NVIDIA nForce Audio
f000-f00f : PCI device 10de:0065 (nVidia Corporation)
   f000-f007 : ide0
   f008-f00f : ide1
-----------
cat /proc/ioports
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
   c000-c0ff : Adaptec AIC-7892A U160/m
d000-dfff : PCI Bus #02
   d000-d07f : PCI device 10b7:9201 (3Com Corporation)
     d000-d07f : 02:01.0
e000-e07f : PCI device 10de:006a (nVidia Corporation)
   e000-e03f : NVIDIA nForce Audio
e400-e41f : PCI device 10de:0064 (nVidia Corporation)
e800-e8ff : PCI device 10de:006a (nVidia Corporation)
   e800-e8ff : NVIDIA nForce Audio
f000-f00f : PCI device 10de:0065 (nVidia Corporation)
   f000-f007 : ide0
   f008-f00f : ide1
[mok@ghost mok]$ cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
   00100000-002481d3 : Kernel code
   002481d4-003412c3 : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
c0000000-c7ffffff : PCI device 10de:01e0 (nVidia Corporation)
c8000000-d7ffffff : PCI Bus #03
   c8000000-cfffffff : nVidia Corporation NV20 [GeForce3 Ti200]
   d0000000-d007ffff : nVidia Corporation NV20 [GeForce3 Ti200]
d8000000-dfffffff : PCI Bus #03
   d8000000-d8ffffff : nVidia Corporation NV20 [GeForce3 Ti200]
e0000000-e1ffffff : PCI Bus #01
   e1000000-e1000fff : Adaptec AIC-7892A U160/m
     e1000000-e1000fff : aic7xxx
e2000000-e3ffffff : PCI Bus #02
   e3000000-e300007f : PCI device 10b7:9201 (3Com Corporation)
e4000000-e407ffff : PCI device 10de:006b (nVidia Corporation)
e4080000-e4080fff : PCI device 10de:0067 (nVidia Corporation)
   e4080000-e4080fff : usb-ohci
e4081000-e40810ff : PCI device 10de:0068 (nVidia Corporation)
   e4081000-e40810ff : ehci-hcd
e4082000-e40827ff : PCI device 10de:006e (nVidia Corporation)
   e4082000-e40827ff : ohci1394
e4083000-e408303f : PCI device 10de:006e (nVidia Corporation)
e4084000-e4084fff : PCI device 10de:0067 (nVidia Corporation)
   e4084000-e4084fff : usb-ohci
e4085000-e4085fff : PCI device 10de:006a (nVidia Corporation)
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
--------------
sudo /sbin/lspci -vvv
00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev a2)
         Subsystem: Asustek Computer, Inc.: Unknown device 80ac
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
         Capabilities: [40] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                 Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x4
         Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev a2)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev a2)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev a2)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev a2)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev a2)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
         Subsystem: Asustek Computer, Inc. A7N8X Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
         Subsystem: Asustek Computer, Inc.: Unknown device 0c11
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 3
         Region 0: I/O ports at e400 [size=32]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a3) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc. A7N8X Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at e4084000 (32-bit, non-prefetchable) 
[size=4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a3) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc. A7N8X Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin B routed to IRQ 7
         Region 0: Memory at e4080000 (32-bit, non-prefetchable) 
[size=4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a3) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc. A7N8X Mainboard
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin C routed to IRQ 5
         Region 0: Memory at e4081000 (32-bit, non-prefetchable) 
[size=256]
         Capabilities: [44] #0a [2080]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: nVidia Corporation nForce 
MultiMedia audio [Via VT82C686B] (rev a2)
         Subsystem: Asustek Computer, Inc.: Unknown device 0c11
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (250ns min, 3000ns max)
         Interrupt: pin A routed to IRQ 7
         Region 0: Memory at e4000000 (32-bit, non-prefetchable) 
[size=512K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 
Audio Controler (MCP) (rev a1)
         Subsystem: Asustek Computer, Inc.: Unknown device 8095
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (500ns min, 1250ns max)
         Interrupt: pin A routed to IRQ 3
         Region 0: I/O ports at e800 [size=256]
         Region 1: I/O ports at e000 [size=128]
         Region 2: Memory at e4085000 (32-bit, non-prefetchable) 
[size=4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: e0000000-e1ffffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 
8a [Master SecP PriP])
         Subsystem: Asustek Computer, Inc.: Unknown device 0c11
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Region 4: I/O ports at f000 [size=16]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 PCI bridge: nVidia Corporation: Unknown device 006d (rev a3) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: e2000000-e3ffffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 
1394) Controller (rev a3) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 809a
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at e4082000 (32-bit, non-prefetchable) 
[size=2K]
         Region 1: Memory at e4083000 (32-bit, non-prefetchable) 
[size=64]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2) (prog-if 00 
[Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: d8000000-dfffffff
         Prefetchable memory behind bridge: c8000000-d7ffffff
         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:07.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
         Subsystem: Adaptec 29160N Ultra160 SCSI Controller
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (10000ns min, 6250ns max), cache line size 08
         Interrupt: pin A routed to IRQ 11
         BIST result: 00
         Region 0: I/O ports at c000 [disabled] [size=256]
         Region 1: Memory at e1000000 (64-bit, non-prefetchable) 
[size=4K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated 
Fast Ethernet Controller (rev 40)
         Subsystem: Asustek Computer, Inc.: Unknown device 80ab
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at d000 [size=128]
         Region 1: Memory at e3000000 (32-bit, non-prefetchable) 
[size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti 
200] (rev a3) (prog-if 00 [VGA])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at d8000000 (32-bit, non-prefetchable) 
[size=16M]
         Region 1: Memory at c8000000 (32-bit, prefetchable) [size=128M]
         Region 2: Memory at d0000000 (32-bit, prefetchable) [size=512K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2,x4
                 Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x4
-------------------------
cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
   Vendor: iomega   Model: jaz 1GB          Rev: J.83
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
   Vendor: Quantum  Model: DLT4000          Rev: CF5F
   Type:   Sequential-Access                ANSI SCSI revision: 02
-------------------

