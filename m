Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTIFUx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 16:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTIFUx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 16:53:28 -0400
Received: from wooledge.org ([209.142.155.49]:17835 "HELO pegasus.wooledge.org")
	by vger.kernel.org with SMTP id S261917AbTIFUxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 16:53:22 -0400
Date: Sat, 6 Sep 2003 16:53:21 -0400
From: Greg Wooledge <greg@wooledge.org>
To: linux-kernel@vger.kernel.org
Subject: moving a window makes the system 'hang' until button is released
Message-ID: <20030906205320.GA21490@pegasus.wooledge.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: OpenBSD 3.3
X-www.distributed.net: 82 packets (5519.22 stats units) [5.04 Mnodes/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[1.] One line summary of the problem:   =20
Dragging a window in X makes the system "hang" until button is released.

[2.] Full description of the problem/report:
"Hang" means xmms's sound output stops, and if I'm running something
like "while :; do echo hi; sleep 1; done" in a different window, that
also stops writing "hi" until I release the mouse button.  (Then I
get a whole bunch of them all at once.)  This seems to rule out ALSA
being the cause, which was originally my first thought.

I've tried with and without CONFIG_PREEMPT enabled.  I've tried changing
X to be un-niced.  I've tried applying the patch-test4-O20int patch from
Con Kolivas.  That last patch seems to have increased the time it takes
for the problem to kick in (it's on the order of 5 seconds now instead
of 3 seconds), but it didn't fix it.

However: if I make the problem occur once, then wait just a few
seconds, then do it again, it happens much more quickly (sound stops
within one second).  The longer I wait before dragging a window around,
the longer it will take for the problem to occur.

The window manager is fvwm.  It's XFree86 4.2.1.1 on a Debian unstable
system.  I'm not using "opaque" window dragging -- just the outlines
of the windows.  The problem is not related to CPU overworking, because
I've got dnetc and Freenet running in the background, and they don't
cause any glitches like this.  The problem also occurs if I am *not*
running them.

The problem occurs with both moving and resizing a window.

I did *not* observe this problem under Linux 2.4.21.

[3.] Keywords (i.e., modules, networking, kernel):
scheduling

[4.] Kernel version (from /proc/version):
Linux version 2.6.0-test4 (root@griffon) (gcc version 3.3.1 (Debian)) #2 Sa=
t Sep 6 16:14:35 EDT 2003

[5.] Output of Oops.. message (if applicable) with symbolic information=20
     resolved (see Documentation/oops-tracing.txt)
N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)
N/A

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.35-WIP
nfs-utils              1.0.3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.11
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         ipv6 snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmi=
di snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_=
mem snd_hwdep snd soundcore 8250 core ide_scsi scsi_mod 3c59x

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2000+
stepping        : 0
cpu MHz         : 1667.703
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3284.99

[7.3.] Module information (from /proc/modules):
ipv6 237280 8 - Live 0xe0b14000
snd_pcm_oss 52004 0 - Live 0xe0ac2000
snd_mixer_oss 18880 1 snd_pcm_oss, Live 0xe0aac000
snd_emu10k1 68036 3 - Live 0xe09f9000
snd_rawmidi 24160 1 snd_emu10k1, Live 0xe09f2000
snd_pcm 93476 3 snd_pcm_oss,snd_emu10k1, Live 0xe0a0e000
snd_timer 24324 1 snd_pcm, Live 0xe09dc000
snd_seq_device 8136 2 snd_emu10k1,snd_rawmidi, Live 0xe09be000
snd_ac97_codec 51652 1 snd_emu10k1, Live 0xe09e4000
snd_page_alloc 11716 2 snd_emu10k1,snd_pcm, Live 0xe08f1000
snd_util_mem 4416 1 snd_emu10k1, Live 0xe08f9000
snd_hwdep 8800 1 snd_emu10k1, Live 0xe09b6000
snd 47588 15 snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_pcm,snd_=
timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep, Live 0xe09c6000
soundcore 8576 1 snd, Live 0xe08f5000
8250 19120 0 - Live 0xe09b0000
core 22272 1 8250, Live 0xe09a9000
ide_scsi 15616 0 - Live 0xe08c9000
scsi_mod 108008 1 ide_scsi, Live 0xe08fc000
3c59x 33192 0 - Live 0xe08d0000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
d000-d01f : 0000:00:0a.0
  d000-d01f : EMU10K1
d400-d407 : 0000:00:0a.1
d800-d87f : 0000:00:0b.0
  d800-d87f : 0000:00:0b.0
dc00-dc1f : 0000:00:10.0
  dc00-dc1f : uhci-hcd
e000-e01f : 0000:00:10.1
  e000-e01f : uhci-hcd
e400-e41f : 0000:00:10.2
  e400-e41f : uhci-hcd
e800-e80f : 0000:00:11.1
  e800-e807 : ide0
  e808-e80f : ide1
ec00-ecff : 0000:00:12.0

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d0000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002d42d6 : Kernel code
  002d42d7-003680ff : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
c0000000-cfffffff : 0000:00:00.0
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
  d8000000-dfffffff : 0000:01:00.1
e0000000-e00fffff : PCI Bus #01
  e0020000-e002ffff : 0000:01:00.0
  e0030000-e003ffff : 0000:01:00.1
e0120000-e012007f : 0000:00:0b.0
e0121000-e01210ff : 0000:00:10.3
  e0121000-e01210ff : ehci_hcd
e0122000-e01220ff : 0000:00:12.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
(That seems to be excessively large.  Here's lspci instead.  If
someone wants, I can provide more info.)
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev=
 0a)
00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev=
 78)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Ma=
ster IDE (rev 06)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev =
74)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If [Rad=
eon 9000] (rev 01)
01:00.1 Display controller: ATI Technologies Inc Radeon R250 [Radeon 9000] =
(Secondary) (rev 01)

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W4824A Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02

(ide-scsi of course.)

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
CONFIG_AGP=3Dy
CONFIG_AGP_VIA=3Dy
CONFIG_DRM=3Dy
CONFIG_DRM_RADEON=3Dy

[X.] Other notes, patches, fixes, workarounds:
X is using the "ati" driver.
(--) RADEON(0): Chipset: "ATI Radeon 9000 If (AGP)" (ChipID =3D 0x4966)
(--) RADEON(0): Linear framebuffer at 0xd0000000
(--) RADEON(0): MMIO registers at 0xe0020000
(--) RADEON(0): VideoRAM: 131072 kByte (64-bit DDR SDRAM)

--=20
Greg Wooledge                  |   "Truth belongs to everybody."
greg@wooledge.org              |    - The Red Hot Chili Peppers
http://wooledge.org/~greg/     |

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (OpenBSD)

iD8DBQE/WklAkAkqAYpL9t8RAs/sAJ4m4a/2PwvfR9lWrBBvCSU3THPbSQCeN8l0
DeFL16NK8S+V4f6pme7p6cY=
=T9Sm
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
