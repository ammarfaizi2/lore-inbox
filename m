Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbRBETzl>; Mon, 5 Feb 2001 14:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131368AbRBETzc>; Mon, 5 Feb 2001 14:55:32 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:54536 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129232AbRBETz0>; Mon, 5 Feb 2001 14:55:26 -0500
Date: Mon, 5 Feb 2001 19:53:31 +0000
To: linux-kernel@vger.kernel.org
Subject: VIA silent disk corruption - bad news
Message-ID: <20010205195331.A736@colonel-panic.com>
Mail-Followup-To: pdh, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch doesn't work for me. Maybe I need to disable some more of
those North bridge features :-(

Oh bum. Back to testing with "normal" ...

P.

-----  CORRUPTING SETUP  -----

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 8033
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0 set
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=421
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 05 03 06 00 10 a2 02 00 00 06 00 00 00 00
10: 08 00 00 e4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 33 80
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 17 a4 6b b4 4f 81 08 08 80 00 04 08 08 08 08 08
60: 03 ff 00 a0 52 e5 e5 00 44 7c 86 0f 08 3f 00 00
70: de 80 cc 0c 0e a1 d2 00 01 b4 11 02 00 00 00 00
80: 0f 40 00 00 c0 00 00 00 02 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 c0 20 00 07 02 00 1f 00 00 00 00 6e 02 04 00
b0: 59 ec 80 b5 32 33 28 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 0e 22 00 00 00 00 00 91 06

-----  DIFF FOR NON-CORRUPTING SETUP  -----

@@ -5,7 +5,7 @@
 	Latency: 0 set
 	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
 	Capabilities: [a0] AGP version 2.0
-		Status: RQ=31 SBA+ 64bit- FW- Rate=421
+		Status: RQ=31 SBA+ 64bit- FW- Rate=21
 		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=
 	Capabilities: [c0] Power Management version 2
 		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
@@ -15,12 +15,12 @@
 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 33 80
 30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-50: 17 a4 6b b4 4f 81 08 08 80 00 04 08 08 08 08 08
-60: 03 ff 00 a0 52 e5 e5 00 44 7c 86 0f 08 3f 00 00
-70: de 80 cc 0c 0e a1 d2 00 01 b4 11 02 00 00 00 00
+50: 17 a4 6b b4 06 81 08 08 80 00 04 08 08 08 08 08
+60: 03 ff 00 a0 50 e4 e4 00 40 78 86 0f 08 3f 00 00
+70: d8 80 cc 0c 0e a1 d2 00 01 b4 01 02 00 00 00 00
 80: 0f 40 00 00 c0 00 00 00 02 00 00 00 00 00 00 00
 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-a0: 02 c0 20 00 07 02 00 1f 00 00 00 00 6e 02 04 00
+a0: 02 c0 20 00 03 02 00 1f 00 00 00 00 6e 02 00 00
 b0: 59 ec 80 b5 32 33 28 00 00 00 00 00 00 00 00 00
 c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
