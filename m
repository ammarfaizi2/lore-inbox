Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbTDOBwZ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 21:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264038AbTDOBwZ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 21:52:25 -0400
Received: from h80ad2716.async.vt.edu ([128.173.39.22]:14464 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264028AbTDOBwY (for <RFC822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 21:52:24 -0400
Message-Id: <200304150203.h3F23SlZ001955@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/02/2003 with nmh-1.0.4+dev
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, seanlkml@rogers.com,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: [CFT] Hopefully fix PCMCIA boot deadlocks 
In-Reply-To: Your message of "Tue, 15 Apr 2003 00:55:03 +0200."
             <1050360903.677.3.camel@teapot.felipe-alfaro.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030414165057.C22754@flint.arm.linux.org.uk>
            <1050360903.677.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_25867588P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Apr 2003 22:03:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_25867588P
Content-Type: text/plain; charset=us-ascii

On Tue, 15 Apr 2003 00:55:03 +0200, Felipe Alfaro Solana said:
> On Mon, 2003-04-14 at 17:50, Russell King wrote:
> > Ok,
> > 
> > Here's my latest patch against 2.5.67 which introduces a proper state
> > machine into the PCMCIA layer for handling the sockets.  Unfortunately,
> > I fear that this isn't the answer for the following reasons:
> 
> Well, maybe it's not the answer, but it's working for me with
> 2.5.67-mm3. Besides being too verbose, I have tried booting with the
> card plugged, booting with the card unplugged and then plugging it, and
> plugging/unplugging it several time to check that hotplug is working.

Confirmed under vanilla 2.5.67 on a Dell C840.  It's chatty, and I'll
not comment on the neatness of implementation.  But... ;)

It now boots with the offending card, without it, insert it, eject it, I
haven't been able to confuse it (though I admit I havent tried a very fast
insert/eject cycle so the eject arrives before the insert finishes).  And yes,
the card in question was a multifunction (abbreviated lspci -vv output):

03:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
        Subsystem: Xircom Cardbus Ethernet 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1000 [size=128]
        Region 1: Memory at 10800000 (32-bit, non-prefetchable) [size=2K]
        Region 2: Memory at 10800800 (32-bit, non-prefetchable) [size=2K]
        Expansion ROM at 10400000 [disabled] [size=16K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03) (prog-if 02 [16550])
        Subsystem: Xircom CBEM56G-100 Ethernet + 56k Modem
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1080 [size=8]
        Region 1: Memory at 10801000 (32-bit, non-prefetchable) [size=2K]
        Region 2: Memory at 10801800 (32-bit, non-prefetchable) [size=2K]
        Expansion ROM at 10404000 [disabled] [size=16K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

Thanks Russell!

--==_Exmh_25867588P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+m2hucC3lWbTT17ARAsgJAKDojv5eI8EIA8FhIvcAYVZ0AST3vACfRBnm
hMqqW+iWS1sAFacnyRj0DUg=
=mQh3
-----END PGP SIGNATURE-----

--==_Exmh_25867588P--
