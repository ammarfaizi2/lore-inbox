Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130330AbRCBFfp>; Fri, 2 Mar 2001 00:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130333AbRCBFfg>; Fri, 2 Mar 2001 00:35:36 -0500
Received: from 204-210-5-119.san.rr.com ([204.210.5.119]:59400 "EHLO
	tigger.azure-n-jade.foo") by vger.kernel.org with ESMTP
	id <S130330AbRCBFfV>; Fri, 2 Mar 2001 00:35:21 -0500
Date: Thu, 1 Mar 2001 21:35:11 -0800 (PST)
From: Gregory Ade <gkade@bigbrother.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2 sound [ad1848] eating cpu?
Message-ID: <Pine.LNX.4.21.0103012114340.5860-100000@tigger.azure-n-jade.foo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This may be a bit off topic, and if it is, please point me in the right
direction.

I have a Dell Inspiron 3500 (Cel 333a/196mb w/ the NeoMagic256AV chipset),
which I've had running 2.2.14 & 2.2.16 for some time, with flawless
performance.

I recently upgraded to 2.4.2 (and made sure to go through the Changes.txt
file to catch all the utilities, so they're all up to date), and used the
same configureation optiosn for sound support as I had before in 2.2
(basically building the necessary drivers as modules again).  However,
with 2.4.2, whenever I try to play any sound file, be it a .wav or .mp3, I
now have what sounds like static intermittently in the playback,
coinciding with large cpu usage (up to 100%).  These static "bursts" are
of varying length, but become worse if there is any other activity on the
system.  Sometimes the whole machine will freeze as the sound system is
outputting static, and then seems to pulse: a little pop from the
speakers, and an instant of system responsiveness followed by a few
more seconds of freeze.

I'm running vanilla 2.4.2 sources + the 2000-02-15 snapshot of
FreeS/WAN.  This problem was present before I patched FreeS/WAN in, and I
can switch back to a kernel without ipsec if needed for testing.

some (what I hope is) relevant information:

root@gopher(pts/2):/ 139 # lsmod
Module                  Size  Used by
mpu401                 18704   0  (unused)
ad1848                 16736   0
sound                  55920   0  [mpu401 ad1848]
soundcore               3920   4  [sound]
serial_cs               5744   0  (unused)
usb-uhci               21744   0  (unused)
3c575_cb               20352   2
cb_enabler              2864   2  [3c575_cb]
ds                      6960   2  [serial_cs cb_enabler]
i82365                 24208   2
pcmcia_core            44960   0  [serial_cs cb_enabler ds i82365]
serial                 42576   0  (autoclean) [serial_cs]
usbcore                46576   1  (autoclean) [usb-uhci]
root@gopher(pts/2):/ 140 # cat /proc/dma
 0: MS Sound System
 1: MS Sound System
 4: cascade
root@gopher(pts/2):/ 141 # cat /proc/interrupts
           CPU0
  0:     314837          XT-PIC  timer
  1:        277          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:      76748          XT-PIC  eth0
  5:       2483          XT-PIC  MS Sound System
  8:          1          XT-PIC  rtc
 11:          0          XT-PIC  usb-uhci
 12:       2520          XT-PIC  PS/2 Mouse
 14:     224597          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0
ERR:          2
root@gopher(pts/2):/ 142 # cat /proc/ioports
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
0280-02ff : cb_enabler
0376-0376 : ide1
03c0-03df : vga+
03e8-03ef : serial(set)
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0530-0533 : WSS config
0534-0537 : MS Sound System
0cf8-0cff : PCI conf1
2180-219f : Intel Corporation 82371AB PIIX4 ACPI
8000-803f : Intel Corporation 82371AB PIIX4 ACPI
fcd0-fcdf : Intel Corporation 82371AB PIIX4 IDE
fce0-fcff : Intel Corporation 82371AB PIIX4 USB
  fce0-fcff : usb-uhci
root@gopher(pts/2):/ 143 # 



I'm really at a loss as to what might be wrong... all the hardware
settings look to be the same as when I was running 2.2.

In case anyone's wondering why I'm running the NeoMagic256AV chipset in
Ad-Lib emulation, it's because it worked =), and because several other
websites of people who run this same type of laptop said they were able
to get sound working.  I've tried the 2.2.x NM256 drivers, and they
only ended up locking the machine quite hard, so I haven't wanted
to try them in 2.4.2 yet.

Again, if anyone knows where would be a better place for me to look for
help, please tell me.

Thanks.

- -- 
Gregory K. Ade
<gkade@bigbrother.net> | <gkade@san.rr.com>
http://bigbrother.net/~gkade
GPG ID/FP: EAF4844B | F4FCCC7D613DBDBF5365 E3D079050460EAF4844B

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6nzEUeQUEYOr0hEsRAhj3AJ9y7JQIeAS4dgGN5t0V+oJHa6XtqQCg0UYa
fuHXrwQWJLULGWtoxXAoqqY=
=yQW/
-----END PGP SIGNATURE-----


