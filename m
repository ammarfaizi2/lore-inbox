Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132401AbQLJTPc>; Sun, 10 Dec 2000 14:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132456AbQLJTPW>; Sun, 10 Dec 2000 14:15:22 -0500
Received: from 12-36-4-15.velocityhsi.com ([12.36.4.15]:61940 "EHLO
	lydia.adaptive.net") by vger.kernel.org with ESMTP
	id <S132401AbQLJTPL>; Sun, 10 Dec 2000 14:15:11 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.2.18pre25 + i810e audio: IRQ 0? (BIOS bug?)
From: soma@cs.unm.edu (Anil B. Somayaji)
Date: 10 Dec 2000 11:44:44 -0700
Message-ID: <ut2g0jwce03.fsf@lydia.adaptive.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This weekend I've been installing Debian 2.2 on an HP Pavilion 8756C,
and I haven't been able to get sound working.  The machine has an
Intel 810e multifunction contoller onboard.  The i810_audio module
seems to be able to find the right device, but can't seem to use it
because it reports IRQ 0.

To me, this sounds like the BIOS isn't properly configuring the
device; however, I've already set the installed OS in the BIOS to
other (which I had to do to get the ethernet card's IRQ properly
initialized).  I've also set the "Audio Codec" BIOS option to
"Enabled," which I assumed would do the appropriate device
initialization.  (If that is set to Disabled, then the driver doesn't
even find a device.)

I've also have tried using setpci to set the IRQ, but with no
success.  I'm not sure if I'm setting the right device, because the
output of lspci doesn't change (although specific IRQ queries do).
The command I'm using is "setpci -s 0:.5 interrupt_line=9".  A
device_id query returns 2415, which seems to be the right device based
on the output of lspci.

Below I've included the relevant parts of the kernel log and the
output of lspci -vv.  So, does anyone have a clue what's going on?

Thanks!

  --Anil


  Dec 10 11:12:03 floyd kernel: Intel 810 + AC97 Audio, version 0.17,
    05:53:45 Dec 9 2000
  Dec 10 11:12:03 floyd kernel: PCI: Increasing latency timer of device
    00:fd to 64
  Dec 10 11:12:03 floyd kernel: i810: Intel ICH 82801AA found at IO
    0x1300 and 0x1200, IRQ 0
  Dec 10 11:12:03 floyd kernel: i810_audio: unable to allocate irq 0
  Dec 10 11:12:03 floyd kernel: i810_audio: Found 0 audio device(s).
  Dec 10 11:12:03 floyd kernel: i810_audio: No devices found.

  00:1f.5 Multimedia audio controller: Intel Corporation: Unknown
        device 2415 (rev 02)
        Subsystem: Intel Corporation: Unknown device 5643
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
          ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
          >TAbort- <TAbort - <MAbort- >SERR- <PERR-
        Latency: 0 set
        Interrupt: pin B routed to IRQ 0
        Region 0: I/O ports at 1200
        Region 1: I/O ports at 1300

- -- 
Anil Somayaji (soma@cs.unm.edu)
http://www.cs.unm.edu/~soma
+1 505 872 3150
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)

iEYEARECAAYFAjozzxoACgkQXOpXEmNZ3Sfw8ACgia81DDx5vrw8rmtU4XjlJdxk
FJUAnjyRIZVD3GpIJMxkMNbIiAYbuZmu
=wd+7
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
