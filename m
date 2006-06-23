Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752038AbWFWUeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbWFWUeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbWFWUeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:34:50 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:33352 "EHLO
	damned.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S1752038AbWFWUes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:34:48 -0400
From: Hamish <hamish@travellingkiwi.com>
Organization: TravellingKiwi Systems
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SATA hangs...
Date: Fri, 23 Jun 2006 21:34:39 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2322210.kVxlPlBBvZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606232134.42231.hamish@travellingkiwi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2322210.kVxlPlBBvZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Hi.

I'm having problems with a SATA drive on an ASUS A8V deluxe=20
motherboard under kernel 2.6.17... In fact it's happened under=20
every (Vanilla) kernel I've ever run on this server (Back to 2.6.14).
(It's just over a year old. It didn't used to experience the same load
as it does now, so I'm currently assuming it's load related...

The box is a 3GB memory, Barton core AMD64 3200+, with a 30GB IDE (IDE0),=20
160GB IDE (IDE1) and a 200GB SATA drive.

After anywhere between a few minutes (Rare) and several hundred hours=20
of uptime, access to filesystems on the SATA drive stop in mid flow=20
(Almost always under light  to heavy load. e.g. watching mythtv from
a saved .mpg on a reiserfs filesystem on an LVM2 volume).

I've tried the SATA drive on two different SATA ports as well. ata0 & ata1.


dmesg shows the following output

ata1: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=3D0x51 { DriveReady SeekComplete Error }
ata1: error=3D0x84 { DriveStatusError BadCRC }
ata1: command 0x25 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=3D0xd0 { Busy }
sd 0:0:0:0: SCSI error: return code =3D 0x8000002
sda: Current: sense key=3D0xb
    ASC=3D0x47 ASCQ=3D0x0
end_request: I/O error, dev sda, sector 33714288
ATA: abnormal status 0xD0 on port 0xC007
ATA: abnormal status 0xD0 on port 0xC007
ATA: abnormal status 0xD0 on port 0xC007
ata1: command 0x25 timeout, stat 0xd0 host_stat 0x1
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=3D0xd0 { Busy }
sd 0:0:0:0: SCSI error: return code =3D 0x8000002
sda: Current: sense key=3D0xb
    ASC=3D0x47 ASCQ=3D0x0
end_request: I/O error, dev sda, sector 33714296
ATA: abnormal status 0xD0 on port 0xC007
ATA: abnormal status 0xD0 on port 0xC007
ATA: abnormal status 0xD0 on port 0xC007


cat'ing /dev/interrupts shows that the IRQ for libata isn't incrementing...

hamish@damned ~/OpenGraphics/primitives $ cat /proc/interrupts=20
           CPU0      =20
  0:  171174947    IO-APIC-edge  timer
  1:      76936    IO-APIC-edge  i8042
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:    1980221    IO-APIC-edge  ide0
 15:        308    IO-APIC-edge  ide1
177:    2190154   IO-APIC-level  libata
185:    2341219   IO-APIC-level  VIA8237
193:   83550145   IO-APIC-level  sk98lin, cx88[0], cx88[0]
201:    1416971   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb=
3, uhci_hcd:usb4, uhci_hcd:usb5
NMI:     150122=20
LOC:  171177364=20
ERR:          0
MIS:          0
hamish@damned ~/OpenGraphics/primitives $=20

libata, & sata_via are compiled as modules

i2c_viapro              8152  0=20
sata_via                6916  7=20
libata                 51032  1 sata_via


I can't find anything on google... There's no suspend/resume involved. It d=
oesn't appear to be over heating, CPU is at 38degC currently, it was stable=
 as a rock during the heatwave last week at about 50degC, so plenty of leew=
ay there. 1st temp sensor is at 33 degC (According to sensors).

Scaling governor is set to ondemand...=20

When it fails, sdparm also hangs, but when it's running, sdparm doesn't ind=
icate any logged errors, so it doesn't seem like it's the drive failing...

Othe rinfo follows...

hamish@damned ~ $ cat /proc/iomem=20
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-bffaffff : System RAM
  00100000-003d0983 : Kernel code
  003d0984-00511e17 : Kernel data
bffb0000-bffbffff : ACPI Tables
bffc0000-bffeffff : ACPI Non-volatile Storage
bfff0000-bfffffff : reserved
c8000000-cfffffff : 0000:00:00.0
  c8000000-cfffffff : aperture
d0000000-f7ffffff : PCI Bus #01
  d0000000-dfffffff : 0000:01:00.0
    d0000000-dfffffff : radeonfb framebuffer
  e0000000-efffffff : 0000:01:00.1
f8000000-f8ffffff : 0000:00:0c.0
  f8000000-f8ffffff : cx88[0]
f9000000-f9ffffff : 0000:00:0c.2
  f9000000-f9ffffff : cx88[0]
fa000000-faffffff : 0000:00:0c.4
fb900000-fb91ffff : 0000:00:0a.0
fba00000-fba03fff : 0000:00:0a.0
  fba00000-fba03fff : sk98lin
fbc00000-fbc000ff : 0000:00:10.4
  fbc00000-fbc000ff : ehci_hcd
fbd00000-fbffffff : PCI Bus #01
  fbd00000-fbd1ffff : 0000:01:00.0
  fbe00000-fbe0ffff : 0000:01:00.0
    fbe00000-fbe0ffff : radeonfb mmio
  fbf00000-fbf0ffff : 0000:01:00.1
ff780000-ffffffff : reserved
hamish@damned ~ $=20
hamish@damned ~ $ cat /proc/modules
usblp 11904 0 - Live 0xffffffff882a9000
radeon 112288 0 - Live 0xffffffff8828c000
drm 83240 1 radeon, Live 0xffffffff88276000
snd_pcm_oss 46240 0 - Live 0xffffffff88269000
snd_mixer_oss 14912 1 snd_pcm_oss, Live 0xffffffff88264000
snd_seq_oss 29760 0 - Live 0xffffffff8825b000
snd_seq_midi_event 6848 1 snd_seq_oss, Live 0xffffffff88258000
snd_seq 48544 4 snd_seq_oss,snd_seq_midi_event, Live 0xffffffff8824b000
rfcomm 32360 1 - Live 0xffffffff88242000
l2cap 21512 5 rfcomm, Live 0xffffffff8823b000
hci_usb 14740 0 - Live 0xffffffff88236000
bluetooth 42276 5 rfcomm,l2cap,hci_usb, Live 0xffffffff8822a000
af_key 28244 0 - Live 0xffffffff88222000
xfrm4_tunnel 3336 0 - Live 0xffffffff880de000
ipcomp 6284 0 - Live 0xffffffff8821f000
esp4 6528 0 - Live 0xffffffff8821c000
ah4 5056 0 - Live 0xffffffff88219000
sha512 5248 0 - Live 0xffffffff88216000
sha256 8704 0 - Live 0xffffffff88212000
sha1 2560 0 - Live 0xffffffff8807a000
deflate 3136 0 - Live 0xffffffff88016000
zlib_deflate 19672 1 deflate, Live 0xffffffff8820c000
zlib_inflate 14400 1 deflate, Live 0xffffffff88207000
blowfish 8768 0 - Live 0xffffffff88203000
twofish 38848 0 - Live 0xffffffff881f8000
w83627hf 26128 0 - Live 0xffffffff881f0000
hwmon_vid 2432 1 w83627hf, Live 0xffffffff88011000
i2c_isa 4352 1 w83627hf, Live 0xffffffff881ed000
i2c_dev 9224 0 - Live 0xffffffff881e9000
thermal 20240 0 - Live 0xffffffff881e3000
cpufreq_ondemand 5932 0 - Live 0xffffffff881e0000
powernow_k8 8848 0 - Live 0xffffffff881dc000
processor 34908 2 thermal,powernow_k8, Live 0xffffffff881d2000
ohci1394 29320 0 - Live 0xffffffff881c9000
ieee1394 341688 1 ohci1394, Live 0xffffffff88174000
ohci_hcd 18692 0 - Live 0xffffffff8816e000
dm_mod 46576 7 - Live 0xffffffff88161000
usbhid 32800 0 - Live 0xffffffff88157000
usbmouse 4800 0 - Live 0xffffffff88154000
cx88_blackbird 17008 0 - Live 0xffffffff8814e000
cx8800 28556 1 cx88_blackbird, Live 0xffffffff88146000
cx88_dvb 11012 0 - Live 0xffffffff88142000
compat_ioctl32 7872 1 cx8800, Live 0xffffffff8813f000
cx8802 9924 2 cx88_blackbird,cx88_dvb, Live 0xffffffff8813b000
cx88xx 60452 4 cx88_blackbird,cx8800,cx88_dvb,cx8802, Live 0xffffffff8812b0=
00
v4l1_compat 10820 1 cx8800, Live 0xffffffff88127000
v4l2_common 8320 3 cx88_blackbird,cx8800,compat_ioctl32, Live 0xffffffff881=
23000
uhci_hcd 29024 0 - Live 0xffffffff88118000
ir_common 8772 1 cx88xx, Live 0xffffffff88114000
ehci_hcd 26696 0 - Live 0xffffffff8810a000
btcx_risc 4232 3 cx8800,cx8802,cx88xx, Live 0xffffffff88107000
tveeprom 15056 1 cx88xx, Live 0xffffffff88102000
usbcore 116968 8 usblp,hci_usb,ohci_hcd,usbhid,usbmouse,uhci_hcd,ehci_hcd, =
Live 0xffffffff880e4000
videodev 9280 3 cx88_blackbird,cx8800,cx88xx, Live 0xffffffff880e0000
sk98lin 142432 0 - Live 0xffffffff880ba000
cx88_vp3054_i2c 4480 1 cx88_dvb, Live 0xffffffff880b7000
mt352 6212 1 cx88_dvb, Live 0xffffffff880b4000
or51132 9028 1 cx88_dvb, Live 0xffffffff880b0000
video_buf_dvb 5124 1 cx88_dvb, Live 0xffffffff880ad000
dvb_core 75676 1 video_buf_dvb, Live 0xffffffff88099000
video_buf 18308 6 cx88_blackbird,cx8800,cx88_dvb,cx8802,cx88xx,video_buf_dv=
b, Live 0xffffffff88093000
nxt200x 12868 1 cx88_dvb, Live 0xffffffff8808e000
firmware_class 8960 3 cx88_blackbird,or51132,nxt200x, Live 0xffffffff8808a0=
00
cx24123 8452 1 cx88_dvb, Live 0xffffffff88086000
lgdt330x 7708 1 cx88_dvb, Live 0xffffffff88083000
cx22702 6084 1 cx88_dvb, Live 0xffffffff88080000
dvb_pll 10372 4 cx88_dvb,or51132,nxt200x,cx22702, Live 0xffffffff8807c000
snd_via82xx 24360 1 - Live 0xffffffff88073000
gameport 12432 1 snd_via82xx, Live 0xffffffff8806e000
snd_ac97_codec 97816 1 snd_via82xx, Live 0xffffffff88055000
snd_ac97_bus 2432 1 snd_ac97_codec, Live 0xffffffff88053000
snd_pcm 81484 3 snd_pcm_oss,snd_via82xx,snd_ac97_codec, Live 0xffffffff8803=
e000
snd_timer 20744 2 snd_seq,snd_pcm, Live 0xffffffff88037000
snd_page_alloc 8592 2 snd_via82xx,snd_pcm, Live 0xffffffff88033000
snd_mpu401_uart 6592 1 snd_via82xx, Live 0xffffffff88030000
snd_rawmidi 21856 1 snd_mpu401_uart, Live 0xffffffff88029000
snd_seq_device 6476 2 snd_seq_oss,snd_rawmidi, Live 0xffffffff88026000
snd 49512 13 snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_via82xx,snd_=
ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Li=
ve 0xffffffff88018000
i2c_viapro 8152 0 - Live 0xffffffff88013000
sata_via 6916 8 - Live 0xffffffff8800e000
libata 51032 1 sata_via, Live 0xffffffff88000000
hamish@damned ~ $=20
hamish@damned ~ $ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 31
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 0
cpu MHz         : 2000.000
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm 3dno=
wext 3dnow lahf_lm
bogomips        : 4014.69
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

hamish@damned ~ $=20
hamish@damned ~ $ cat /proc/ioports=20
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 : pnp 00:07
  0295-0296 : w83627hf
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-0407 : vt596_smbus
0680-06ff : pnp 00:07
0800-0803 : PM1a_EVT_BLK
0804-0805 : PM1a_CNT_BLK
0808-080b : PM_TMR
0810-0815 : ACPI CPU throttle
0820-0823 : GPE0_BLK
0cf8-0cff : PCI conf1
a000-a0ff : 0000:00:0a.0
  a000-a0ff : sk98lin
a400-a4ff : 0000:00:0f.0
  a400-a4ff : sata_via
a800-a80f : 0000:00:0f.0
  a800-a80f : sata_via
b000-b003 : 0000:00:0f.0
  b000-b003 : sata_via
b400-b407 : 0000:00:0f.0
  b400-b407 : sata_via
b800-b803 : 0000:00:0f.0
  b800-b803 : sata_via
c000-c007 : 0000:00:0f.0
  c000-c007 : sata_via
c400-c41f : 0000:00:10.0
  c400-c41f : uhci_hcd
c800-c81f : 0000:00:10.1
  c800-c81f : uhci_hcd
d000-d01f : 0000:00:10.2
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:10.3
  d400-d41f : uhci_hcd
d800-d8ff : 0000:00:11.5
  d800-d8ff : VIA8237
e000-efff : PCI Bus #01
  e000-e0ff : 0000:01:00.0
fc00-fc0f : 0000:00:0f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1
hamish@damned ~ $=20
damned ~ # lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
        Subsystem: ASUSTeK Computer Inc. A8V Deluxe
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at c8000000 (32-bit, prefetchable) [size=3D128M]
        Capabilities: [80] AGP version 3.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D2 SBA+ ITACoh- GART64-=
 HTrans- 64bit- FW+ AGP3+ Rate=3Dx8
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- =
=46W- Rate=3D<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
=2D,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [60] HyperTransport: Slave or Primary Interface
                !!! Possibly incomplete decoding
                Command: BaseUnitID=3D0 UnitCnt=3D3 MastHost- DefDir-
                Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <C=
RCErr=3D0
                Link Config 0: MLWI=3D16bit MLWO=3D16bit LWI=3D16bit LWO=3D=
16bit
                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <C=
RCErr=3D0
                Link Config 1: MLWI=3D8bit MLWO=3D8bit LWI=3D8bit LWO=3D8bit
                Revision ID: 1.02
        Capabilities: [58] HyperTransport: Interrupt Discovery and Configur=
ation

00:00.1 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.2 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.3 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.4 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.7 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890=
 South] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fbd00000-fbffffff
        Prefetchable memory behind bridge: d0000000-f7ffffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
