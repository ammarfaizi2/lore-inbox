Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbUDSJ5L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 05:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbUDSJ5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 05:57:11 -0400
Received: from math.ut.ee ([193.40.5.125]:6282 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264331AbUDSJ45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 05:56:57 -0400
Date: Mon, 19 Apr 2004 11:49:36 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.5 oops on reboot from snd_mpu401_uart
Message-ID: <Pine.GSO.4.44.0404191134020.3644-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beginning with 2.6.5-rc1 I had an oops with panic on reboot on one
specific computer. Since I couldn't capture it, I ignored it for some
time but it's still present in yesterdays 2.6.6-rc1+BK snapshot. So I
took a snapshot of the oops with digital camera and it is available at
http://www.cs.ut.ee/~mroos/sound-oops.jpg for some time.

It only happens when I have used PCM sound after boot. Just booting the
machine up, logging into KDE (it restores mixer settings), playing TV
with tvtime (also uses mixer) and rebooting shows no problem. As soon as
I play one file with sound using mplayer, the reboot hangs with this
oops & panic.

I am using alsa drivers with snd_ens1371 (primary card, tested with
mplayer) and snd_via82xx (secondary card) drivers. snd_pcm_oss and
snd_mixer_oss are also loaded. snd_via82xx depends on snd_mpu401_uart so
this is also loaded. I don use midi uart, at least not knowingly.

/proc/asound/cards:
0 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                     Ensoniq AudioPCI ENS1371 at 0xe000, irq 11
1 [rev50          ]: VIA686A - VIA 82C686A/B rev50
                     VIA 82C686A/B rev50 at 0xcc00, irq 10
2 [Bt878          ]: Bt87x - Brooktree Bt878
                     Brooktree Bt878 at 0xd9003000, irq 11

/proc/asound/devices:
  0: [0- 0]: ctl
  8: [0- 0]: raw midi
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer
 33:       : timer
 32: [1- 0]: ctl
 40: [1- 0]: raw midi
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture
 64: [2- 0]: ctl
 89: [2- 1]: digital audio capture
 88: [2- 0]: digital audio capture

lsmod:
Module                  Size  Used by
nls_iso8859_1           4096  0
nls_cp437               5760  0
binfmt_misc            10056  1
snd_seq_midi_event      7680  0
snd_seq                50320  1 snd_seq_midi_event
md5                     4224  1
ipv6                  238560  18
ipt_MASQUERADE          3840  1
iptable_nat            23916  2 ipt_MASQUERADE
ipt_REJECT              6656  2
ipt_LOG                 6528  1
ipt_state               2048  17
ip_conntrack           34432  3 ipt_MASQUERADE,iptable_nat,ipt_state
iptable_filter          2880  1
ip_tables              17536  6 ipt_MASQUERADE,iptable_nat,ipt_REJECT,ipt_LOG,ipt_state,iptable_filter
cls_u32                 7748  4
sch_sfq                 5504  2
sch_cbq                17152  1
usb_storage            64320  0
btaudio                17040  0
es1371                 35328  0
via82cxxx_audio        28808  0
uart401                11652  1 via82cxxx_audio
sound                  80108  2 via82cxxx_audio,uart401
ac97_codec             17484  2 es1371,via82cxxx_audio
snd_bt87x              13380  0
uhci_hcd               30032  0
usbcore               102428  4 usb_storage,uhci_hcd
vfat                   14976  0
fat                    44480  1 vfat
md                     45896  0
dm_mod                 41696  0
parport_pc             38016  1
lp                     10244  0
parport                39368  2 parport_pc,lp
snd_pcm_oss            50852  0
snd_mixer_oss          18496  1 snd_pcm_oss
snd_via82xx            24128  0
snd_mpu401_uart         7488  1 snd_via82xx
snd_ens1371            22116  0
snd_rawmidi            24032  2 snd_mpu401_uart,snd_ens1371
snd_seq_device          8072  2 snd_seq,snd_rawmidi
snd_pcm                93092  4 snd_bt87x,snd_pcm_oss,snd_via82xx,snd_ens1371
snd_page_alloc         11012  3 snd_bt87x,snd_via82xx,snd_pcm
snd_timer              24388  2 snd_seq,snd_pcm
snd_ac97_codec         59268  2 snd_via82xx,snd_ens1371
snd                    52452  13 snd_seq_midi_event,snd_seq,snd_bt87x,snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_mpu401_uart,snd_ens1371,snd_rawmidi,snd_seq_device,snd_pcm,snd_timer,snd_ac97_codec
sd_mod                 21120  0
scsi_mod              119628  2 usb_storage,sd_mod
mga                   101744  30
ide_cd                 40964  1
cdrom                  37920  1 ide_cd
floppy                 58452  0
tuner                  17804  0
tvaudio                21580  0
msp3400                22932  0
bttv                  147500  0
video_buf              20420  1 bttv
v4l2_common             6208  1 bttv
btcx_risc               4808  1 bttv
videodev                9536  1 bttv
soundcore               9696  6 btaudio,es1371,via82cxxx_audio,sound,snd,bttv
8139too                23936  0
mii                     4928  1 8139too


lspci output:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
        Flags: bus master, medium devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable)
        Capabilities: <available only to root>

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d6000000-d8ffffff
        Prefetchable memory behind bridge: d4000000-d5ffffff
        Capabilities: <available only to root>

0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: <available only to root>

0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at c000 [size=16]
        Capabilities: <available only to root>

0000:00:07.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at c400 [size=32]
        Capabilities: <available only to root>

0000:00:07.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at c800 [size=32]
        Capabilities: <available only to root>

0000:00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Flags: medium devsel, IRQ 11
        Capabilities: <available only to root>

0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 3300
        Flags: medium devsel, IRQ 10
        I/O ports at cc00
        I/O ports at d000 [size=4]
        I/O ports at d400 [size=4]
        Capabilities: <available only to root>

0000:00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d800
        Memory at d9000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at dc00
        Memory at d9001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

0000:00:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Flags: bus master, slow devsel, latency 32, IRQ 11
        I/O ports at e000
        Capabilities: <available only to root>

0000:00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at d9002000 (32-bit, prefetchable)

0000:00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at d9003000 (32-bit, prefetchable)

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 05) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at d4000000 (32-bit, prefetchable)
        Memory at d6000000 (32-bit, non-prefetchable) [size=16K]
        Memory at d7000000 (32-bit, non-prefetchable) [size=8M]
        Capabilities: <available only to root>

interrupts:
           CPU0
  0:   49645510          XT-PIC  timer
  1:       3117          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:    7374022          XT-PIC  rtc
  9:    4213172          XT-PIC  uhci_hcd, uhci_hcd, mga@PCI:1:0:0
 10:     753060          XT-PIC  VIA686A, eth1
 11:     525873          XT-PIC  acpi, bttv0, Ensoniq AudioPCI, Bt87x audio, eth0
 12:     800358          XT-PIC  i8042
 14:     185088          XT-PIC  ide0
 15:     445660          XT-PIC  ide1
NMI:          0
LOC:   49641573
ERR:     120317
MIS:          0


-- 
Meelis Roos (mroos@linux.ee)

