Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbVHPLcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbVHPLcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 07:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbVHPLcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 07:32:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:41931 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932642AbVHPLcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 07:32:46 -0400
X-Authenticated: #26200865
Message-ID: <4301CEEE.5050303@gmx.net>
Date: Tue, 16 Aug 2005 13:33:02 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: intel_agp resume problems
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

after suspend-to-ram and a subsequent resume the configuration
of my AGP bridge/controller is different and X will refuse to
start after resume if it wasn't running during suspend. I'm
using radeonfb as console driver and kernel 2.6.13-rc6-git6.

Diff between lspci -vvvxxx before and after suspend follows.

--- lspci.radeonfb_beforeS3     2005-08-16 13:23:31.000000000 +0200
+++ lspci.radeonfb_afterS3      2005-08-16 13:23:31.000000000 +0200
@@ -1,353 +1,349 @@
 0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 21)
        Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Capabilities: [e4] #09 [4104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
-               Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4
+               Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
 00: 86 80 40 33 06 01 90 20 21 00 00 06 00 00 00 00
 10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 14 0c c0
 30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00
 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 50: 00 02 00 00 00 00 00 00 00 00 00 00 00 27 00 00
 60: 04 08 0c 10 00 00 00 00 00 00 00 00 00 00 00 00
 70: 02 02 00 00 00 00 00 00 00 00 02 2d 71 32 40 30
 80: 71 00 80 05 00 00 00 00 00 10 01 00 00 00 00 00
-90: 10 11 11 00 01 13 11 00 41 19 00 00 00 0a 3d 00
-a0: 02 00 20 00 17 02 00 1f 04 00 00 00 00 00 00 00
+90: 10 11 11 00 01 13 11 00 41 19 00 00 00 1a 3d 00
+a0: 02 00 20 00 17 02 00 1f 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 e0 1b 20 10 00 00
 c0: 44 40 50 11 00 20 05 06 00 00 00 00 00 00 00 00
 d0: 02 28 00 0e 0b 00 00 30 00 00 31 b5 00 00 02 00
 e0: 00 00 00 00 09 a0 04 41 00 00 00 00 00 00 00 00
 f0: 00 00 01 00 74 f8 20 80 38 0f 21 00 04 00 00 00

 0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 21) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 96
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d0100000-d01fffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        Expansion ROM at 00003000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
 00: 86 80 41 33 07 01 a0 00 21 00 04 06 00 60 01 00
-10: 00 00 00 00 00 00 00 00 00 01 01 40 30 30 a0 22
+10: 00 00 00 00 00 00 00 00 00 01 01 40 30 30 a0 02
 20: 10 d0 10 d0 00 d8 f0 df 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00
 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Do you have any hints how to solve the problem?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
