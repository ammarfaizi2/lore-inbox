Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbUKTIDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUKTIDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 03:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUKTIDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 03:03:16 -0500
Received: from hentges.net ([81.169.178.128]:53692 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S261238AbUKTIBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 03:01:48 -0500
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some
	machines
From: Matthias Hentges <mailinglisten@hentges.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1100936059.5238.3.camel@gaston>
References: <1100811950.3470.23.camel@mhcln03>
	 <20041119115507.GB1030@elf.ucw.cz> <1100872578.3692.7.camel@mhcln03>
	 <1100872578.3692.7.camel@mhcln03> <1100905563.3812.59.camel@gaston>
	 <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
	 <1100921760.3561.1.camel@mhcln03>  <1100936059.5238.3.camel@gaston>
Content-Type: multipart/mixed; boundary="=-i6aurusIAZA34bWzjYwV"
Date: Sat, 20 Nov 2004 09:01:46 +0100
Message-Id: <1100937706.3497.11.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-i6aurusIAZA34bWzjYwV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Samstag, den 20.11.2004, 18:34 +1100 schrieb Benjamin Herrenschmidt:
> On Sat, 2004-11-20 at 04:36 +0100, Matthias Hentges wrote:
> > Am Samstag, den 20.11.2004, 02:43 +0000 schrieb Matthew Garrett:
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > 

[...]

> > Trying to resume with radeonfb or X (DRI or fglrx) causes the machine
> > to freeze upon a resume.
> 
> At what point does it freeze ? Is the display back before the freeze ?

Sadly the video *never* comes back and stays dark no matter what I try:
- boot-radeon (int10 POST call) doesn't work. Either it segfaults or 
  it hangs the machine
- Any combination of radeontool light on|off doesn't help (no freeze,
sometimes it 
  can't read the cards mem address??)
- The int10 radeon patch for X11 doesn't help (freeze)
- radeonfb and / or X (either patched w/ int10 or not) freeze the
machine

I'm running out of ideas with this darn thing.
Since the serial port doesn't come back from S3 either, even a serial
console is of no help.

I have attached the output of lspci -vvv before and after resuming from
S3
The latter shows lots of "[disabled]" entries. Is that of any use?

Thanks
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-i6aurusIAZA34bWzjYwV
Content-Disposition: attachment; filename=lspci-vvv_after_s3.txt
Content-Type: text/plain; name=lspci-vvv_after_s3.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV250 5c63 [Radeon Mobility 9200 M9+] (rev 01) (prog-if 00 [VGA])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [disabled] [size=128M]
	Region 1: I/O ports at 3000 [disabled] [size=256]
	Region 2: [virtual] Memory at d0100000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
--=-i6aurusIAZA34bWzjYwV
Content-Disposition: attachment; filename=lspci-vvv_before_s3.txt
Content-Type: text/plain; name=lspci-vvv_before_s3.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV250 5c63 [Radeon Mobility 9200 M9+] (rev 01) (prog-if 00 [VGA])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

--=-i6aurusIAZA34bWzjYwV--

