Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbVINFKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVINFKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 01:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbVINFKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 01:10:12 -0400
Received: from outmx016.isp.belgacom.be ([195.238.2.115]:37568 "EHLO
	outmx016.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S965010AbVINFKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 01:10:10 -0400
From: Jan De Luyck <lkml@kcore.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: ACPI S3 and ieee1394 don't get along
Date: Wed, 14 Sep 2005 07:08:11 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Pavel Machek <pavel@suse.cz>
References: <200509131156.31914.lkml@kcore.org> <43276C2D.2000901@s5r6.in-berlin.de>
In-Reply-To: <43276C2D.2000901@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8A7JDALDLJxlBO5"
Message-Id: <200509140708.12281.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_8A7JDALDLJxlBO5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 14 September 2005 02:17, Stefan Richter wrote:
> Jan De Luyck wrote:
> > after putting my laptop into S3 and reviving it at home, the firewire
> > interface was unusable, no response when plugging in my external disk,
> > loading sbp2 manually didn't trigger anything.
>
> [...]
>
> > I saw this thread:
> > http://marc.theaimsgroup.com/?l=linux1394-user&m=111262313930798&w=2
> > tho I'm not sure if it's relevant to this.
>
> IEEE 1394 power management (i.e. management of bus power consumption or
> of other nodes' internal power states) is not related to ACPI suspend/
> resume of the local controller AFAICS.

I thought so. It was the only thing even remotely relevant I found on the mailinglists tho.

> According to your log, the cause is to be looked for in ohci1394's
> purely hardware related parts or perhaps even outside of the ieee1394
> subsystem.

I've attached the lspci -vvx before and after suspending to S3. There are a lot of differences, 
but I have no idea how to interprete them :/

Here's what the diff gives:
devilkin@precious:/tmp$ diff -Nur before-s3 after-s3 
--- before-s3   2005-09-14 07:05:58.797920320 +0200
+++ after-s3    2005-09-14 07:05:10.226304328 +0200
@@ -1,16 +1,15 @@
 0000:02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
-       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
+       Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
-       Latency: 64 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 10
-       Region 0: Memory at d0209000 (32-bit, non-prefetchable) [size=2K]
-       Region 1: Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
+       Region 0: [virtual] Memory at d0209000 (32-bit, non-prefetchable) [size=2K]
+       Region 1: [virtual] Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
-               Status: D0 PME-Enable- DSel=0 DScale=0 PME+
-00: 4c 10 26 80 16 01 10 02 00 10 00 0c 08 40 00 00
-10: 00 90 20 d0 00 00 20 d0 00 00 00 00 00 00 00 00
+               Status: D0 PME-Enable- DSel=0 DScale=0 PME-
+00: 4c 10 26 80 02 00 10 02 00 10 00 0c 00 00 00 00
+10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
-30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 02 04
+30: 00 00 00 00 44 00 00 00 00 00 00 00 00 01 02 04


-- 
Honi soit la vache qui rit.

--Boundary-00=_8A7JDALDLJxlBO5
Content-Type: text/plain;
  charset="iso-8859-1";
  name="after-s3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="after-s3"

0000:02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: [virtual] Memory at d0209000 (32-bit, non-prefetchable) [size=2K]
	Region 1: [virtual] Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 26 80 02 00 10 02 00 10 00 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 01 02 04


--Boundary-00=_8A7JDALDLJxlBO5
Content-Type: text/plain;
  charset="iso-8859-1";
  name="before-s3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="before-s3"

0000:02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0209000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
00: 4c 10 26 80 16 01 10 02 00 10 00 0c 08 40 00 00
10: 00 90 20 d0 00 00 20 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 1f 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 02 04


--Boundary-00=_8A7JDALDLJxlBO5--
