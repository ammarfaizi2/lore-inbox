Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264724AbUEKNlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264724AbUEKNlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 09:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbUEKNlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 09:41:47 -0400
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:19430 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264724AbUEKNlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 09:41:12 -0400
Date: Tue, 11 May 2004 23:41:01 +1000
From: Andrew Lau <netsnipe@users.sourceforge.net>
To: simon@thekelleys.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Atmel at76c50x PCMCIA 2.6.6 kernel panic
Message-ID: <20040511134101.GA19530@espresso>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Simon and co.,

My Atmel AT76C502AR_D 802.11b PCMCIA card was previously working fine
under the 2.6.5 kernel via the atmel/atmel_cs modules. However, since
upgrading to 2.6.6 I now get a kernel panic whenever I insert my card
and hotplug (2004-03-29) attempts to upload the 0.7-1 version of Simon's
firmware <http://thekelleys.org.uk/atmel/>. I've provided as much
debugging information as I can below, so feel free to let me know if
I've missed out on anything.

Thanks in advanced,
Andrew "Netsnipe" Lau

PS: Please CC: me as I'm not on LKML.

--=20
---------------------------------------------------------------------------
	Andrew "Netsnipe" Lau	<http://www.cse.unsw.edu.au/~alau/>
 Debian GNU/Linux Maintainer & UNSW Computing Students' Society President
				     -
		  "Nobody expects the Debian Inquisition!
     Our two weapons are fear and surprise...and ruthless efficiency!"
---------------------------------------------------------------------------

=3D=3D=3D=3D=3D=3D=3D=3D=3D
The Panic
=3D=3D=3D=3D=3D=3D=3D=3D=3D

cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
                                                                           =
                                                 =20
=2E..<insert card>...
                                                                           =
                                                 =20
cs: pcmcia_socket0: voltage interrogation timed out.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth1: MAC address 00:06:f4:00:e9:05
eth1: Atmel at76c50x wireless. Version 0.96 simon@thekelleys.org.uk
eth1: NoName-revD index 0x01: Vcc 3.3, irq 3, io 0x0100-0x011f
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c017ceda
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c017ceda>]    Not tainted
EFLAGS: 00010246   (2.6.6)
EIP is at object_path_length+0x1a/0x31
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: d1cfb184
esi: 00000001   edi: 00000000   ebp: ffffffff   esp: c3da5d88
ds: 007b   es: 007b   ss: 0068
Process ifplugd (pid: 2443, threadinfo=3Dc3da4000 task=3Dc3e0ebb0)
Stack: 00000003 00000000 d1cfb184 d1cf75c0 c017cf6a d1cfb184 d1cf75d4 d1cf7=
5c0
       c01a672f c02e7a9b c3e45c10 d1cf7620 cdc19390 d1cf7620 d1cf75c0 c020b=
792
       cdc19398 d1cfb184 c02ee812 c020ba59 cdc19390 cdc193d8 d1cf760c 00000=
000
Call Trace:
 [<c017cf6a>] sysfs_create_link+0x2a/0x13b
 [<c01a672f>] kobject_hotplug+0x55/0x57
 [<c020b792>] class_device_dev_link+0x30/0x34
 [<c020ba59>] class_device_add+0xd9/0x110
 [<d1cf55bc>] fw_register_class_device+0x10f/0x163 [firmware_class]
 [<d1cf563c>] fw_setup_class_device+0x2c/0x111 [firmware_class]
 [<d1cf5788>] request_firmware+0x67/0x160 [firmware_class]
 [<d1d09917>] reset_atmel_card+0x65b/0x6b4 [atmel]
 [<d1d059f6>] atmel_open+0xbf/0x1a5 [atmel]
 [<c01a8ddf>] vsnprintf+0x245/0x4ba
 [<c0285b7c>] dev_open+0xcc/0xfb
 [<c028a2ba>] dev_mc_upload+0x25/0x43
 [<c0286ec6>] dev_change_flags+0x51/0x120
 [<c0285a0f>] dev_load+0x26/0x72
 [<c027e9e0>] sock_ioctl+0x0/0x2a4
 [<c02bedcd>] devinet_ioctl+0x235/0x560
 [<c027e9e0>] sock_ioctl+0x0/0x2a4
 [<c02c11df>] inet_ioctl+0x5e/0x9e
 [<c027ead5>] sock_ioctl+0xf5/0x2a4
 [<c027e9e0>] sock_ioctl+0x0/0x2a4
 [<c015b8b6>] sys_ioctl+0xf7/0x24d
 [<c0103f2b>] syscall_call+0x7/0xb
                                                                           =
                                                 =20
