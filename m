Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbSJ0BKO>; Sat, 26 Oct 2002 21:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSJ0BKO>; Sat, 26 Oct 2002 21:10:14 -0400
Received: from SMTP7.andrew.cmu.edu ([128.2.10.87]:24710 "EHLO
	smtp7.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S261845AbSJ0BKN>; Sat, 26 Oct 2002 21:10:13 -0400
Date: Sat, 26 Oct 2002 21:16:31 -0400 (EDT)
From: Paul Komarek <komarek@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
cc: komarek@cmu.edu
Message-ID: <Pine.LNX.4.44L-027.0210262039510.6016-100000@unix46.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat Jul 27 2002 - 22:00:06 EST,  mdoelle@linux-user.de wrote:
> this patch for Kernel 2.4.19-rc3 removes the "break" that aborted the
> module init of i810_audio.o in case of "not ready" status before probing
> (line 2656-2663).  On my Epox 4G4A+ mainboard with i845G chipset the

Mirko's patch was sufficient to make sound work on a Dell 4550.

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev
01)
	Subsystem: Dell Computer Corporation: Unknown device 0142
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at d800 [size=256]
	I/O ports at dc40 [size=64]
	Memory at fe300400 (32-bit, non-prefetchable) [size=512]
	Memory at fe300000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

Before commenting out the "break" line, the syslogs were filling with
these messages:

------------------------------------------------------------------
Oct 25 20:48:34 liuting kernel: Intel 810 + AC97 Audio, version 0.22,
                                13:45:06 Sep  4 2002
Oct 25 20:48:34 liuting kernel: PCI: Found IRQ 11 for device 00:1f.5
Oct 25 20:48:34 liuting kernel: PCI: Sharing IRQ 11 with 00:1f.3
Oct 25 20:48:34 liuting kernel: PCI: Setting latency timer of device
                                00:1f.5 to 64
Oct 25 20:48:34 liuting kernel: i810: Intel ICH4 found at IO 0xdc40 and
                                0xd800, IRQ 11
Oct 25 20:48:35 liuting insmod:
               /lib/modules/2.4.18-14/kernel/drivers/sound/i810_audio.o:
               init_module: No such device
Oct 25 20:48:35 liuting insmod: Hint: insmod errors can be caused by
      incorrect module parameters, including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
Oct 25 20:48:35 liuting insmod:
         /lib/modules/2.4.18-14/kernel/drivers/sound/i810_audio.o: insmod
         sound-slot-0 failed
Oct 25 20:48:35 liuting kernel: i810_audio: Codec not ready.. wait.. no
                                response.
Oct 25 20:48:35 liuting kernel: i810_audio: Audio Controller supports 6
                                channels.
Oct 25 20:48:35 liuting kernel: i810_audio: Defaulting to base 2 channel
                                mode.
Oct 25 20:48:35 liuting kernel: i810_audio: Primary codec not ready.
Oct 25 20:48:35 liuting modprobe: modprobe: Can't locate module
sound-service-0-3
Oct 25 20:48:35 liuting firstboot: sox: Can't open output file '/dev/dsp':
No such device
------------------------------------------------------------------

-Paul Komarek

