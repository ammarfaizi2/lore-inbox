Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBGX0j>; Wed, 7 Feb 2001 18:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBGX0a>; Wed, 7 Feb 2001 18:26:30 -0500
Received: from finch-post-11.mail.demon.net ([194.217.242.39]:50444 "EHLO
	finch-post-11.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129027AbRBGX0V>; Wed, 7 Feb 2001 18:26:21 -0500
Date: Wed, 7 Feb 2001 23:19:58 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: VIA silent disk corruption - patch
Message-ID: <20010207231958.A3003@colonel-panic.com>
Mail-Followup-To: pdh, linux-kernel@vger.kernel.org
In-Reply-To: <20010206085223.A28894@zenos.local.farnsworth.org> <3A801FEA.E622B306@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A801FEA.E622B306@Hell.WH8.TU-Dresden.De>; from sorisor@Hell.WH8.TU-Dresden.De on Tue, Feb 06, 2001 at 05:01:46PM +0100
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 05:01:46PM +0100, Udo A. Steinberg wrote:
> Dale Farnsworth wrote:
> > 
> > However, if I enable the BIOS parameter "I/O Recovery Time", I can still
> > enable read caching without seeing any data corruption.
> > The lastest BIOS revision (1005C) enables "I/O Recovery Time" by default
> > where the previous revision I had (1004D) did not.
> 
> Interesting stuff.
> 
> Asus, Germany released 1005D today. It's available from
> ftp://ftp.asuscom.de/pub/ASUSCOM/BIOS/Socket_A/VIA_Chipset/Apollo_KT133/A7V/1005D.zip
> 
> No comments about what they changed and/or fixed.
> 

Good news here, looks like the new BIOS fixes it (1005D). I've run a
heavy test for at least 10 hours without a single blip. The BIOS is set
for "optimal". Hoorah!

Here's the North bridge diff for anyone who can't get a BIOS update :-)

P.

--- bad.pci	Sun Feb  4 22:29:22 2001
+++ new.pci	Wed Feb  7 23:11:28 2001
@@ -1,7 +1,7 @@
 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
 	Subsystem: Asustek Computer, Inc.: Unknown device 8033
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
-	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
+	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
 	Latency: 0 set
 	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
 	Capabilities: [a0] AGP version 2.0
@@ -10,13 +10,13 @@
 	Capabilities: [c0] Power Management version 2
 		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
-00: 06 11 05 03 06 00 10 a2 02 00 00 06 00 00 00 00
+00: 06 11 05 03 06 00 10 22 02 00 00 06 00 00 00 00
 10: 08 00 00 e4 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 33 80
 30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-50: 17 a4 6b b4 4f 81 08 08 80 00 04 08 08 08 08 08
-60: 03 ff 00 a0 52 e5 e5 00 44 7c 86 0f 08 3f 00 00
+50: 17 a4 6b b4 07 28 08 08 80 00 04 08 08 08 08 08
+60: 03 ff 55 a0 52 e5 e5 00 44 7c 86 0f 08 3f 00 00
 70: de 80 cc 0c 0e a1 d2 00 01 b4 11 02 00 00 00 00
 80: 0f 40 00 00 c0 00 00 00 02 00 00 00 00 00 00 00
 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