Code: f2 ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 ea 5b 89 f0 5e

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
% sh scripts/ver_linux
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Linux snoopy.caffeine 2.6.5 #1 Tue May 4 18:57:24 EST 2004 i686 GNU/Linux
                                                                           =
                                                 =20
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.35
pcmcia-cs              3.2.5
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         atmel_cs atmel firmware_class smapi ipt_ttl ipt_limi=
t ipt_state iptable_mangle ipt_LOG ipt_MASQUERADE ipt_TOS ipt_REDIRECT ipta=
ble_nat ipt_REJECT ip_conntrack_irc ip_conntrack_ftp ip_conntrack iptable_f=
ilter ip_tables snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_m=
ixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_s=
eq_device snd thinkpadpm thinkpad apm

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
% cat /proc/cpuinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Celeron(R) CPU 1.60GHz
stepping        : 7
cpu MHz         : 1594.938
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 3145.72

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
% cat /proc/modules
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

atmel_cs 9604 1 - Live 0xd1cf8000
atmel 36868 1 atmel_cs, Live 0xd1d04000
firmware_class 10240 1 atmel, Live 0xd1cf4000
smapi 4484 0 - Live 0xd0964000
ipt_ttl 2048 1 - Live 0xd094e000
ipt_limit 2560 34 - Live 0xd0945000
ipt_state 2048 8 - Live 0xd0950000
iptable_mangle 2944 0 - Live 0xd094a000
ipt_LOG 5760 1 - Live 0xd0947000
ipt_MASQUERADE 4096 0 - Live 0xd087f000
ipt_TOS 2560 0 - Live 0xd08fe000
ipt_REDIRECT 2304 0 - Live 0xd08fc000
iptable_nat 22828 2 ipt_MASQUERADE,ipt_REDIRECT, Live 0xd093c000
ipt_REJECT 7040 1 - Live 0xd0930000
ip_conntrack_irc 71476 0 - Live 0xd091d000
ip_conntrack_ftp 72244 0 - Live 0xd090a000
ip_conntrack 33072 6 ipt_state,ipt_MASQUERADE,ipt_REDIRECT,iptable_nat,ip_c=
onntrack_irc,ip_conntrack_ftp, Live 0xd0900000
iptable_filter 2944 1 - Live 0xd087d000
ip_tables 18432 11 ipt_ttl,ipt_limit,ipt_state,iptable_mangle,ipt_LOG,ipt_M=
ASQUERADE,ipt_TOS,ipt_REDIRECT,iptable_nat,ipt_REJECT,iptable_filter, Live =
0xd08b6000
snd_intel8x0m 19140 0 - Live 0xd08b0000
snd_intel8x0 33156 1 - Live 0xd08a6000
snd_ac97_codec 63236 2 snd_intel8x0m,snd_intel8x0, Live 0xd08e4000
snd_pcm_oss 52900 0 - Live 0xd08d6000
snd_mixer_oss 19712 2 snd_pcm_oss, Live 0xd08a0000
snd_pcm 95652 3 snd_intel8x0m,snd_intel8x0,snd_pcm_oss, Live 0xd08bd000
snd_timer 25604 1 snd_pcm, Live 0xd0898000
snd_page_alloc 11268 3 snd_intel8x0m,snd_intel8x0,snd_pcm, Live 0xd085e000
snd_mpu401_uart 7936 1 snd_intel8x0, Live 0xd0873000
snd_rawmidi 24736 1 snd_mpu401_uart, Live 0xd0890000
snd_seq_device 8200 1 snd_rawmidi, Live 0xd086f000
snd 53988 10 snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixe=
r_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0x=
d0881000
thinkpadpm 5128 0 - Live 0xd086c000
thinkpad 6148 2 smapi,thinkpadpm, Live 0xd0862000
apm 18028 2 - Live 0xd0866000

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
% cat /proc/ioports
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-011f : atmel_cs
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03bc-03be : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
1180-11bf : 0000:00:1f.0
1800-181f : 0000:00:1d.0
  1800-181f : uhci_hcd
1820-183f : 0000:00:1d.1
  1820-183f : uhci_hcd
1840-185f : 0000:00:1d.2
  1840-185f : uhci_hcd
1860-186f : 0000:00:1f.1
  1860-1867 : ide0
  1868-186f : ide1
1880-189f : 0000:00:1f.3
18c0-18ff : 0000:00:1f.5
1c00-1cff : 0000:00:1f.5
2000-207f : 0000:00:1f.6
  2000-207f : Intel 82801DB-ICH4 Modem - Controller
2400-24ff : 0000:00:1f.6
  2400-24ff : Intel 82801DB-ICH4 Modem - AC'97
