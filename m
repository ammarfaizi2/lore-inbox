Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271730AbRHUQMV>; Tue, 21 Aug 2001 12:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271729AbRHUQMB>; Tue, 21 Aug 2001 12:12:01 -0400
Received: from cr545978-a.nmkt1.on.wave.home.com ([24.112.25.43]:6663 "HELO
	saturn.tlug.org") by vger.kernel.org with SMTP id <S271728AbRHUQL4>;
	Tue, 21 Aug 2001 12:11:56 -0400
Date: Tue, 21 Aug 2001 12:12:11 -0400
From: Mike Frisch <mfrisch@saturn.tlug.org>
To: linux-kernel@vger.kernel.org
Subject: Strange emu10k1 behaviour on 2.4.9
Message-ID: <20010821121211.A21048@saturn.tlug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the emu10k1 support compiled as a module for 2.4.9.  When I use
the sound card, I have to adjust the volume or open the mixer for the
sound to actually start.  As soon as that program stops using the sound
card, the sound is turned off again.  It's not the volume level that
changes, but actually the sound is disabled or muted.

I have the following in /etc/modules.conf (as configured by 'sndconfig'
in RedHat 7.1):

alias sound-slot-0 emu10k1
post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L \
   >/dev/null 2>&1 || :
pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S \
 >/dev/null 2>&1 || :

lspci -v shows:

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 07)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at b400 [size=32]
        Capabilities: [dc] Power Management version 1

lsmod shows:

emu10k1                49648   1
ac97_codec              8928   0  [emu10k1]
soundcore               4144   4  (autoclean) [emu10k1]

If I use the latest ALSA driver, everything works fine (although I don't
think the sound quality is as good).

System: ASUS A7A266, AMD T-Bird 1.2/266, 256MB Crucial DDR, Intel EEPro
10/100 PCI, Matrox G400 AGP

Is is anybody else experiencing this problem?

Any assistance is appreciated.

Thanks,

Mike.
