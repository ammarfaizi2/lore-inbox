Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSLPUvz>; Mon, 16 Dec 2002 15:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSLPUvy>; Mon, 16 Dec 2002 15:51:54 -0500
Received: from office-NAT.rockwellfirstpoint.com ([199.191.58.7]:11983 "EHLO
	ecsmtp01.rockwellfirstpoint.com") by vger.kernel.org with ESMTP
	id <S261346AbSLPUvw>; Mon, 16 Dec 2002 15:51:52 -0500
Subject: i810 sound starts and stops for 2.4.XX and i845PE chipset
To: linux-kernel@vger.kernel.org
Cc: edward.kuns@rockwellfirstpoint.com
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OFEC2D1079.106A6C04-ON86256C91.00739206-86256C91.0073544D@rockwellfirstpoint.com>
From: edward.kuns@rockwellfirstpoint.com
Date: Mon, 16 Dec 2002 15:03:16 -0600
X-MIMETrack: Serialize by Router on ECSMTP01/EC/Rockwell(Release 5.0.11  |July 24, 2002) at
 12/16/2002 03:00:05 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me at edward.kuns at rockwellfirstpoint.com in your responses.

I have a Gigabyte GA-8PE667 Ultra motherboard (aka P4 Titan 667 Ultra) with
the i845PE chipset.  According to the motherboard manual, it uses the
Realtek ALC650 CODEC.

With Red Hat 8.0's default kernel (2.4.18-14) and with the most recent
update kernel (2.4.18-18.8.0) -- both the i686 version -- sound works but
will stop and start at random, long intervals.  This occurs no matter what
the source of the sound.  (xine, chromium, whatever)  Of course, those two
kernel versions use the same i810 source file (version 0.22).

I've tried to boot 2.4.20-ac2 but it doesn't even boot (due to the Promise
controller and other issues I'll bring up in a separate EMail) so I naively
copied the i810_audio.c file from that kernel tree to the Red Hat
2.4.18-18.8.0 tree and recompiled.  There is no difference in behavior.  I
threw a SoundBlaster Live! card in there and with that card, sound output
works perfectly.  (I first disabled the i810 sound in the BIOS ... I
haven't tried the two together.)

Below are the dmesg output for 2.4.18-14 default (first) and for
2.4.18-18.8.0 with i810_audio.c from 2.4.20-ac2:

Red Hat 8.0 kernel 2.4.18-14

Dec 14 22:51:31 kilroy kernel: Intel 810 + AC97 Audio, version 0.22,
13:45:06 Sep  4 2002
Dec 14 22:51:31 kilroy kernel: PCI: Found IRQ 11 for device 00:1f.5
Dec 14 22:51:31 kilroy kernel: PCI: Sharing IRQ 11 with 00:1f.3
Dec 14 22:51:31 kilroy kernel: PCI: Setting latency timer of device 00:1f.5
to 64
Dec 14 22:51:31 kilroy kernel: i810: Intel ICH4 found at IO 0xd800 and
0xd400, IRQ 11
Dec 14 22:51:31 kilroy kernel: i810_audio: Audio Controller supports 6
channels.
Dec 14 22:51:31 kilroy kernel: i810_audio: Defaulting to base 2 channel
mode.
Dec 14 22:51:31 kilroy kernel: ac97_codec: AC97 Audio codec, id:
0x414c:0x4720 (ALC650)
Dec 14 22:51:31 kilroy kernel: i810_audio: AC'97 codec 0, new EID value =
0x05c7
Dec 14 22:51:31 kilroy kernel: i810_audio: AC'97 codec 0, DAC map
configured, total channels = 6
Dec 14 22:51:31 kilroy modprobe: modprobe: Can't locate module
sound-service-0-3

Red Hat 8.0 kernel 2.4.18-18.8.0 but with i810_audio.c from 2.4.20-ac2

Dec 14 23:43:06 kilroy kernel: Intel 810 + AC97 Audio, version 0.24,
23:22:57 Dec 14 2002
Dec 14 23:43:06 kilroy kernel: PCI: Found IRQ 11 for device 00:1f.5
Dec 14 23:43:06 kilroy kernel: PCI: Sharing IRQ 11 with 00:1f.3
Dec 14 23:43:06 kilroy kernel: PCI: Setting latency timer of device 00:1f.5
to 64
Dec 14 23:43:06 kilroy kernel: i810: Intel ICH4 found at IO 0xd800 and
0xd400, MEM 0xec002000 and 0xec003000, IRQ 11
Dec 14 23:43:06 kilroy kernel: i810: Intel ICH4 mmio at 0xe1c85000 and
0xe1c87000
Dec 14 23:43:07 kilroy kernel: i810_audio: Primary codec has ID 0
Dec 14 23:43:07 kilroy kernel: i810_audio: Audio Controller supports 6
channels.
Dec 14 23:43:07 kilroy kernel: i810_audio: Defaulting to base 2 channel
mode.
Dec 14 23:43:07 kilroy kernel: i810_audio: Resetting connection 0
Dec 14 23:43:07 kilroy kernel: i810_audio: Connection 0 with codec id 0
Dec 14 23:43:07 kilroy kernel: ac97_codec: AC97 Audio codec, id:
0x414c:0x4720 (ALC650)
Dec 14 23:43:07 kilroy kernel: i810_audio: AC'97 codec 0, new EID value =
0x05c7
Dec 14 23:43:07 kilroy kernel: i810_audio: AC'97 codec 0, DAC map
configured, total channels = 6

Output of "lspci" with no options (from after I threw the SoundBlaster
Live! on):

00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host
Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge
(rev 02)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev
02)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX440]
(rev a3)
02:00.0 SCSI storage controller: Adaptec AIC-7892B U160/m (rev 02)
02:02.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev
01)
02:03.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
04)
02:03.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev
01)
02:07.0 USB Controller: NEC Corporation USB (rev 41)
02:07.1 USB Controller: NEC Corporation USB (rev 41)
02:07.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (CNR) Ethernet
Controller (rev 82)
02:0c.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01)