3000-3fff : PCI Bus #01
  3000-30ff : 0000:01:00.0
4000-40ff : PCI CardBus #03
4400-44ff : PCI CardBus #03
8000-803f : 0000:02:08.0
  8000-803f : e100

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
% cat /proc/iomem
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cf000-000cffff : Extension ROM
000d0000-000d0fff : Extension ROM
000d1000-000d1fff : Extension ROM
000d2000-000d3fff : reserved
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ff5ffff : System RAM
  00100000-002d5d9c : Kernel code
  002d5d9d-003a4d7f : Kernel data
0ff60000-0ff77fff : ACPI Tables
0ff78000-0ff79fff : ACPI Non-volatile Storage
0ff80000-0fffffff : reserved
10000000-100003ff : 0000:00:1f.1
10400000-107fffff : PCI CardBus #03
10800000-10bfffff : PCI CardBus #03
50000000-50000fff : 0000:02:00.0
  50000000-50000fff : yenta_socket
a0000000-a0000fff : card services
d0000000-d00003ff : 0000:00:1d.7
  d0000000-d00003ff : ehci_hcd
d0000800-d00008ff : 0000:00:1f.5
  d0000800-d00008ff : Intel 82801DB-ICH4 - Controller
d0000c00-d0000dff : 0000:00:1f.5
  d0000c00-d0000dff : Intel 82801DB-ICH4 - AC'97
d0100000-d01fffff : PCI Bus #01
  d0100000-d010ffff : 0000:01:00.0
d0200000-d0200fff : 0000:02:08.0
  d0200000-d0200fff : e100
e0000000-e3ffffff : 0000:00:00.0
e8000000-efffffff : PCI Bus #01
  e8000000-efffffff : 0000:01:00.0
ff800000-ffffffff : reserved

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
% lspci -vvv
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Br=
idge (rev 04)
        Subsystem: IBM: Unknown device 0507
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Capabilities: <available only to root>
=20
0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Brid=
ge (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
        Latency: 96
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d0100000-d01fffff
        Prefetchable memory behind bridge: e8000000-efffffff
        Expansion ROM at 00003000 [disabled] [size=3D4K]
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
=20
0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 03=
) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at 1800 [size=3D32]
=20
0000:00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 03=
) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1820 [size=3D32]
=20
0000:00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 03=
) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 1840 [size=3D32]
=20
0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controlle=
r (rev 03) (prog-if 20 [EHCI])
        Subsystem: IBM: Unknown device 052e
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at d0000000 (32-bit, non-prefetchable)
        Capabilities: <available only to root>
=20
0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog=
-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=3D00, secondary=3D02, subordinate=3D05, sec-latency=3D=
64
        I/O behind bridge: 00004000-00008fff
        Memory behind bridge: d0200000-dfffffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
=20
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev=
 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
=20
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage C=
ontroller (rev 03) (prog-if 8a [Master SecP PriP])        Subsystem: IBM: U=
nknown device 052d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 1860 [size=3D16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=3D1K]
=20
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 03)
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1880 [size=3D32]
=20
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 =
Audio Controller (rev 03)
        Subsystem: IBM: Unknown device 0523
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 1c00
        Region 1: I/O ports at 18c0 [size=3D64]
        Region 2: Memory at d0000c00 (32-bit, non-prefetchable) [size=3D512]
        Region 3: Memory at d0000800 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: <available only to root>
=20
0000:00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev =
03) (prog-if 00 [Generic])
        Subsystem: IBM: Unknown device 0524
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 2400
        Region 1: I/O ports at 2000 [size=3D128]
        Capabilities: <available only to root>
=20
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobilit=
y M6 LY (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 0526
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping+ SERR+ FastB2B+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, prefetchable)
        Region 1: I/O ports at 3000 [size=3D256]
        Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=3D64K]
        Capabilities: <available only to root>
=20
0000:02:00.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus Cont=
roller
        Subsystem: IBM: Unknown device 0528
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x20 (128 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 50000000 (32-bit, non-prefetchable)
        Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D=
176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrit=
e+
        16-bit legacy interface ports at 0001
=20
0000:02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (MOB) Ethe=
rnet Controller (rev 83)
        Subsystem: IBM: Unknown device 0522
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 by=
tes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0200000 (32-bit, non-prefetchable)
        Region 1: I/O ports at 8000 [size=3D64]
        Capabilities: <available only to root>

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQFAoNftmyTAfS6LaL0RAvfVAJjehuhOUViR7Wn7WIpNIAmod57jAJ9DvK0L
hdaT9thHUsU1hpv6+bycTg==
=hop+
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