=2D,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit =
Ethernet Controller (rev 13)
        Subsystem: ASUSTeK Computer Inc. Marvell 88E8001 Gigabit Ethernet C=
ontroller (Asus)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5750ns min, 7750ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 193
        Region 0: Memory at fba00000 (32-bit, non-prefetchable) [size=3D16K]
        Region 1: I/O ports at a000 [size=3D256]
        Expansion ROM at fb900000 [disabled] [size=3D128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [50] Vital Product Data

00:0c.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video and A=
udio Decoder (rev 05)
        Subsystem: Hauppauge computer works Inc. Hauppauge Nova-T DVB-T
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5000ns min, 13750ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 193
        Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=3D16M]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
=2D,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0c.2 Multimedia controller: Conexant CX23880/1/2/3 PCI Video and Audio D=
ecoder [MPEG Port] (rev 05)
        Subsystem: Hauppauge computer works Inc. Nova-T DVB-T Model 909
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1500ns min, 22000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 193
        Region 0: Memory at f9000000 (32-bit, non-prefetchable) [size=3D16M]
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
=2D,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0c.4 Multimedia controller: Conexant CX23880/1/2/3 PCI Video and Audio D=
ecoder [IR Port] (rev 05)
        Subsystem: Hauppauge computer works Inc. Nova-T DVB-T Model 909
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1500ns min, 63750ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=3D16M]
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
=2D,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Co=
ntroller (rev 80)
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V Deluxe/K8V-X/A8V Deluxe=
 motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin B routed to IRQ 177
        Region 0: I/O ports at c000 [size=3D8]
        Region 1: I/O ports at b800 [size=3D4]
        Region 2: I/O ports at b400 [size=3D8]
        Region 3: I/O ports at b000 [size=3D4]
        Region 4: I/O ports at a800 [size=3D16]
        Region 5: I/O ports at a400 [size=3D256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
=2D,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT82=
3x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 177
        Region 4: I/O ports at fc00 [size=3D16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
=2D,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contr=
oller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 08
        Interrupt: pin A routed to IRQ 201
        Region 4: I/O ports at c400 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,=
D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contr=
oller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 08
        Interrupt: pin A routed to IRQ 201
        Region 4: I/O ports at c800 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,=
D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME+

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contr=
oller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 08
        Interrupt: pin B routed to IRQ 201
        Region 4: I/O ports at d000 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,=
D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contr=
oller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 08
        Interrupt: pin B routed to IRQ 201
        Region 4: I/O ports at d400 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,=
D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20=
 [EHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size 10
        Interrupt: pin C routed to IRQ 201
        Region 0: Memory at fbc00000 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,=
D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/=
K8T890 South]
        Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
=2D,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8=
237 AC97 Audio Controller (rev 60)
        Subsystem: ASUSTeK Computer Inc. A8V Deluxe motherboard (Realtek AL=
C850 codec)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 185
        Region 0: I/O ports at d800 [size=3D256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2=
=2D,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Hyp=
erTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
                !!! Possibly incomplete decoding
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRC=
Err=3D0
                Link Config: MLWI=3D16bit MLWO=3D16bit LWI=3D16bit LWO=3D16=
bit
                Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Add=
ress Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRA=
M Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Mis=
cellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: ATI Technologies Inc M10 NQ [Radeon Mobi=
lity 9600] (prog-if 00 [VGA])
        Subsystem: PC Partner Limited Unknown device 0200
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size 08
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D256M]
        Region 1: I/O ports at e000 [size=3D256]
        Region 2: Memory at fbe00000 (32-bit, non-prefetchable) [size=3D64K]
        Expansion ROM at fbd00000 [disabled] [size=3D128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=3D256 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64=
=2D HTrans- 64bit- FW+ AGP3+ Rate=3Dx4,x8
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP- GART64- 64bit- =
=46W- Rate=3D<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2=
=2D,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.1 Display controller: ATI Technologies Inc M10 NQ [Radeon Mobility 96=
00] (secondary)
        Subsystem: PC Partner Limited Unknown device 0201
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size 08
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D256M]
        Region 1: Memory at fbf00000 (32-bit, non-prefetchable) [size=3D64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2=
=2D,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

damned ~ #=20
damned ~ # cat /proc/locks
1: FLOCK  ADVISORY  WRITE 8118 03:45:340910 0 EOF
2: FLOCK  ADVISORY  WRITE 8111 03:45:340853 0 EOF
3: FLOCK  ADVISORY  WRITE 8117 03:45:340868 0 EOF
4: FLOCK  ADVISORY  WRITE 8108 03:45:162077 0 EOF
5: FLOCK  ADVISORY  WRITE 7782 03:0a:145685 0 EOF
5: -> FLOCK  ADVISORY  WRITE 7702 03:0a:145685 0 EOF
5: -> FLOCK  ADVISORY  WRITE 7715 03:0a:145685 0 EOF
5: -> FLOCK  ADVISORY  WRITE 7738 03:0a:145685 0 EOF
6: FLOCK  ADVISORY  WRITE 8106 03:45:162076 0 EOF
7: FLOCK  ADVISORY  WRITE 8109 03:45:324581 0 EOF
8: POSIX  ADVISORY  WRITE 13928 03:0a:86694 0 EOF
9: POSIX  ADVISORY  WRITE 13928 03:0a:87070 0 EOF
10: POSIX  ADVISORY  WRITE 13928 03:0a:252476 0 EOF
11: POSIX  ADVISORY  READ  13928 03:42:757017 0 EOF
12: POSIX  ADVISORY  READ  13928 03:0a:81870 0 EOF
13: POSIX  ADVISORY  READ  13928 03:0a:81808 0 EOF
14: POSIX  ADVISORY  READ  13928 03:42:756690 0 EOF
15: POSIX  ADVISORY  WRITE 10007 03:08:8036 0 EOF
16: POSIX  ADVISORY  WRITE 10003 03:0a:251923 0 EOF
17: POSIX  ADVISORY  READ  10260 03:09:351943 4 4
18: FLOCK  ADVISORY  WRITE 10455 03:09:192047 0 EOF
19: POSIX  ADVISORY  READ  10260 03:09:351932 4 4
20: POSIX  ADVISORY  WRITE 10260 03:09:192039 0 0
21: POSIX  ADVISORY  READ  10251 03:09:351936 4 4
22: POSIX  ADVISORY  READ  10251 03:09:351935 4 4
23: POSIX  ADVISORY  READ  10251 03:09:351934 4 4
24: POSIX  ADVISORY  READ  10251 03:09:351933 4 4
25: POSIX  ADVISORY  READ  10251 03:09:351932 4 4
26: POSIX  ADVISORY  WRITE 10251 03:09:192037 0 0
27: FLOCK  ADVISORY  WRITE 10186 03:45:340846 0 EOF
28: FLOCK  ADVISORY  WRITE 9634 03:09:190230 0 EOF
29: FLOCK  ADVISORY  WRITE 9625 03:09:190227 0 EOF
30: POSIX  ADVISORY  WRITE 9563 03:09:190223 0 EOF
31: POSIX  ADVISORY  WRITE 9494 03:09:190219 0 EOF
32: POSIX  ADVISORY  WRITE 9416 03:09:190162 0 EOF
33: POSIX  ADVISORY  WRITE 8981 03:09:175418 0 EOF
damned ~ #=20
damned ~ # cat /proc/stat =20
cpu  6825000 4024889 702487 56539398 464061 2472 11227 0
cpu0 6825000 4024889 702487 56539398 464061 2472 11227 0
intr 263118976 171413132 80648 0 2 2 0 3 0 0 0 0 0 3 0 1982830 308 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 2190154 0 0 0 0 0 0 0 2341219 0 0 0 0 0 0 0 83666088 0 0 0 0 =
0 0 0 1444587 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0
ctxt 511432433
btime 1150408963
processes 1039583
procs_running 2
procs_blocked 4
damned ~ #=20

A process (ls) that's hung as the status of
damned 7577 # cat status
Name:   ls
State:  D (disk sleep)
SleepAVG:       88%
Tgid:   7577
Pid:    7577
PPid:   8912
TracerPid:      0
Uid:    1000    1000    1000    1000
Gid:    500     500     500     500
=46DSize: 256
Groups: 10 16 18 19 27 35 80 500 10011 10013=20
VmPeak:     9304 kB
VmSize:     9264 kB
VmLck:         0 kB
VmHWM:       840 kB
VmRSS:       840 kB
VmData:      324 kB
VmStk:        84 kB
VmExe:        84 kB
VmLib:      1544 kB
VmPTE:        32 kB
Threads:        1
SigQ:   1/24573
SigPnd: 0000000000000100
ShdPnd: 0000000000000002
SigBlk: 0000000000000000
SigIgn: 0000000000000000
SigCgt: 0000000180000000
CapInh: 00000000fffffeff
CapPrm: 0000000000000000
CapEff: 0000000000000000
damned 7577 #=20
damned 7577 # cat wchan=20
sync_bufferdamned 7577 #=20
damned 7577 #=20
damned 7577 #=20
damned 7577 # cat statm
2316 210 169 21 0 102 0
damned 7577 # cat stat
7577 (ls) D 8912 7577 8912 34817 7577 8388608 332 0 1 0 0 0 0 0 17 0 1 0 68=
435157 9486336 210 18446744073709551615 4194304 4276732 140737480895040 184=
46744073709551615 47836358300409 256 0 0 0 18446744071563539454 0 0 17 0 0 0
damned 7577 #=20



Any ideas?

TIA

Hamish.

--nextPart2322210.kVxlPlBBvZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEnFBiwRzSEdQQDooRAo4aAKClqEugDEGy2wHXSSmcJaBYwzjeVQCfa6je
S8wdh8nSXTFw5S8El89YkzA=
=eSnj
-----END PGP SIGNATURE-----

--nextPart2322210.kVxlPlBBvZ--