Output of "lspci -vv" pasting in only the piece from the Intel audio
controller:

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev
02)
      Subsystem: Giga-byte Technology: Unknown device a002
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
      Latency: 0
      Interrupt: pin B routed to IRQ 11
      Region 0: I/O ports at d400 [size=256]
      Region 1: I/O ports at d800 [size=64]
      Region 2: Memory at ec002000 (32-bit, non-prefetchable) [size=512]
      Region 3: Memory at ec003000 (32-bit, non-prefetchable) [size=256]
      Capabilities: [50] Power Management version 2
            Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
            Status: D0 PME-Enable- DSel=0 DScale=0 PME-

I see the dmesg messages shown above whenever something starts using sound,
but when the sound stops and later restarts, there are no messages to dmesg
nor to /var/log/message.  The sound just quits, and some time later (two
minutes, five minutes, ten minutes.....) comes back.  Again, this happens
regardless of the sound source.

I do not have these problems on another board with the i845G chipset, so I
am assuming the i845PE has changed something.  (?)  Or perhaps something
else is different between an Intel board with i845G and a Gigabyte board
with i845PE.

I haven't yet tried any of the 2.5.XX series, nor have I tried other
versions of 2.4.xx beyond what i mentioned above.

Any suggestions?  Ideas?  Patches?  (grin)  Let me know if there is
anything I can do to help research this.  I'm not afraid of patches or
mucking around in kernel code -- part of my living involves working with
kernel code and drivers on a simpler and older OS -- but I'm not at all
familiar with PCI or the details of modern chipset programming.

      Thanks

      Eddie

P.S.  We are required to use Notes here.  I hope that this message will not
be sent HTML formatted.....

--
Edward Kuns
Technical Staff Member
Rockwell FirstPoint Contact
edward.kuns@rockwellfirstpoint.com
www.rockwellfirstpoint.com


