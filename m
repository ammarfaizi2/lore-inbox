Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbWEOTK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbWEOTK5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWEOTK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:10:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:13147 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965180AbWEOTKz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:10:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PpuUQvujvHQpKGn3h7X68zYaJFqtGIvTAYHah1ednM6FP71T4zkybK588UAVn3nIptAxTCgsB4NlrDdT0OeWBdxX4RQJooQ3M4F5uIKIfvWt3x3iComLTl20kGkIaXid1XdaBi+6aC265Hk28IEoH+5jH7rNC4nHDoBaoX2ty0M=
Message-ID: <9a8748490605151210v35c2c54dg1afd2c221d39016d@mail.gmail.com>
Date: Mon, 15 May 2006 21:10:54 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "Andrew Morton" <akpm@osdl.org>
Subject: New scsi messages in dmesg with 2.6.17-rc4-mm1 including a slightly worrying "Unexpected busfree while idle"
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been running 2.6.17-rc4-mm1 for a little while, just to test it out a bit.

Haven't been doing anything special, just what I'd be calling normal
desktop use (well, maybe starting a few more apps than usual at the
same time, but nothing special).

After about an hour or so I thought "hmm, better check dmesg to see it
this new kernel has said anything interresting" and indeed it had.
I found these messages in the dmesg output in addition to what I'd
normaly expect :

(scsi0:A:5:0): No or incomplete CDB sent to device.
scsi0: Issued Channel A Bus Reset. 1 SCBs aborted
(scsi0:A:5:0): Unexpected busfree while idle
SEQADDR == 0x16c
(scsi0:A:4:0): No or incomplete CDB sent to device.
scsi0: Issued Channel A Bus Reset. 1 SCBs aborted

I don't recall ever having seen these before with previous kernels, so
I'm wondering what exactely could be causing them...?

I've been trying for the past 20 minutes to run through the same apps
as I had running the previous hour, but I've not been able to provoke
more messages :(  So I'm pretty clueless as to the cause. Hopefully
someone can clarify.

A few random details about my system below - not quite sure what would
be relevant, so please just ask for specific details if you need them.

$ cat /etc/slackware-version
Slackware 10.2.0

$ uname -a
Linux dragon 2.6.17-rc4-mm1 #1 SMP PREEMPT Mon May 15 20:13:09 CEST
2006 i686 athlon-4 i386 GNU/Linux

$ scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dragon 2.6.17-rc4-mm1 #1 SMP PREEMPT Mon May 15 20:13:09 CEST
2006 i686 athlon-4 i386 GNU/Linux

Gnu C                  3.4.6
Gnu make               3.81
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
reiserfsprogs          3.6.19
quota-tools            3.12.
PPP                    2.4.4b1
nfs-utils              1.0.7
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   071
Modules Loaded         snd_seq_midi snd_emu10k1_synth snd_emux_synth
snd_seq_virmidi snd_seq_midi_emul snd_seq_oss snd_seq_midi_event
snd_seq snd_pcm_oss snd_mixer_oss uhci_hcd usbcore snd_emu10k1
snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device
snd_timer snd_page_alloc snd_util_mem snd_hwdep snd agpgart

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-305  Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DDYS-T36950N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03

# lspci -v
00:00.0 Host bridge: ALi Corporation M1695 K8 Northbridge [PCI Express
and HyperTransport]
        Flags: bus master, fast devsel, latency 0
        Capabilities: [40] #08 [0060]
        Capabilities: [5c] #08 [a800]
        Capabilities: [68] #08 [9000]
        Capabilities: [74] #08 [8000]
        Capabilities: [7c] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-

00:01.0 PCI bridge: ALi Corporation: Unknown device 524b (prog-if 00
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: ff200000-ff2fffff
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
        Capabilities: [58] #10 [0141]
        Capabilities: [7c] #08 [a800]
        Capabilities: [88] #08 [8825]

00:02.0 PCI bridge: ALi Corporation: Unknown device 524c (prog-if 00
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Memory behind bridge: ff300000-ff3fffff
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
        Capabilities: [58] #10 [0141]
        Capabilities: [7c] #08 [a800]
        Capabilities: [88] #08 [8825]

00:04.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8 Single Chip]
        Flags: bus master, fast devsel, latency 0
        Memory at dc000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [40] #08 [0024]
        Capabilities: [60] #08 [801c]
        Capabilities: [80] AGP version 3.0

00:05.0 PCI bridge: ALi Corporation AGP8X Controller (prog-if 00
[Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        Memory behind bridge: ff400000-ff4fffff
        Prefetchable memory behind bridge: c7f00000-d7efffff

00:06.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge (prog-if
01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ff500000-ff5fffff
        Prefetchable memory behind bridge: 88000000-880fffff

00:07.0 ISA bridge: ALi Corporation M1563 HyperTransport South Bridge (rev 70)
        Subsystem: ASRock Incorporation: Unknown device 1563
        Flags: bus master, medium devsel, latency 0

00:07.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
        Subsystem: ASRock Incorporation: Unknown device 7101
        Flags: medium devsel

00:11.0 Ethernet controller: ALi Corporation M5263 Ethernet Controller (rev 40)
        Subsystem: ASRock Incorporation: Unknown device 5263
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at e800 [size=256]
        Memory at ff6ffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:12.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if 8a
[Master SecP PriP])
        Subsystem: ASRock Incorporation: Unknown device 5229
        Flags: bus master, 66Mhz, medium devsel, latency 32
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at ff00 [size=16]

00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation: Unknown device 5237
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
        Memory at ff6fe000 (32-bit, non-prefetchable) [size=4K]

00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation: Unknown device 5237
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 3
        Memory at ff6fd000 (32-bit, non-prefetchable) [size=4K]

00:13.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation: Unknown device 5237
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
        Memory at ff6fc000 (32-bit, non-prefetchable) [size=4K]

00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
(prog-if 20 [EHCI])
        Subsystem: ASRock Incorporation: Unknown device 5239
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 5
        Memory at ff6ff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2090]

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: [80] #08 [2101]

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
        Flags: fast devsel

03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA Parhelia
AGP (rev 03) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Parhelia 128Mb
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 5
        Memory at c8000000 (32-bit, prefetchable) [size=128M]
        Memory at ff4fe000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at ff4c0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0

04:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
        Subsystem: Creative Labs SBLive! 5.1 eMicro 28028
        Flags: bus master, medium devsel, latency 32, IRQ 20
        I/O ports at d880 [size=32]
        Capabilities: [dc] Power Management version 1

04:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at dc00 [size=8]
        Capabilities: [dc] Power Management version 1

04:06.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160N Ultra160 SCSI Controller
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
        BIST result: 00
        I/O ports at d400 [disabled] [size=256]
        Memory at ff5ff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 88000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

04:07.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 42)
        Subsystem: D-Link System Inc DFE-530TX rev B
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at d000 [size=256]
        Memory at ff5fec00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 88020000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2



-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
