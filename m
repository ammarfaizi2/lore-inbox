Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWAZOVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWAZOVA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWAZOVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:21:00 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:22181 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932333AbWAZOU7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:20:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PWZNxawlQet8MY315cN57UEGy8a3d3L5bCfje7gZXoQ/QnGRgouY8DHlL3e/DHE0Tgd2yi73OMsYr9QaDt/KpqZaXEyi6neUPvEhm+YviA/U+ilfu/dKz2OO828mvA+Y8ggQ7160DRvtU4EGNarO5TI9JJFZHbXqnd7fpw0DPqc=
Message-ID: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>
Date: Thu, 26 Jan 2006 16:20:58 +0200
From: Hai Zaar <haizaar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: vesa fb is slow on 2.6.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,
I have framebuffer problems with vanilla 2.6.15.1 - its very slow.
I'm using vesafb and booting with 'vga=795'.
I've used 2.6.11.12 before, and running 'cat
/usr/share/man/man1/bash.1' on tty1 took
12 seconds. Now, with 2.6.15.1 it takes 3 minutes.

Now the details of 2.6.15.1 system:

During boot I have:
PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:40:00.0

relevant snip of the .config
#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y

And as I've said, I boot with 'vga=795'. Graphics card is Nvidia
Quadro FX1500 (PCIE).

# lspci  -vv -s 40:00.0
40:00.0 VGA compatible controller: nVidia Corporation: Unknown device
00ce (rev a2) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation: Unknown device 0243
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (64-bit, prefetchable) [size=128M]
	Region 3: Memory at f9000000 (64-bit, non-prefetchable) [size=16M]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] #10 [0001]

# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
reg03: base=0x100000000 (4096MB), size= 512MB: write-back, count=1
reg04: base=0xfeda0000 (4077MB), size= 128KB: uncachable, count=1

No 'write-combining' entry! But with 2.6.11.12 I do have one:
<2.6.11.12 system> cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
reg03: base=0x100000000 (4096MB), size= 512MB: write-back, count=1
reg04: base=0xfeda0000 (4077MB), size= 128KB: uncachable, count=1
reg05: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=1


Where to continue to?
P.S. I'm not on the list, so please CC me.
--
Zaar
