Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRBSRJ0>; Mon, 19 Feb 2001 12:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129311AbRBSRJQ>; Mon, 19 Feb 2001 12:09:16 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:8972 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S129282AbRBSRJG>; Mon, 19 Feb 2001 12:09:06 -0500
Date: Mon, 19 Feb 2001 12:08:25 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: Pete Zaitcev <zaitcev@metabyte.com>
cc: <linux-kernel@vger.kernel.org>
Subject: ymfpci is 2.4.1-ac18
Message-ID: <Pine.LNX.4.33.0102191132020.797-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Pete!

I understand that you tried to implement the native synthesizer for YMF
PCI cards. Thank you for your efforts!

Unfortunately, it doesn't work for me. Linux 2.4.1-ac18 is compiled with
CONFIG_SOUND_YMFPCI=m and CONFIG_SOUND_YMFPCI_LEGACY=y.

When I load ymfpci, the kernel messages are:

ymfpci: YMF740C at 0xf4000000 IRQ 10
ac97_codec: AC97 Audio codec, id: 0x4144:0x5303 (Analog Devices AD1819)

I'm using devfs, so I can see what files appear in /dev/sound.

# ls -l /dev/sound/
total 0
crw-rw----    1 root     users     14,   4 Dec 31  1969 audio
crw-rw----    1 root     users     14,   3 Dec 31  1969 dsp
crw-rw----    1 root     users     14,   5 Dec 31  1969 dspW
crw-rw----    1 root     users     14,   0 Dec 31  1969 mixer
crw-rw----    1 root     users     14,   1 Dec 31  1969 sequencer
crw-rw----    1 root     users     14,   8 Dec 31  1969 sequencer2

However, I cannot use sequencer or sequencer2:

[proski@fonzie media]$ cat ode2joy.mid >/dev/sound/sequencer
bash: /dev/sound/sequencer: No such device or address
[proski@fonzie media]$ cat ode2joy.mid >/dev/sound/sequencer2
bash: /dev/sound/sequencer2: No such device or address

"No such device or address" is ENXIO. I added debug printk's near
all ENXIO in ymfpci.c, but neither of them has triggered.

If I load opl3, /dev/sound/sequencer becomes useful - cat doesn't exit and
dmesg shows:

/dev/music: Obsolete (4 byte) API was used by cat

Regards,
Pavel Roskin

