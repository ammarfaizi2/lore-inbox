Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278667AbRKDEsd>; Sat, 3 Nov 2001 23:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278678AbRKDEsW>; Sat, 3 Nov 2001 23:48:22 -0500
Received: from nic-131-c196-222.mw.mediaone.net ([24.131.196.222]:36869 "EHLO
	moonweaver.awesomeplay.com") by vger.kernel.org with ESMTP
	id <S278667AbRKDEsJ>; Sat, 3 Nov 2001 23:48:09 -0500
Subject: Via Onboard Audio - Round #2
From: Sean Middleditch <elanthis@awesomeplay.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100 (Preview Release)
Date: 03 Nov 2001 23:52:38 -0500
Message-Id: <1004849558.457.15.camel@stargrazer>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

OK, I seemed to have made a realization:

When the via82cxxx_audio driver loads (this is in 2.4.12, Debian
version, which I think is Linus tree with a couple patches), I get these
errors (which I also think I had on the RH kernels, tho I can't exactly
check that anymoe, since RH is gone):

IEQ routing conflict for 00:07.5, have irq 5, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
PCI: Sharing IRQ 11 with 00.0b.0
via82cxxx: timeout while reading AC97 codec (0xAA0000)
via82cxxx: timeout while reading AC97 codec (0xAA0000)
via82cxxx: Codec rate locked at 48Khz
via82cxxx: timeout while reading AC97 codec (0x800000)
ac97_codec: AC97  codec, id: 0x4144:0x5361 (Unknown)
via82cxxx: board #1 at 0x1000, IRQ 5

(note, those were hand typed, I'm writing this up on my workstation not
the laptop, so no cut and paste, and I'm too lazy to deal with floppies
at the moment).

In /proc/pci, the audio board is at IRQ 5, device 9 on bus 9.
lspci says it is device 00:07.5 (as does the above notice).

pcitweak -l  reports, for the device:
PCI: 00:07.5: chip 1106,3058 card 0e11,0097 rev 50 class 04,01,00 hdr 00

In any event, I'm thinking perhaps there is an IRQ conflict happening
here?  I looked in the BIOS, and the BIOS gives me *no* options relating
to IRQ's (All I see are a couple lpt options, boot order, and
suspend/resume disabling).  I tried modprobe via82cxx_audio irq=5  but
that gave me errors about the irq option not being valid.  How can I
force the IEQ to 5, or 11, or whatever other IRQ I want?

Also, Pierre Rousselet suggested there may be memory issues.  Although
2.4.12 has never given me problems, 2.4.13 crashed and burned, the 2.4.7
that came with RH 7.2 crashed and burned, I never had problems with
2.4.9, no problems with 2.2.17 (Debian install) although I didn't run
those last too for long at all, and 2.2.19 seemed to choke when I loaded
my nic dirver (8139too).  I don't know if those were all related to
kernel bugs (the 2.2.19 was only on the nic, and only a couple 2.4.x
gave me issues).  In any event, the reason I bought this laptop over a
better linux-supported one was the price, which was due to the fact it
was a returned laptop, leading me to believe there is a good chance the
memory *may* be bad, although again I have had no problems with some
kernels, even after having it run for hours.

Anyways, how could I better debug memory?  I've managed some mean
compilations on the good kernels, and seen C++ compiler crash horribly
on 2.4.13.  That's the best memory tester I know of.  ~,^

Again, I'm not on the list, way too much mental strain with all that
traffic.  CC replies to me, please.

Thanks again everyone for all your excellent help!
Sean Etc.

