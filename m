Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283686AbRK3Pkq>; Fri, 30 Nov 2001 10:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283685AbRK3Pkf>; Fri, 30 Nov 2001 10:40:35 -0500
Received: from smtp1.libero.it ([193.70.192.51]:14738 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S283686AbRK3PkU>;
	Fri, 30 Nov 2001 10:40:20 -0500
Date: Fri, 30 Nov 2001 16:40:31 +0100
From: Emmanuele Bassi <emmanuele.bassi@iol.it>
To: linux-kernel@vger.kernel.org
Subject: Deadlock on kernels > 2.4.13-pre6
Message-ID: <20011130164031.A8741@wolverine.lohacker.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Mailer: Mutt 1.3.23i (2001-10-09)
X-OS: Linux 2.4.13-pre6 i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I've recently compiled and tested each kernel since 2.4.13-pre6[0], and
I've noticed a recurrent (and reproducible[1]) deadlock on my system
when I try to play an mp3[2].

It occurs randomly, i.e. not after a precise amount of time the mp3 is
playing, but each and every time I try to play an mp3 file, my box
suddenly ``freeze'': no life signs at all (SysRq keys, network, even via
a serial terminal), no Oops, no trace in logs. The box simply `dies'.

I've tried hundreds of combinations, trying to understand where the
problem lies, and I've come up with... er... nothing...

o       it's not ext3: even vanilla kernels lock up;
o       it's not an hardware problem: I've tested my RAM and compiled
        kernels over kernels with (and without) optimization;
o       kernels <= 2.4.13-pre6 works properly;
o       it's not the player/library fault: I've tried many
	players, on different libraries; besides, a user-level program
	shouldn't cause such deadlocks;
o       every other operation on kernels > 2.4.13-pre6 works quite well
	(this new VM is *great*), *except* when I try to listen a
	mp3[3]: that always leads to disaster.

So far, I've excluded everything but a bug in the OSS sound drivers,
but, according to the ChangeLogs, they did not change from 2.4.13-pre6
(the last working kernel) to 2.4.13.

TIA.

+++

[0] Mainly, because it was the first kernel with the new VM and with the
ext3 patch available, excluding 2.4.10.

[1] At least, on my box.

[2] I use a SoundBlaster AWE64 (ISA) perfectly recognized both by isapnp
and 2.4.x kernels, using OSS modules. Yes, I've also tried not to use
modules. No, I did not try ALSA. Yes, the card works perfectly.

[3] Any other format, except .MOD files, works perfectly. And that's why
I suspect the sequencer code.

Bye,
 Emmanuele.
 

-- 
Emmanuele Bassi (Zefram)               [ http://digilander.iol.it/ebassi ]
GnuPG Key fingerprint = 4DD0 C90D 4070 F071 5738  08BD 8ECC DB8F A432 0FF4
